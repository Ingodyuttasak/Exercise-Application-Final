import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ScoreModel {
  final int sumScore;
  final int playTime;
  final Timestamp playDate;

  ScoreModel(this.sumScore, this.playTime, this.playDate);

  Map<String, dynamic> toMap() {
    return {
      'sumScore': sumScore,
      'playTime': playTime,
      'playDate': playDate,
    };
  }

  factory ScoreModel.fromMap(Map<String, dynamic> map) {
    return ScoreModel(
      map['sumScore'],
      map['playTime'],
      map['playDate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ScoreModel.fromJson(String source) => ScoreModel.fromMap(json.decode(source));
}