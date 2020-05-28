import 'dart:io';

abstract class IFireStorageService{
  Future<String> getDownloadURL(String uid, String fileType, File file);
}