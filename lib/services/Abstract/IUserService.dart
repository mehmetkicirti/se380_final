import 'package:se380final/models/User/users.dart';
import 'package:se380final/services/Abstract/IFireStorageService.dart';

abstract class IUserService implements IFireStorageService{
  Future<bool> saveUser(User user);
  Future<User> readUser(String id);
  Future<bool> updateProfilePhoto(String uid, String photoURL);
}