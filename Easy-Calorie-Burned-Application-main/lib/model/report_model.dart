import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel{
  int question1;
  int question2;
  int question3;
  int question4;
  int question5;

  ReportModel({
    required this.question1,
    required this.question2,
    required this.question3,
    required this.question4,
    required this.question5
  });

  Map<String, dynamic> toMap() {
    return{
      'question1':question1,
      'question2':question2,
      'question3':question3,
      'question4':question4,
      'question5':question5,
    };
  } 
  factory ReportModel.fromMap(Map<String, dynamic>map){
    return ReportModel(
      question1: map['question1'],
      question2: map['question2'],
      question3: map['question3'],
      question4: map['question4'],
      question5: map['question5'],
    );

  }
  String toJson() => json.encode(toMap());

  factory ReportModel.fromJson(String source) => ReportModel.fromMap(json.decode(source));
}