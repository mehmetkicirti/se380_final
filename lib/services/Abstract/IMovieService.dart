import 'package:se380final/models/Movies/Category/category.dart';
import 'package:se380final/models/Movies/Film/movie.dart';
import 'package:se380final/models/Movies/Search/search_result.dart';
import 'package:se380final/models/Movies/Video/trailer.dart';
import 'package:se380final/models/result.dart';

abstract class IMovieService{
  Future<Trailer> getMoviesVideoById(int id);
  Future<void> getPhoto(String url);
  Future<Result> getByCategoryMovies(int genreId);
  Future<Category> getAllCategoryName({bool isTv = false});
  Future<Result> getUpcomingFilms();
  Future<Result> getNowPlayingFilms();
  Future<ResultSearch> searchByName(String name);
  Future<Movie> getMovieById(int id);
  Future<Result> getSimilarMovies(int id);
  Future<Result> getFilmsByGenreId(int genreId,int page);
}