import 'package:se380final/models/User/likes.dart';

abstract class ILikeService{
  Future<bool> likeFilm(String userId,String cinemaId);
  Future<List<String>> getLikes(String userId);
}