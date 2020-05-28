import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User{
  final String uid;
  String email;
  String userName;
  String profilePhotoURL;
  DateTime createdAt;
  DateTime updatedAt;
  List<String> likes;

  User({@required this.uid,@required this.email});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> _map = Map<String, dynamic>();
    _map["uid"] = uid;
    _map["email"] = email;
    _map["userName"] = userName ?? "user"+createRandomNumber();
    _map["profilePhotoURL"] = profilePhotoURL ??
        "https://www.caretechfoundation.org.uk/wp-content/uploads/anonymous-person-221117.jpg";
    _map["createdAt"] = createdAt ?? FieldValue.serverTimestamp();
    _map["updatedAt"] = updatedAt ?? FieldValue.serverTimestamp();
    _map["likes"] = likes ?? [];
    return _map;
  }
  User.fromMap(Map<String, dynamic> map)
      : uid = map['uid'],
        email = map['email'],
        userName = map['userName'],
        profilePhotoURL = map['profilePhotoURL'],
        createdAt = (map['createdAt'] as Timestamp).toDate() ?? Timestamp.now(),
        updatedAt = (map['updatedAt'] as Timestamp).toDate() ?? Timestamp.now(),
        likes = List<String>.from(map["likes"]);
  User.idWithPicture({@required this.uid,@required this.profilePhotoURL});
  User.idWithLikes({@required this.uid,@required this.likes});

  String createRandomNumber() {
    int randomNumber = Random().nextInt(999999);
    return randomNumber.toString();
  }
}