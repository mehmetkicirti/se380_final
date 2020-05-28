import 'package:se380final/models/User/users.dart';

abstract class IAuthService{
  Future<User> currentUser();
  Future<User> signInWithAnonymously();
  Future<bool> signOut();
  Future<User> signInWithGoogle();
  Future<User> signInWithEmailAndPassword(String email,String password);
  Future<User> createUserWithEmailAndPassword(String email,String password);
  Future<User> signInWithFacebook();
}