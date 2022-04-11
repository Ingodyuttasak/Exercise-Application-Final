import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_final/Auth/login_screen.dart';
import 'package:mobile_final/model/user_model.dart';
import 'package:mobile_final/screens/Friend/acfriend.dart';
import 'package:mobile_final/screens/Friend/addfriend_screen.dart';
import 'package:badges/badges.dart';

class FriendScreen extends StatefulWidget {
  const FriendScreen({Key? key}) : super(key: key);

  @override
  _FriendScreenState createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  final storage = new FlutterSecureStorage();
  List<UserModel> modelFriends = [];
  UserModel? userModel;
  String? uidMe;
  String? uid;
  int times = 0, playTime = 0;
  bool _running = true;

  Future findUid() async {
    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      uidMe = event!.uid;
      
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uidMe)
          .get()
          .then((value) {
        setState(() {
          userModel = UserModel.fromMap(value.data()!);
        });
      });
      
    });
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  Future<void> autoPlayTime() async {
    Duration duration = Duration(milliseconds: 100);
    await Timer(duration, () async {
      setState(() {
        playTime++;
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('friends')
          .get()
          .then((value) {
        if (value.size != modelFriends) {
          if (!mounted) return;
          modelFriends.clear();
          for (var item in value.docs) {
            UserModel model = UserModel.fromMap(item.data());
            setState(() {
              modelFriends.add(model);
            });
          }
        }
      });
      autoPlayTime();
    });
  }

  Future findFriends() async {
    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      uid = event!.uid;
      
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('friends')
          .where('username', isNotEqualTo: 'a')
          .get()
          .then((value) {
        int i = 0;
        for (var item in value.docs) {
          UserModel model = UserModel.fromMap(item.data());
          setState(() {
            modelFriends.add(model);
            times = i;
            i++;
          });
        }
      });
    });
  }

  Future<void> autolistFriend() async {
    if (times >= 0) {
      setState(() {
        listFriendss();
      });
      times++;
    }
  }

  Widget listFriendss() {
    return Container(
      height: 450,
      width: 400,
      child: SingleChildScrollView(
        child: Column(
          children: modelFriends.map((e) {
            return Container(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.cyan.shade100),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 0,
                          child: CircleAvatar(
                            minRadius: 0,
                            maxRadius: 40,
                            backgroundColor: Colors.blue.shade100,
                            child: CircleAvatar(
                              radius: 90,
                              backgroundColor: Colors.transparent,
                              child: ClipOval(
                                child: Image.network(
                                  "${e.imageUrl}",
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            e.username.toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Expanded(
                          flex:0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(80, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              primary: Colors.red,
                            ),
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(uidMe)
                                  .collection('friends')
                                  .doc(e.uid)
                                  .delete()
                                  .then((value) {
                                setState(() {
                                  modelFriends = [];
                                });
                              });
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(e.uid)
                                  .collection('friends')
                                  .doc(uidMe)
                                  .delete()
                                  .then((value) {
                                setState(() {
                                  modelFriends = [];
                                });
                              });
                            },
                            child: Text(
                              "ลบเพื่อน",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ));
          }).toList(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    findFriends();
    findUid();
    listFriendss();
    autolistFriend();
    autoPlayTime();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: userModel == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "รายชื่อเพื่อน",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                      Expanded(child: Container()),
                      IconButton(
                        icon: const Icon(
                          Icons.logout,
                          size: 20,
                          color: Colors.black,
                        ),
                        onPressed: () async => {
                          // logout(context)
                          await FirebaseAuth.instance.signOut(),
                          await storage.delete(key: "uid"),
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ),
                              (route) => false)
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  listFriendss(),
                  Row(
                    children: [
                      Column(
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(150, 50),
                                  primary: Colors.lightBlue.shade700,
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const addFriends()),
                                );
                              },
                              child: const Text(
                                "เพิ่มเพื่อน",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ))
                        ],
                      ),
                      SizedBox(width: 30),
                      Column(
                        children: [
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(uid)
                                  .collection('addfriends')
                                  .where('username')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: Text("no data"),
                                  );
                                }
                                final DocumentSnapshotList =
                                    snapshot.data!.docs;
                                return Badge(
                                  showBadge: DocumentSnapshotList.length<=0?false:true,
                                  badgeContent:
                                      Text('${DocumentSnapshotList.length}'),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(150, 50),
                                        primary: Colors.blueGrey.shade700,
                                        onPrimary: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20))),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const accectFriend()),
                                      );
                                    },
                                    child: Text(
                                      "คำขอเป็นเพื่อน",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}

Future<void> logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
}



// CircleAvatar(
//                           minRadius: 0,
//                           maxRadius: 40,
//                           backgroundColor: Colors.blue.shade100,
//                           child: CircleAvatar(
//                             radius: 90,
//                             backgroundColor: Colors.transparent,
//                             child: ClipOval(
//                               child: Image.network(
//                                 "${e.imageUrl}",
//                                 width: 70,
//                                 height: 70,
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 20),
//                         Expanded(
//                           flex: 1,
                          // child: Text(
                          //   e.username.toString(),
                          //   style: TextStyle(
                          //       fontSize: 18, fontWeight: FontWeight.w500),
                          // ),
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
                        // ElevatedButton(
                        //   style: ElevatedButton.styleFrom(
                        //     minimumSize: Size(10, 30),
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(20),
                        //     ),
                        //     primary: Colors.red,
                        //   ),
                        //   onPressed: () async {
                        //     await FirebaseFirestore.instance
                        //         .collection('users')
                        //         .doc(uidMe)
                        //         .collection('friends')
                        //         .doc(e.uid)
                        //         .delete()
                        //         .then((value) {
                        //       setState(() {
                        //         modelFriends = [];
                        //       });
                        //     });
                        //   },
                        //   child: Text(
                        //     "ลบเพื่อน",
                        //     style: TextStyle(
                        //       fontSize: 14,
                        //     ),
                        //   ),
                        // ),









// Container(
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               const accectFriend()),
//                                     );
//                                   },
//                                   child: Container(
//                                     height: 50.0,
//                                     width: 150,
//                                     padding: EdgeInsets.all(10.0),
//                                     decoration: BoxDecoration(
//                                       color: Colors.green.shade700,
//                                       borderRadius: BorderRadius.circular(20),
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         "คำขอเป็นเพื่อน",
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),


// GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const addFriends()),
//                           );
//                         },
//                         child: Container(
//                           height: 50.0,
//                           width: 150,
//                           padding: EdgeInsets.all(10.0),
//                           decoration: BoxDecoration(
//                             color: Colors.green.shade700,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Center(
//                             child: Text(
//                               "เพิ่มเพื่อน",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),