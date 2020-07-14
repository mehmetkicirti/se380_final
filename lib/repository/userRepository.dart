
import 'dart:io';

import 'package:se380final/models/User/users.dart';
import 'package:se380final/services/Abstract/IAuthService.dart';
import 'package:se380final/services/Abstract/IFireStorageService.dart';
import 'package:se380final/services/Abstract/ILikeService.dart';
import 'package:se380final/services/Concrete/user_manager_auth.dart';
import 'package:se380final/services/Concrete/user_manager_firestoreDB.dart';
import 'package:se380final/utils/locator.dart';

class UserRepository implements IAuthService,ILikeService,IFireStorageService{
  UserManagerAuth _firebaseAuthService = locator<UserManagerAuth>();
  UserManagerFirestoreDB _firestoreService = locator<UserManagerFirestoreDB>();

  @override
  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    User user = await _firebaseAuthService.createUserWithEmailAndPassword(
        email, password);
    bool result = await _firestoreService.saveUser(user);
    if(result)
      return await _firestoreService.readUser(user.uid);
    else return null;
  }

  @override
  Future<User> currentUser() async {
    User user =  await _firebaseAuthService.currentUser();
    return user!=null ? _firestoreService.readUser(user.uid):null;
  }

  @override
  Future<User> signInWithAnonymously() async {
    User user =  await _firebaseAuthService.signInWithAnonymously();
    bool result = await _firestoreService.saveUser(user);
    if(result)
      return await _firestoreService.readUser(user.uid);
    else return null;
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    /*dynamic resultEmail = await FormOptions.validateEmail(email);
    dynamic resultPassword = await FormOptions.validatePassword(password);

    if((resultEmail && resultPassword) == null) {
      User user = await _firebaseAuthService.signInWithEmailAndPassword(email, password);
      return _firestoreService.readUser(user.userId);
    }
    else if(resultEmail != null)
      return resultEmail;
    else
      return resultPassword;
     */
    User user = await _firebaseAuthService.signInWithEmailAndPassword(email, password);
    user =await _firestoreService.readUser(user.uid);
    bool result = await _firestoreService.saveUser(user);
    if(result){
      return await _firestoreService.readUser(user.uid);
    }
    else return null;
  }

  @override
  Future<User> signInWithFacebook() async {
    User user =  await _firebaseAuthService.signInWithFacebook();
    user =await _firestoreService.readUser(user.uid);

    if(user == null){
      bool result = await _firestoreService.saveUser(user);
      if(result){
        return await _firestoreService.readUser(user.uid);
      }else return null;
    }else return await _firestoreService.readUser(user.uid);
  }

  @override
  Future<User> signInWithGoogle() async {
    User user =  await _firebaseAuthService.signInWithGoogle();
    user =await _firestoreService.readUser(user.uid);
    bool result = await _firestoreService.saveUser(user);
    if(result){
      return await _firestoreService.readUser(user.uid);
    }
    else return null;
  }

  @override
  Future<bool> signOut() async {
    return await _firebaseAuthService.signOut();
  }

  @override
  Future<List<String>> getLikes(String userId) async{
    return await _firestoreService.getLikes(userId);
  }

  @override
  Future<bool> likeFilm(String userId, String cinemaId) async{
    return await _firestoreService.likeFilm(userId, cinemaId);
  }

  @override
  Future<String> getDownloadURL(String uid, String fileType, File file) async{
      var url = await _firestoreService.getDownloadURL(uid, fileType, file);
      await _firestoreService.updateProfilePhoto(uid, url);
      return url;
  }

  @override
  Future<bool> deleteLikeFilm(String userId, String cinemaId) async{
    return await _firestoreService.deleteLikeFilm(userId, cinemaId);
  }
}
