import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_final/Auth/login_screen.dart';
import 'package:mobile_final/model/user_model.dart';
import 'package:mobile_final/screens/home_screen.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:intl/intl.dart';

enum genderGroup { male, female, other }

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;
  int score = 0;
  final _formkey = GlobalKey<FormState>();

  final emailEditingController = new TextEditingController();
  final userNameEditingController = new TextEditingController();
  final ageEditingController = new TextEditingController();
  final heightEditingController = new TextEditingController();
  final weightEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmpassEditingController = new TextEditingController();

  DateTime birthdayDate = DateTime.now();
  String imageProfile =
      'https://firebasestorage.googleapis.com/v0/b/final-project-7846a.appspot.com/o/user%2Fuser.jpg?alt=media&token=48ef2f03-369b-4bdf-98c7-29e7fe1c6367';
  File? image;
  Future uploadPic() async {
    Random random = Random();
    int i = random.nextInt(100000);

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference reference = firebaseStorage.ref().child('users/user$i.jpg');
    UploadTask uploadTask = reference.putFile(image!);
    imageProfile = await uploadTask.then((res) => res.ref.getDownloadURL());
    print('${imageProfile}');
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

  // Future<bool> usernameCheck(String ) async{
  //   final result = await FirebaseFirestore.instance
  //   .collection('users')
  //   .where('username',isEqualTo: )
  //   .get();
  //   return result.docs.isEmpty;
  // }

  String? errorMessage;
  genderGroup _value = genderGroup.male;
  String genders = 'ผู้ชาย';

  Widget gender() {
    return GenderPickerWithImage(
      verticalAlignedText: false,
      selectedGender: Gender.Male,
      selectedGenderTextStyle:
          TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      unSelectedGenderTextStyle:
          TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
      onChanged: (Gender? gender) {
        if (gender == Gender.Male) {
          genders = 'ผู้ชาย';
          print(genders);
        } else if (gender == Gender.Female) {
          genders = 'ผู้หญิง';
          print(genders);
        }
      },
      equallyAligned: true,
      animationDuration: Duration(milliseconds: 300),
      isCircular: true,
      // default : true,
      opacityOfGradient: 0.4,
      padding: const EdgeInsets.all(3),
      size: 50, //default : 40
    );
  }

  Widget ageDate() {
    return Row(
      children: [
        Container(
          height: 50,
          width: 215,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              SizedBox(width: 10),
              Icon(
                Icons.cake_outlined,
                color: Colors.grey[600],
              ),
              SizedBox(width: 15),
              Text(
                "Birth Day : ",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              Text(
                  '${birthdayDate.day}/${birthdayDate.month}/${birthdayDate.year}',
                  style: TextStyle(fontSize: 16, color: Colors.blue)),
            ],
          ),
        ),
        IconButton(
            onPressed: () async {
              DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: birthdayDate,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now());

              if (newDate == null) return;
              setState(() => birthdayDate = newDate);
            },
            icon: Icon(Icons.calendar_today))
      ],
    );

    // Text(
    //   "Birth Day",
    //   style: TextStyle(fontSize: 16),
    // ),
    // SizedBox(
    //   width: 20,
    // ),
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter Your Valid Email");
          }
          return null;
        },
        onSaved: (value) {
          emailEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.mail),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Email",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )));

    final usernameField = TextFormField(
        autofocus: false,
        controller: userNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Username can't be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Pleasae Enter Valid Username (min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          userNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_circle),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Username",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )));

    final ageField = TextFormField(
        autofocus: false,
        controller: ageEditingController,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Enter your Age';
          }
          if (int.tryParse(value)! > 100) {
            return 'Please Should to Enter Real Age';
          }
          return null;
        },
        onSaved: (value) {
          ageEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.calendar_today),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Age",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )));

    final heightField = TextFormField(
        autofocus: false,
        controller: heightEditingController,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Enter your Height';
          } else if (int.tryParse(value)! > 250) {
            return 'Please Should to Enter Real Height';
          } else {
            return null;
          }
        },
        onSaved: (value) {
          heightEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.emoji_people),
            contentPadding: EdgeInsets.fromLTRB(5, 15, 20, 15),
            hintText: "Height",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )));

    final weightField = TextFormField(
        autofocus: false,
        controller: weightEditingController,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Enter your Weight';
          } else if (int.tryParse(value)! > 150) {
            return 'Please Should to Enter Real Weight';
          } else {
            return null;
          }
        },
        onSaved: (value) {
          weightEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.monitor_weight_rounded),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Weight",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )));

    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Please Enter your Password");
          }
          if (!regex.hasMatch(value)) {
            return ("Pleasae Enter Valid Password (min. 6 Character)");
          }
        },
        onSaved: (value) {
          passwordEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.vpn_key),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )));

    final confirmpasswordField = TextFormField(
        autofocus: false,
        controller: confirmpassEditingController,
        obscureText: true,
        validator: (value) {
          if (confirmpassEditingController.text.length > 6 &&
              passwordEditingController.text !=
                  passwordEditingController.text) {
            return "Password don't Match";
          } else if (value!.isEmpty) {
            return "Please Enter your Confirm Password";
          }
          return null;
        },
        onSaved: (value) {
          confirmpassEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.vpn_key),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Confirm Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )));

    final registerButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          // final valid = await usernameCheck();
          // if(!valid){
          //   print("username มีแล้ว");
          // }else if(_formkey.currentState!.validate()){
          //   signUp(emailEditingController.text, passwordEditingController.text);
          // };
          signUp(emailEditingController.text, passwordEditingController.text);
        },
        child: Text(
          "สมัครสมาชิก",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "สมัครสมาชิก",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Login()));
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 50),
                            child: CircleAvatar(
                              radius: 75,
                              backgroundColor: Colors.black26,
                              child: CircleAvatar(
                                radius: 70,
                                backgroundImage:
                                    image == null ? null : FileImage(image!),
                                // backgroundImage: _pickedImage == null ? null:FileImage(_pickedImage!),
                              ),
                            ),
                          ),
                          // ignore: prefer_const_constructors
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
                                              // InkWell(
                                              //   onTap: (){uploadPic();},
                                              //   splashColor: Colors.blueAccent,
                                              //   child: Row(
                                              //     children: [
                                              //       Padding(
                                              //         padding: const EdgeInsets.all(8.0),
                                              //         child: Icon(Icons.remove_circle,
                                              //         color: Colors.blueAccent,
                                              //         ),
                                              //       ),
                                              //       Text("Remove",
                                              //       style: TextStyle(
                                              //           fontSize: 18,
                                              //           fontWeight: FontWeight.w500,
                                              //           color: Colors.blue[900],
                                              //         ),
                                              //       ),
                                              //     ],
                                              //   ),
                                              // )
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
                      //Profile
                      // SizedBox(
                      //   height: 300,
                      //   child: Image.asset(
                      //     "assets/images/logo.png",
                      //     fit: BoxFit.contain,
                      //   ),
                      // ),
                      gender(),
                      SizedBox(height: 10),
                      emailField,
                      SizedBox(height: 10),
                      usernameField,
                      SizedBox(height: 10),
                      ageDate(),
                      SizedBox(
                        height: 10,
                      ),
                      heightField,
                      SizedBox(height: 10),
                      weightField,
                      SizedBox(height: 10),
                      passwordField,
                      SizedBox(height: 10),
                      confirmpasswordField,
                      SizedBox(height: 20),
                      registerButton,
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    DateTime regisTime = DateTime.now();
    Timestamp regisDate = Timestamp.fromDate(regisTime);
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.imageUrl = imageProfile;
    userModel.username = userNameEditingController.text;
    userModel.gender = genders;
    userModel.age = Timestamp.fromDate(birthdayDate);
    userModel.height = heightEditingController.text;
    userModel.weight = weightEditingController.text;
    userModel.regisDate = regisDate;
    userModel.report = false;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap())
        .then((value) {
      FirebaseFirestore.instance.collection('mildranking').doc(user.uid).set({
        'uidUser': user.uid,
        'imagePro': imageProfile,
        'userRank': userNameEditingController.text,
        'sumScoreRank': score,
      }).then((value) async {
        await FirebaseFirestore.instance
            .collection('moderrateranking')
            .doc(user.uid)
            .set({
          'uidUser': user.uid,
          'imagePro': imageProfile,
          'userRank': userNameEditingController.text,
          'sumScoreRank': score,
        });
      }).then((value) async {
        await FirebaseFirestore.instance
            .collection('strenuousranking')
            .doc(user.uid)
            .set({
          'uidUser': user.uid,
          'imagePro': imageProfile,
          'userRank': userNameEditingController.text,
          'sumScoreRank': score,
        });
      }).then((value) async {
        DateTime dateTime = DateTime.now();
        Timestamp weightTime = Timestamp.fromDate(dateTime);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('weightUpdate')
            .doc(
                '${dateTime.year}${dateTime.month < 10 ? '0' : ''}${dateTime.month}${dateTime.day < 10 ? '0' : ''}${dateTime.day}${dateTime.hour < 10 ? '0' : ''}${dateTime.hour}${dateTime.minute < 10 ? '0' : ''}${dateTime.minute}')
            .set({
          'nowWeight': weightEditingController.text,
          'weightTime': weightTime
        });
      });
    });
    Fluttertoast.showToast(msg: "Account created successfully :D ");
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => Login()), (route) => false);
  }
}
