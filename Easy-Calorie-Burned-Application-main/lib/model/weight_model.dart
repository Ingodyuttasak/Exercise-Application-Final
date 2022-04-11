import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class WeightModel {
  String nowWeight;
  Timestamp weightTime;

  WeightModel(this.nowWeight,this.weightTime);

  Map<String, dynamic> toMap() {
    return {
      'nowWeight': nowWeight,
      'weightTime': weightTime,
    };
  }

  factory WeightModel.fromMap(Map<String, dynamic> map) {
    return WeightModel(
     map['nowWeight'],
     map['weightTime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WeightModel.fromJson(String source) => WeightModel.fromMap(json.decode(source));
}
