import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/model/ranking_model.dart';
import 'package:mobile_final/screens/ranking/friend_ranking_screen.dart';

class showRankScreen extends StatefulWidget {
  const showRankScreen({Key? key}) : super(key: key);

  @override
  _showRankScreenState createState() => _showRankScreenState();
}

class _showRankScreenState extends State<showRankScreen> {
  List<RankScoreModel> rankScoreModelMild = [];
  List<RankScoreModel> rankScoreModelModer = [];
  List<RankScoreModel> rankScoreModelStren = [];

  int rankCount = 0,
      irank = 0,
      myrank = 0,
      sumScore = 0,
      myrank1 = 0,
      irank1 = 0,
      rankCount1 = 0,
      myrank2 = 0,
      irank2 = 0,
      rankCount2 = 0;
  String? userRank, imagepro;
  RankScoreModel? userRankScore;
  RankScoreModel? userRankModer;
  RankScoreModel? userRankStrent;

  Future showRank() async {
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
              rankScoreModelMild.add(model);
              irank++;
              if (model.uidUser == uid) {
                myrank = irank;
                userRankScore = model;
              }
            });
          }
        });
      }).then((value) {
        FirebaseFirestore.instance
            .collection('moderrateranking')
            .orderBy('sumScoreRank', descending: true)
            .get()
            .then((values) {
          setState(() {
            for (var item in values.docs) {
              RankScoreModel model1 = RankScoreModel.fromMap(item.data());
              setState(() {
                rankScoreModelModer.add(model1);
                irank1++;
                if (model1.uidUser == uid) {
                  myrank1 = irank1;
                  userRankModer = model1;
                }
              });
            }
          });
        });
      }).then((value) {
        FirebaseFirestore.instance
            .collection('strenuousranking')
            .orderBy('sumScoreRank', descending: true)
            .get()
            .then((values) {
          setState(() {
            for (var item in values.docs) {
              RankScoreModel model2 = RankScoreModel.fromMap(item.data());
              setState(() {
                rankScoreModelStren.add(model2);
                irank2++;
                if (model2.uidUser == uid) {
                  myrank2 = irank2;
                  userRankStrent = model2;
                }
              });
            }
          });
        });
      });
    });
  }

  Widget mildRank() {
    return Container(
      height: 400,
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
                            "${++rankCount}",
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
      height: 400,
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

  Widget strenRank() {
    return Container(
      height: 400,
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
          children: rankScoreModelStren.map((g) {
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
                                  "${g.imagePro}",
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
                            "${g.userRank.toString()}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text("${g.sumScoreRank}",
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
    showRank();
  }

  Widget build(BuildContext context) => DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                icon: Image.asset('assets/images/friend.png'),
                iconSize: 60,
                onPressed: () {
                  //   Navigator.pushAndRemoveUntil(
                  // context,
                  // MaterialPageRoute(
                  //     builder: (BuildContext context) => friendRanking()),
                  // (Route<dynamic> route) => false);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const friendRanking()),
                  );
                },
              )
            ],
            backgroundColor: Colors.yellow[100],
            foregroundColor: Colors.black,
            title: Text("อันดับการแข่งขัน "),
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
                  userRankScore == null ||
                  rankScoreModelModer == null ||
                  userRankModer == null ||
                  rankScoreModelStren == null ||
                  userRankStrent == null
              ? Center(
                  child: Text("ยังไม่มีการจัดอันดับ"),
                )
              : TabBarView(
                  children: [
                    //mild
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
                                border: Border.all(color: Colors.lightGreen),
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.greenAccent,
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
                                            "${userRankScore!.imagePro}",
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
                                      "${userRankScore!.userRank}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                        "${userRankScore!.sumScoreRank}",
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
                    //moderate
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
                                    color: Colors.orangeAccent.shade700),
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.amber.shade200,
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
                    //Strenous
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
                            strenRank(),
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
                                      "${myrank2}",
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
                                            "${userRankStrent!.imagePro}",
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
                                      "${userRankStrent!.userRank}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                        "${userRankStrent!.sumScoreRank}",
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
