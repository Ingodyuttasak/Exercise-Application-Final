import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class RankScoreModel {
  String uidUser;
  int sumScoreRank;
  String userRank;
  String imagePro;
  RankScoreModel({
    required this.uidUser,
    required this.sumScoreRank,
    required this.userRank,
    required this.imagePro,
  });

  Map<String, dynamic> toMap() {
    return {
      'uidUser':uidUser,
      'sumScoreRank': sumScoreRank,
      'userRank': userRank,
      'imagePro': imagePro,
    };
  }
 
  factory RankScoreModel.fromMap(Map<String, dynamic> map) {
    return RankScoreModel(
      uidUser: map['uidUser'] ?? '',
      sumScoreRank: map['sumScoreRank']?.toInt() ?? 0,
      userRank: map['userRank'] ?? '',
      imagePro: map['imagePro'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RankScoreModel.fromJson(String source) => RankScoreModel.fromMap(json.decode(source));
}
