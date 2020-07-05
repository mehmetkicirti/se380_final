import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:se380final/models/User/users.dart';
import 'package:se380final/services/Abstract/IFireStorageService.dart';
import 'package:se380final/services/Abstract/ILikeService.dart';
import 'package:se380final/services/Abstract/IUserService.dart';

class UserManagerFirestoreDB implements IUserService,ILikeService,IFireStorageService{
  final Firestore _firestore = Firestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  @override
  Future<List<String>> getLikes(String userId) async{
    DocumentSnapshot _snapShot = await _firestore.document("Users/$userId").get();
    if(_snapShot.exists){
      User user = User.fromMap(_snapShot.data);
      return user.likes;
    }else
      throw Exception("User Not Found");
  }

  @override
  Future<bool> likeFilm(String userId,String cinemaId) async{
    DocumentSnapshot _snapshot = await _firestore.document("Users/$userId").get();
    if(_snapshot.exists){
      User user = User.fromMap(_snapshot.data);
      if(user.likes == null){
        user.likes = [];
      }
      if(!user.likes.contains(cinemaId)){
        user.likes.add(cinemaId);
      }else{
        throw Exception("Already Defined");
      }
      await this.saveUser(user);
      return true;
    }else{
      throw Exception("Like Film Error");
    }
  }

  @override
  Future<User> readUser(String id) async{
    DocumentSnapshot _snapShot = await _firestore.document("Users/$id").get();
    if(_snapShot.exists){
      return User.fromMap(_snapShot.data);
    }else
      throw Exception("User Not Found");
  }

  @override
  Future<bool> saveUser(User user) async{
    await _firestore.collection("Users").document(user.uid).setData(user.toMap());
    return true;
  }

  @override
  Future<bool> updateProfilePhoto(String uid, String photoURL) async{
    await _firestore.collection("Users").document(uid).updateData({"profilePhotoURL":photoURL}).catchError((e){
      throw Exception("Profile update photo : "+ e);
    }).timeout(Duration(milliseconds: 8500),onTimeout: (){
      throw TimeoutException("Handled timeout exception please try again");
    });
    return true;
  }

  @override
  Future<String> getDownloadURL(String uid, String fileType, File file) async{
    StorageReference _ref =
    _storage.ref().child(uid).child(fileType).child("profil_photo.png");
    var uploadTask = _ref.putFile(file);
    var url = "";
    if (uploadTask.isInProgress) {
      url = await (await uploadTask.onComplete).ref.getDownloadURL();
    }
    return url;
  }

  @override
  Future<bool> deleteLikeFilm(String userId, String cinemaId) async{
    DocumentSnapshot _snapshot = await _firestore.document("Users/$userId").get();
    if(_snapshot.exists){
      User user = User.fromMap(_snapshot.data);
      if(user.likes.contains(cinemaId)){
        user.likes.remove(cinemaId);
      }else{
        throw Exception("Already Defined");
      }
      await this.saveUser(user);
      return true;
    }else{
      throw Exception("Delete Like Film Error");
    }
  }

}