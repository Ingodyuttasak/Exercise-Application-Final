import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? uid;
  String? imageUrl;
  String? email;
  String? username;
  String? gender;
  Timestamp? age;
  String? height;
  String? weight;
  Timestamp? regisDate;
  bool? report;

  UserModel(
      {this.uid,
      this.imageUrl,
      this.email,
      this.username,
      this.gender,
      this.age,
      this.height,
      this.weight,
      this.regisDate,
      this.report
      });
  //!receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        imageUrl: map['imageUrl'],
        email: map['email'],
        username: map['username'],
        gender: map['gender'],
        age: map['age'],
        height: map['height'],
        weight: map['weight'],
        regisDate: map['regisDate'],
        report: map['report']
        );
        
  }
  //!sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'imageUrl': imageUrl,
      'email': email,
      'username': username,
      'gender': gender,
      'age': age,
      'height': height,
      'weight': weight,
      'regisDate': regisDate,
      'report': report,
    };
  }
}
