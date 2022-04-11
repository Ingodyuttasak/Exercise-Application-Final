// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:mobile_final/Games/games_model/02_mild/03_arm_circles/pose_detector_views_arm_circles.dart';
import 'package:mobile_final/model/user_model.dart';

class accectFriend extends StatefulWidget {
  const accectFriend({Key? key}) : super(key: key);

  @override
  _accectFriendState createState() => _accectFriendState();
}

class _accectFriendState extends State<accectFriend> {
  List<UserModel> modelFriends = []; //list ข้อมูลของเพื่อน
  int times = 0; //จำนวนครั้ง
  String? uid, uidMe;
  UserModel? userModel;

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

  Future findFriends() async {
    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      uid = event!.uid;
     
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('addfriends')
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

  Widget listFriendss() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: modelFriends.map((e) {
            return Container(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade400
                    ),
                    child: Row(
                      children: [
                        SizedBox(
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
                                  width: 130,
                                  height: 130,
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
                            e.username.toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))
                                ),
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(uidMe)
                                      .collection('friends')
                                      .doc(e.uid)
                                      .set({
                                    'uid': e.uid,
                                    'username': e.username,
                                    'imageUrl': e.imageUrl,
                                  }).then((value) async {
                                    //เก็บข้อมูลเราให้เพื่อน
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(e.uid)
                                        .collection('friends')
                                        .doc(uidMe)
                                        .set({
                                      'uid': uidMe,
                                      'username': userModel!.username,
                                      'imageUrl': userModel!.imageUrl,
                                    }).then((val) async {
                                      //ลบข้อมูลการแอดเพื่อน
                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(uidMe)
                                          .collection('addfriends')
                                          .doc(e.uid)
                                          .delete()
                                          .then((value) {
                                        setState(() {
                                          modelFriends = [];
                                        });
                                      });
                                    });
                                    findFriends();
                                    print("success");
                                  });
                                },
                                child: Text("ยืนยัน"),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))
                                ),
                                onPressed: () async{
                                  await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(uidMe)
                                          .collection('addfriends')
                                          .doc(e.uid)
                                          .delete()
                                          .then((value) {
                                        setState(() {
                                          modelFriends = [];
                                        });
                                        findFriends();
                                      });
                                },
                                child: Text("ปฏิเสธ"),),
                            ],
                          ),
                        ),
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
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade700,
        title: Text("ยืนยันเพื่อน"),
      ),
      body: modelFriends.isEmpty
          ? Center(
              child: 
                  Text(
                    "ไม่มีคำขอเป็นเพื่อน",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.grey),
                  ),
                
            )
          : Container(
              child: listFriendss(),
            ),
    );
  }
}



// CircleAvatar(
//                     minRadius: 0,
//                     maxRadius: 70,
//                     backgroundColor: Colors.blue.shade100,
//                     child: CircleAvatar(
//                       radius: 90,
//                       backgroundColor: Colors.transparent,
//                       child: ClipOval(
//                         child: Image.network(
//                           "${e.imageUrl}",
//                           width: 130,
//                           height: 130,
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Text(e.username.toString()),
//                   GestureDetector(
//                     onTap: () async {
//                       //เก็บข้อมูลเพื่อน
//                       await FirebaseFirestore.instance
//                           .collection('users')
//                           .doc(uidMe)
//                           .collection('friends')
//                           .doc(e.uid)
//                           .set({
//                         'uid': e.uid,
//                         'username': e.username,
//                         'imageUrl': e.imageUrl,
//                       }).then((value) async {
//                         //เก็บข้อมูลเราให้เพื่อน
//                         await FirebaseFirestore.instance
//                             .collection('users')
//                             .doc(e.uid)
//                             .collection('friends')
//                             .doc(uidMe)
//                             .set({
//                           'uid': uidMe,
//                           'username': userModel!.username,
//                           'imageUrl': userModel!.imageUrl,
//                         }).then((val) async {
//                           //ลบข้อมูลการแอดเพื่อน
//                           await FirebaseFirestore.instance
//                               .collection('users')
//                               .doc(uidMe)
//                               .collection('addfriends')
//                               .doc(e.uid)
//                               .delete()
//                               .then((value) {
//                             setState(() {
//                               modelFriends = [];
//                             });
//                           });
//                         });
//                         findFriends();
//                         print("success");
//                       });
//                     },
//                     child: Container(
//                       height: 50.0,
//                       width: 150,
//                       padding: EdgeInsets.all(10.0),
//                       decoration: BoxDecoration(
//                         color: Colors.green.shade700,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Center(
//                         child: Text(
//                           "เพิ่มเพื่อน",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),