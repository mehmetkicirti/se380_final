
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:se380final/models/User/users.dart';
import 'package:se380final/repository/userRepository.dart';
import 'package:se380final/services/Abstract/IAuthService.dart';
import 'package:se380final/services/Abstract/IFireStorageService.dart';
import 'package:se380final/services/Abstract/ILikeService.dart';
import 'package:se380final/utils/locator.dart';
enum UserState{
  LoadingUser,
  LoadedUser,
  ErrorUser,
  IdleUser
}

class UserViewModel with ChangeNotifier implements IAuthService,ILikeService,IFireStorageService{
  UserState _state = UserState.IdleUser;
  UserRepository _userRepository = locator<UserRepository>();
  User _user;
  List<String> _likes;

  User get user => _user;

  List<String> get likes => _likes;

  UserState get state => _state;

  set state(UserState value) {
    _state = value;
    //each state reload again get it from provider package, therefore each state will check
    notifyListeners();
  }
  UserViewModel(){
    currentUser();
  }
  @override
  Future<User> createUserWithEmailAndPassword(String email, String password) async{
    try{
      state = UserState.LoadingUser;
      _user = await _userRepository.createUserWithEmailAndPassword(email, password);
      return _user;
    }catch(e){
      print("View Model createUserWithEmailAndPassword error $e");
      return null;
    }finally{
      if(_user == null){
        state = UserState.ErrorUser;
      }else{
        state = UserState.LoadedUser;
      }
    }
  }

  @override
  Future<User> currentUser() async{
    String error = "";
    try{
      state = UserState.LoadingUser;
      _user = await _userRepository.currentUser();
      return _user;
    }catch(e){
      print("View Model CurrentUser error $e");
      error += e;
      throw Exception(e);
    }finally{
      if(error != ""){
        state = UserState.ErrorUser;
      }else{
        state = UserState.LoadedUser;
      }
    }
  }

  @override
  Future<User> signInWithAnonymously() async{
    try{
      state = UserState.LoadingUser;
      _user = await _userRepository.signInWithAnonymously();
      return _user;
    }catch(e){
      print("View Model SignInWithAnonymously error $e");
      return null;
    }finally{
      if(_user == null){
        state = UserState.ErrorUser;
      }else{
        state = UserState.LoadedUser;
      }
    }
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async{
    try{
      state = UserState.LoadingUser;
      _user = await _userRepository.signInWithEmailAndPassword(email, password);
      return _user;
    }catch(e){
      print("View Model signInWithEmailAndPassword error $e");
      return null;
    }finally{
      if(_user == null){
        state = UserState.ErrorUser;
      }else{
        state = UserState.LoadedUser;
      }
    }
  }

  @override
  Future<User> signInWithFacebook() async{
    try{
      state = UserState.LoadingUser;
      _user = await _userRepository.signInWithFacebook();
      return _user;
    }catch(e){
      print("View Model signInWithFacebook error $e");
      return null;
    }finally{
      if(_user == null){
        state = UserState.ErrorUser;
      }else{
        state = UserState.LoadedUser;
      }
    }
  }

  @override
  Future<User> signInWithGoogle() async{
    try{
      state = UserState.LoadingUser;
      _user = await _userRepository.signInWithGoogle();
      return _user;
    }catch(e){
      print("View Model signInWithGoogle error $e");
      return null;
    }finally{
      if(_user == null){
        state = UserState.ErrorUser;
      }else{
        state = UserState.LoadedUser;
      }
    }
  }

  @override
  Future<bool> signOut() async {
    try{
      state = UserState.LoadingUser;
      bool result = await _userRepository.signOut();
      _user = null;
      return result;
    }catch(e){
      print("View Model SignOut error $e");
      return null;
    }finally{
      if(_user == null){
        state = UserState.LoadedUser;
      }else{
        state = UserState.ErrorUser;
      }
    }
  }

  @override
  Future<List<String>> getLikes(String userId) async{
    String error = "";
    try{
      state = UserState.LoadingUser;
      _likes = await _userRepository.getLikes(userId);
      return _likes;
    }catch(e){
      print("View Model CurrentUser error $e");
      error += e;
      return null;
    }finally{
      if(error != ""){
        state = UserState.ErrorUser;
      }else{
        state = UserState.LoadedUser;
      }
    }
  }

  @override
  Future<bool> likeFilm(String userId, String cinemaId) async{
    String error = "";
    try{
      state = UserState.LoadingUser;
      bool isTrue = await _userRepository.likeFilm(userId,cinemaId);
      return isTrue;
    }catch(e){
      print("View Model CurrentUser error $e");
      error += e;
      throw Exception(error);
    }finally{
      if(error != ""){
        state = UserState.ErrorUser;
      }else{
        state = UserState.LoadedUser;
      }
    }
  }

  @override
  Future<String> getDownloadURL(String uid, String fileType, File file) async{
    var link =
        await _userRepository.getDownloadURL(uid, fileType,file);
    return link;
  }

  @override
  Future<bool> deleteLikeFilm(String userId, String cinemaId) async{
    String error = "";
    try{
      state = UserState.LoadingUser;
      bool isTrue = await _userRepository.deleteLikeFilm(userId,cinemaId);
      return isTrue;
    }catch(e){
      print("Delete LikeFilm error $e");
      error += e;
      throw Exception(error);
    }finally{
      if(error != ""){
        state = UserState.ErrorUser;
      }else{
        state = UserState.LoadedUser;
      }
    }
  }
}