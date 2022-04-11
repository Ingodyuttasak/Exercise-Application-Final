import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/model/user_model.dart';

class addFriends extends StatefulWidget {
  const addFriends({Key? key}) : super(key: key);

  @override
  _addFriendsState createState() => _addFriendsState();
}

class _addFriendsState extends State<addFriends> {
  String? nameF; //! ตัวแปรที่เก็บ Text
  List<UserModel> modelFriends = []; //! list ข้อมูลของเพื่อน
  int times = 0; //! จำนวนคน
  UserModel? userModel; //! ตัวเราเอง
  bool _running = true;
  String? uidMe; //! uid ของเรา
  final formKey = GlobalKey<FormState>();
  String? uid; //! uid เราแต่คนละฟีเจอร์

  //หาข้อมูลเรา
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

  //หาข้อมูลของเพื่อน
  Future findFriends() async {
    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      uid = event!.uid;
      
      await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: nameF)
          .get()
          .then((value) {
        for (var item in value.docs) {
          UserModel model = UserModel.fromMap(item.data());
          setState(() {
            modelFriends.add(model);
          });
        }
      });
    });
  }

  //widget ข้อมูลที่แสดง
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
                        color: Colors.lightBlue.shade100),
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
                        SizedBox(width: 20),
                        Expanded(
                          flex: 2,
                          child: Text(
                            e.username.toString(),
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 0,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(80, 40),
                                  primary: Colors.green,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0))),
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(e.uid.toString())
                                    .collection('addfriends')
                                    .doc(uid)
                                    .set({
                                  'uid': uidMe,
                                  'username': userModel!.username,
                                  'imageUrl': userModel!.imageUrl,
                                }).then((value) {
                                  setState(() {
                                    modelFriends = [];
                                  });
                                  print("success");
                                });
                              },
                              child: Text("เพิ่มเพื่อน"),
                            ))
                      ],
                    ),
                  ),
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
    findUid();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade700,
        title: Text("ค้นหารายชื่อเพื่อน"),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
        child: Form(
          key: formKey,
          child: Column(children: [
            Container(
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      onSaved: (String? name) {
                        nameF = name!;
                      },
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(hintText: "ค้นหาด้วยรายชื่อ"),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search_rounded),
                    onPressed: () {
                      setState(() {
                        modelFriends.clear();
                      });
                      formKey.currentState?.save();
                      findFriends();
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            listFriendss()
          ]),
        ),
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
//                   SizedBox(height: 10,),
//                   Text(e.username.toString(),
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w300,
//                   ),
//                   ),
//                    SizedBox(height: 10,),
//                   GestureDetector(
//                     onTap: () async {
//                       await FirebaseFirestore.instance
//                           .collection('users')
//                           .doc(e.uid.toString())
//                           .collection('addfriends')
//                           .doc(uid)
//                           .set({
//                             'uid': uidMe,
//                             'username': userModel!.username,
//                             'imageUrl': userModel!.imageUrl,
//                           }).then((value) {
//                             setState(() {
//                               modelFriends = [];
//                             });
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