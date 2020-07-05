
abstract class ILikeService{
  Future<bool> likeFilm(String userId,String cinemaId);
  Future<List<String>> getLikes(String userId);
  Future<bool> deleteLikeFilm(String userId,String cinemaId);
}