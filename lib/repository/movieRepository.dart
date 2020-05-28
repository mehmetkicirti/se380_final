
import 'package:se380final/models/Movies/Category/category.dart';
import 'package:se380final/models/Movies/Film/movie.dart';
import 'package:se380final/models/Movies/Search/search_result.dart';
import 'package:se380final/models/Movies/Video/trailer.dart';
import 'package:se380final/models/result.dart';
import 'package:se380final/services/Abstract/IMovieService.dart';
import 'package:se380final/services/Concrete/movie_manager.dart';
import 'package:se380final/utils/locator.dart';

class MovieRepository implements IMovieService{
  MovieManager _movieService = locator<MovieManager>();

  @override
  Future<Category> getAllCategoryName({bool isTv = false}) {
    return _movieService.getAllCategoryName(isTv:isTv);
  }

  @override
  Future<Result> getByCategoryMovies(int genreId) {
    return _movieService.getByCategoryMovies(genreId);
  }

  @override
  Future<Movie> getMovieById(int id) {
    return _movieService.getMovieById(id);
  }

  @override
  Future<Trailer> getMoviesVideoById(int id) {
    return _movieService.getMoviesVideoById(id);
  }

  @override
  Future<Result> getNowPlayingFilms() {
    return _movieService.getNowPlayingFilms();
  }

  @override
  Future<Result> getSimilarMovies(int id) {
    return _movieService.getSimilarMovies(id);
  }

  @override
  Future<Result> getUpcomingFilms() {
    return _movieService.getUpcomingFilms();
  }

  @override
  Future<ResultSearch> searchByName(String name) {
    return _movieService.searchByName(name);
  }

  @override
  Future<void> getPhoto(String url) {
    return _movieService.searchByName(url);
  }

  @override
  Future<Result> getFilmsByGenreId(int genreId, int page) {
    return _movieService.getFilmsByGenreId(genreId, page);
  }

}