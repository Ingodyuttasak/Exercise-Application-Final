import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/model/ranking_model.dart';
import 'package:mobile_final/model/user_model.dart';

class friendRanking extends StatefulWidget {
  const friendRanking({Key? key}) : super(key: key);

  @override
  _friendRankingState createState() => _friendRankingState();
}

class _friendRankingState extends State<friendRanking> {
  List<RankScoreModel> rankScoreModelMild = [];
  List<RankScoreModel> rankScoreModelModer = [];
  List<RankScoreModel> rankScoreModelStren = [];

  List<RankScoreModel> modelTest = [];
  List<RankScoreModel> modelTest1 = [];
  List<RankScoreModel> modelTest2 = [];

  int rankCount = 0,
      rankCount1 = 0,
      rankCount2 = 0,
      irank = 0,
      myrank = 0,
      irank1 = 0,
      myrank1 = 0,
      irank2 = 0,
      myrank2 = 0;
  bool sT = true, sT1 = true, sT2 = true, sT3 = true;

  RankScoreModel? userRankMild;
  RankScoreModel? userRankModer;
  RankScoreModel? userRankStren;

  Future findFriendsRank() async {
    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      String uid = event!.uid;
      await FirebaseFirestore.instance
          .collection('mildranking')
          .orderBy('sumScoreRank', descending: true)
          .get()
          .then((value) {
        setState(() {
          for (var item in value.docs) {
            RankScoreModel model = RankScoreModel.fromMap(item.data());
            setState(() {
              modelTest.add(model);
            });
          }
          FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .collection('friends')
              .get()
              .then((value) {
            for (var i = 0; i < modelTest.length; i++) {
              irank++;
              for (var item in value.docs) {
                UserModel model = UserModel.fromMap(item.data());
                setState(() {
                  if (modelTest[i].uidUser == uid && sT1) {
                    rankScoreModelMild.add(modelTest[i]);
                    myrank = irank;
                    userRankMild = modelTest[i];
                    sT1 = false;
                  } else if (modelTest[i].uidUser == model.uid) {
                    rankScoreModelMild.add(modelTest[i]);
                  }
                });
              }
            }
            //end mild
          }).then((values) {
            FirebaseFirestore.instance
                .collection('moderrateranking')
                .orderBy('sumScoreRank', descending: true)
                .get()
                .then((value) {
              setState(() {
                for (var item in value.docs) {
                  RankScoreModel model = RankScoreModel.fromMap(item.data());
                  setState(() {
                    modelTest1.add(model);
                  });
                }
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(uid)
                    .collection('friends')
                    .get()
                    .then((value) {
                  for (var i = 0; i < modelTest1.length; i++) {
                    irank1++;
                    for (var item in value.docs) {
                      UserModel model = UserModel.fromMap(item.data());
                      setState(() {
                        if (modelTest1[i].uidUser == uid && sT2) {
                          rankScoreModelModer.add(modelTest1[i]);
                          myrank1 = irank1;
                          userRankModer = modelTest1[i];
                          sT2 = false;
                        } else if (modelTest1[i].uidUser == model.uid) {
                          rankScoreModelModer.add(modelTest1[i]);
                        }
                      });
                    }
                  }
                }).then((values) {
                  FirebaseFirestore.instance
                      .collection('strenuousranking')
                      .orderBy('sumScoreRank', descending: true)
                      .get()
                      .then((value) {
                    for (var item in value.docs) {
                      RankScoreModel model =
                          RankScoreModel.fromMap(item.data());
                      setState(() {
                        modelTest2.add(model);
                      });
                    }
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .collection('friends')
                        .get()
                        .then((value) {
                      for (var i = 0; i < modelTest2.length; i++) {
                        irank2++;
                        for (var item in value.docs) {
                          UserModel model = UserModel.fromMap(item.data());
                          setState(() {
                            if (modelTest2[i].uidUser == uid && sT3) {
                              rankScoreModelStren.add(modelTest2[i]);

                              myrank2 = irank2;
                              userRankStren = modelTest2[i];
                              sT3 = false;
                            } else if (modelTest2[i].uidUser == model.uid) {
                              rankScoreModelStren.add(modelTest2[i]);
                            }
                            if (rankScoreModelStren.length ==
                                (value.size + 1)) {
                              sT = false;
                            }
                          });
                        }
                      }
                    });
                  });
                });
              });
            });
          });
        });
      });
    });
  }

  Widget mildRank() {
    return Container(
      height: 450,
      width: 400,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.greenAccent),
          boxShadow: [
            BoxShadow(
              color: Colors.greenAccent.shade100,
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 0),
            )
          ]),
      child: SingleChildScrollView(
        child: Column(
          children: rankScoreModelMild.map((e) {
            return Container(
              child: Column(
                children: [
                  Container(
                    height: 90,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 0,
                          child: Text(
                            "${(++rankCount)}",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 1,
                          child: CircleAvatar(
                            minRadius: 0,
                            maxRadius: 40,
                            backgroundColor: Colors.blue.shade100,
                            child: CircleAvatar(
                              radius: 90,
                              backgroundColor: Colors.transparent,
                              child: ClipOval(
                                child: Image.network(
                                  "${e.imagePro}",
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "${e.userRank.toString()}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text("${e.sumScoreRank}",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget moderRank() {
    return Container(
      height: 450,
      width: 400,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.orangeAccent),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.shade200,
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 0),
            )
          ]),
      child: SingleChildScrollView(
        child: Column(
          children: rankScoreModelModer.map((f) {
            return Container(
              child: Column(
                children: [
                  Container(
                    height: 90,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 0,
                          child: Text(
                            "${(++rankCount1)}",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 1,
                          child: CircleAvatar(
                            minRadius: 0,
                            maxRadius: 40,
                            backgroundColor: Colors.blue.shade100,
                            child: CircleAvatar(
                              radius: 90,
                              backgroundColor: Colors.transparent,
                              child: ClipOval(
                                child: Image.network(
                                  "${f.imagePro}",
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "${f.userRank.toString()}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text("${f.sumScoreRank}",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget stenRank() {
    return Container(
      height: 450,
      width: 400,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.red),
          boxShadow: [
            BoxShadow(
              color: Colors.redAccent.shade400,
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 0),
            )
          ]),
      child: SingleChildScrollView(
        child: Column(
          children: rankScoreModelStren.map((f) {
            return Container(
              child: Column(
                children: [
                  Container(
                    height: 90,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 0,
                          child: Text(
                            "${(++rankCount2)}",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 1,
                          child: CircleAvatar(
                            minRadius: 0,
                            maxRadius: 40,
                            backgroundColor: Colors.blue.shade100,
                            child: CircleAvatar(
                              radius: 90,
                              backgroundColor: Colors.transparent,
                              child: ClipOval(
                                child: Image.network(
                                  "${f.imagePro}",
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "${f.userRank.toString()}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text("${f.sumScoreRank}",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    findFriendsRank();
  }

  Widget build(BuildContext context) => DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(
                icon: Image.asset('assets/images/worldrank1.png'),
                iconSize: 60,
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
            backgroundColor: Colors.limeAccent[100],
            foregroundColor: Colors.black,
            title: Text("อันดับการแข่งขันเพื่อน"),
            bottom: TabBar(
                unselectedLabelColor: Colors.redAccent,
                labelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.greenAccent.shade100,
                      Colors.orangeAccent.shade100,
                      Colors.redAccent.shade100
                    ]),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.redAccent),
                tabs: [
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Mild"),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Moderate"),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Strenuous"),
                    ),
                  ),
                ]),
          ),
          body: rankScoreModelMild == null ||
                  rankScoreModelModer == null ||
                  rankScoreModelStren == null ||
                  sT
              ? Center(
                  child: Text("คุณยังไม่มีเพื่อน"),
                )
              : TabBarView(
                  children: [
                    Scaffold(
                      backgroundColor: Colors.green.shade100,
                      body: Container(
                        padding:
                            const EdgeInsets.only(top: 20, left: 30, right: 30),
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.green),
                                  color: Colors.white),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Text("ลำดับ",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 16),),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Text("ชื่อผู้ใช้",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 16),),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text("คะแนน",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 16),),
                                  ),
                                ],
                              ),
                            ),
                            mildRank(),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  "อันดับของคุณ",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                            Container(
                              height: 90,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.greenAccent.shade700),
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.green.shade200,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 0,
                                    child: Text(
                                      "${myrank}",
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: CircleAvatar(
                                      minRadius: 0,
                                      maxRadius: 40,
                                      backgroundColor: Colors.blue.shade100,
                                      child: CircleAvatar(
                                        radius: 90,
                                        backgroundColor: Colors.transparent,
                                        child: ClipOval(
                                          child: Image.network(
                                            "${userRankMild!.imagePro}",
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "${userRankMild!.userRank}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text("${userRankMild!.sumScoreRank}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Scaffold(
                      backgroundColor: Colors.yellowAccent.shade100,
                      body: Container(
                        padding:
                            const EdgeInsets.only(top: 20, left: 30, right: 30),
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.orange),
                                  color: Colors.white),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Text("ลำดับ",style: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold,fontSize: 16),),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Text("ชื่อผู้ใช้",style: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold,fontSize: 16),),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text("คะแนน",style: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold,fontSize: 16),),
                                  ),
                                ],
                              ),
                            ),
                            moderRank(),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  "อันดับของคุณ",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                            Container(
                              height: 90,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.yellowAccent.shade700),
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.yellow.shade200,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 0,
                                    child: Text(
                                      "${myrank1}",
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: CircleAvatar(
                                      minRadius: 0,
                                      maxRadius: 40,
                                      backgroundColor: Colors.blue.shade100,
                                      child: CircleAvatar(
                                        radius: 90,
                                        backgroundColor: Colors.transparent,
                                        child: ClipOval(
                                          child: Image.network(
                                            "${userRankModer!.imagePro}",
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "${userRankModer!.userRank}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                        "${userRankModer!.sumScoreRank}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Scaffold(
                      backgroundColor: Colors.redAccent.shade100,
                      body: Container(
                        padding:
                            const EdgeInsets.only(top: 20, left: 30, right: 30),
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.red),
                                  color: Colors.white),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Text("ลำดับ",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 16),),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Text("ชื่อผู้ใช้",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 16),),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text("คะแนน",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 16),),
                                  ),
                                ],
                              ),
                            ),
                            stenRank(),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  "อันดับของคุณ",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                            Container(
                              height: 90,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.redAccent.shade700),
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.red.shade200,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 0,
                                    child: Text(
                                      "${myrank}",
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: CircleAvatar(
                                      minRadius: 0,
                                      maxRadius: 40,
                                      backgroundColor: Colors.blue.shade100,
                                      child: CircleAvatar(
                                        radius: 90,
                                        backgroundColor: Colors.transparent,
                                        child: ClipOval(
                                          child: Image.network(
                                            "${userRankStren!.imagePro}",
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "${userRankStren!.userRank}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                        "${userRankStren!.sumScoreRank}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      );
}
