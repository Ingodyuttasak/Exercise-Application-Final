// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_final/model/user_model.dart';

class editUserScreen extends StatefulWidget {
  const editUserScreen({Key? key}) : super(key: key);

  @override
  _editUserScreenState createState() => _editUserScreenState();
}

class _editUserScreenState extends State<editUserScreen> {
  UserModel? userModel;
  final formKey = GlobalKey<FormState>();
  bool isButtonActive = true;
  String? imageProfile;
  File? image;
  String? errorMessage;

  Future uploadPic() async {
    try {
      Random random = Random();
      int i = random.nextInt(100000);

      FirebaseStorage firebaseStorage = FirebaseStorage.instance;
      Reference reference = firebaseStorage.ref().child('user/user$i.jpg');
      UploadTask uploadTask = reference.putFile(image!);
      imageProfile = await uploadTask.then((res) => res.ref.getDownloadURL());
    } catch (error) {
      Fluttertoast.showToast(msg: "กรุณาใส่รูปภาพก่อนกดยืนยันด้วยครับ");
    }
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print("Failed");
    }
  }

  Future getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print("Failed");
    }
  }

  Future findProfile() async {
    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      String uid = event!.uid;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get()
          .then((value) {
        setState(() {
          userModel = UserModel.fromMap(value.data()!);
          imageProfile = userModel!.imageUrl;
        });
      });
    });
  }

  @override
  void initState() {
    findProfile();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      findProfile();
      Scaffold();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[800],
        title: Text("แก้ไขข้อมูลส่วนตัว"),
      ),
      body: userModel == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.only(top: 40, left: 30, right: 30),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 50),
                            child: CircleAvatar(
                              radius: 75,
                              backgroundColor: Colors.black26,
                              child: CircleAvatar(
                                radius: 70,
                                child: ClipOval(
                                  child: new SizedBox(
                                    width: 130,
                                    height: 130,
                                    child: image == null
                                        ? Image.network(
                                            "${userModel!.imageUrl}",
                                            fit: BoxFit.cover,
                                          )
                                        : Image.file(
                                            image!,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 100,
                            left: 70,
                            child: RawMaterialButton(
                              elevation: 10,
                              fillColor: Colors.white70,
                              child: Icon(Icons.add_a_photo),
                              padding: EdgeInsets.all(15.0),
                              shape: CircleBorder(),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          "Chose Options",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: [
                                              InkWell(
                                                onTap: () => pickImage(
                                                    ImageSource.camera),
                                                splashColor: Colors.blueAccent,
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons.camera,
                                                        color:
                                                            Colors.blueAccent,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Camera",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.blue[900],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () => pickImage(
                                                    ImageSource.gallery),
                                                splashColor: Colors.blueAccent,
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons.image,
                                                        color:
                                                            Colors.blueAccent,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Gallery",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.blue[900],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: Colors.green,
                                                          onSurface:
                                                              Colors.blue),
                                                  onPressed: () {
                                                    uploadPic();
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('ยืนยัน'))
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Container(
                        
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                            topRight: Radius.circular(70),
                            bottomLeft: Radius.circular(20),
                          ),
                          gradient: LinearGradient(
                            colors: [
                              Colors.lightBlue.shade50.withOpacity(0.9),
                              Colors.lightBlue.shade100.withOpacity(0.9),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 30),
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  Text(
                                    "ชื่อผู้ใช้",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 35),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 180,
                                    height: 40,
                                    child: TextFormField(
                                      validator: (value) {
                                        RegExp regex = new RegExp(r'^.{2,}$');
                                        if (value!.isEmpty) {
                                          return ("กรุณากรอกชื่อผู้ใช้");
                                        }
                                        if (!regex.hasMatch(value)) {
                                          return ("กรุณากรอกชื่อผู้ใช้มากกว่า 2 ตัวอักษร");
                                        }
                                        return null;
                                      },
                                      onSaved: (String? name) {
                                        userModel!.username = name!;
                                      },
                                      initialValue: userModel!.username,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.fromLTRB(10, 0, 0, 0),
                                          fillColor: Colors.white,
                                          filled: true,
                                          hintText: '${userModel!.username}',
                                          hintStyle: TextStyle(fontSize: 18),
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  Text(
                                    "ส่วนสูง",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 40),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 100,
                                    height: 40,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'กรุณากรอกน้ำหนัก';
                                        } else if (int.tryParse(value)! > 250) {
                                          return 'ส่วนสูงไม่ถูกต้อง';
                                        } else if (int.tryParse(value)! < 100) {
                                          return 'ส่วนสูงไม่ถูกต้อง';
                                        }

                                        else {
                                          return null;
                                        }
                                      },
                                      onSaved: (String? height) {
                                        userModel!.height = height!;
                                      },
                                      initialValue: userModel!.height,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.fromLTRB(10, 0, 0, 0),
                                          fillColor: Colors.white,
                                          filled: true,
                                          hintText: '${userModel!.height}',
                                          hintStyle: TextStyle(fontSize: 18),
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  Text(
                                    "น้ำหนัก",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 37),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 100,
                                    height: 40,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'กรุณากรอกน้ำหนัก';
                                        } else if (int.tryParse(value)! > 150) {
                                          return 'น้ำหนักไม่ถูกต้อง';
                                        } else if (int.tryParse(value)! < 20) {
                                          return 'น้ำหนักไม่ถูกต้อง';
                                        } 
                                        else {
                                          return null;
                                        }
                                      },
                                      onSaved: (String? weight) {
                                        userModel!.weight = weight!;
                                      },
                                      initialValue: userModel!.weight,
                                      decoration: InputDecoration(
                                          isCollapsed: false,
                                          contentPadding:
                                              EdgeInsets.fromLTRB(10, 0, 0, 0),
                                          fillColor: Colors.white,
                                          filled: true,
                                          hintText: '${userModel!.weight}',
                                          hintStyle: TextStyle(fontSize: 18),
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          SizedBox(width: 150),
                          GestureDetector(
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState?.save();
                                try {
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(userModel!.uid)
                                      .update({
                                    'age': userModel!.age,
                                    'email': userModel!.email,
                                    'height': userModel!.height,
                                    'weight': userModel!.weight,
                                    'imageUrl': imageProfile,
                                    'uid': userModel!.uid,
                                    'username': userModel!.username,
                                  }).then((value) async {
                                    await FirebaseFirestore.instance
                                        .collection('mildranking')
                                        .doc(userModel!.uid)
                                        .update({
                                      'imagePro': imageProfile,
                                      'userRank': userModel!.username,
                                    });
                                  }).then((value) async {
                                    await FirebaseFirestore.instance
                                        .collection('moderrateranking')
                                        .doc(userModel!.uid)
                                        .update({
                                      'imagePro': imageProfile,
                                      'userRank': userModel!.username,
                                    });
                                  }).then((value) async {
                                    await FirebaseFirestore.instance
                                        .collection('strenuousranking')
                                        .doc(userModel!.uid)
                                        .update({
                                      'imagePro': imageProfile,
                                      'userRank': userModel!.username,
                                    }).then((value) async {
                                      DateTime dateTime = DateTime.now();
                                      Timestamp weightTime =
                                          Timestamp.fromDate(dateTime);
                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(userModel!.uid)
                                          .collection('weightUpdate')
                                          .doc(
                                              '${dateTime.year}${dateTime.month < 10 ? '0' : ''}${dateTime.month}${dateTime.day < 10 ? '0' : ''}${dateTime.day}${dateTime.hour < 10 ? '0' : ''}${dateTime.hour}${dateTime.minute < 10 ? '0' : ''}${dateTime.minute}')
                                          .set({
                                        'nowWeight': userModel!.weight,
                                        'weightTime': weightTime
                                      });
                                    });
                                  });
                                  Navigator.pop(context);
                                } catch (e) {
                                  print(e);
                                }
                              }
                            },
                            child: Container(
                              height: 50.0,
                              width: 180,
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.green.shade700,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  "ยืนยันการแก้ไข",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
