
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Like{
  String likeId;
  String likedCinemaId;
  DateTime likedDate;

  Like({this.likedCinemaId});

  Map<String,dynamic> toMap(){
    Map<String,dynamic> _map = Map();
    _map["likeId"] = likeId;
    _map["likedCinemaId"] = likedCinemaId;
    _map["likedDate"] = likedDate ??Timestamp.now();
    return _map;
  }
  Like.fromMap(Map<String,dynamic> _map):
        likeId = _map["likeId"],
        likedCinemaId = _map["likedCinemaId"],
        likedDate = (_map['likedDate'] as Timestamp).toDate();
  @override
  String toString() {
    return 'Like{likeId: $likeId, likedCinemaId: $likedCinemaId, likedDate: $likedDate}';
  }
}