
import 'package:flutter/material.dart';
import 'package:se380final/models/Movies/Category/category.dart';
import 'package:se380final/models/Movies/Film/movie.dart';
import 'package:se380final/models/Movies/Search/search_result.dart';
import 'package:se380final/models/Movies/Video/trailer.dart';
import 'package:se380final/models/result.dart';
import 'package:se380final/repository/movieRepository.dart';
import 'package:se380final/services/Abstract/IMovieService.dart';
import 'package:se380final/utils/locator.dart';

enum MovieState{
  InitialMovie,
  LoadingMovie,
  LoadedMovie,
  ErrorMovie,
  NotConnected
}

class MovieViewModel with ChangeNotifier implements IMovieService{
  MovieState _state;
  MovieRepository _movieRepository = locator<MovieRepository>();
  Movie _movie;
  Result _result;

  ResultSearch _resultSearch;

  Result _filmsByGenre;

  Trailer _trailer;

  Result _resultUpcoming;

  Category _category;

  Result _resultNowPlaying;

  List<Movie> _likedMovies;

  Result get resultUpcoming => _resultUpcoming;

  Result get filmsByGenre => _filmsByGenre;

  ResultSearch get resultSearch => _resultSearch;

  List<Movie> get likedMovies => _likedMovies;

  MovieState get state => _state;

  set state(MovieState value) {
    _state = value;
    notifyListeners();
  }
  MovieViewModel(){
    state = MovieState.InitialMovie;
    getAllCategoryName().then((_)=>{
      getNowPlayingFilms().then((_)=>{
        getUpcomingFilms()
      })
      // ignore: missing_return
    }).timeout(Duration(seconds: 5),onTimeout: (){
     state = MovieState.NotConnected;
    });
  }
  Movie get movie => _movie;

  Future<List<Movie>> getLikedMovies(List<String> likes) async{
    try{
      _likedMovies = List();
      state = MovieState.LoadingMovie;
      for(String like in likes){
          Movie movie = await _movieRepository.getMovieById(int.parse(like));
          _likedMovies.add(movie);
      }
      return _likedMovies;
    }catch(e){
      debugPrint("Movie getLikedMovies error : $e");
      return null;
    }finally{
      if(_category == null){
        state = MovieState.ErrorMovie;
      }else{
        state = MovieState.LoadedMovie;
      }
    }
  }



  @override
  Future<Category> getAllCategoryName({bool isTv = false}) async{
    try{
      state = MovieState.LoadingMovie;
      _category =await _movieRepository.getAllCategoryName(isTv: isTv);
      return _category;
    }catch(e){
      debugPrint("Movie getAllCategoryName error : $e");
      return null;
    }finally{
      if(_category == null){
        state = MovieState.ErrorMovie;
      }else{
        state = MovieState.LoadedMovie;
      }
    }
  }

  @override
  Future<Result> getByCategoryMovies(int genreId) async{
    state = MovieState.LoadingMovie;
    _result = await _movieRepository.getByCategoryMovies(genreId).then((data){
      _result = data;
      state = MovieState.LoadedMovie;
      return _result;
    }).catchError((e){
      state = MovieState.ErrorMovie;
      print("Error getByCategoryMovies : $e");
      return null;
    });
    return _result;
  }

  @override
  Future<Movie> getMovieById(int id) async{
    try{
      state = MovieState.LoadingMovie;
      _movie =await _movieRepository.getMovieById(id);
      return _movie;
    }catch(e){
      debugPrint("Movie getMovieById error : $e");
      return null;
    }finally{
      if(_movie == null){
        state = MovieState.ErrorMovie;
      }else{
        state = MovieState.LoadedMovie;
      }
    }
  }

  @override
  Future<Trailer> getMoviesVideoById(int id) async{
    try{
      state = MovieState.LoadingMovie;
      _trailer =await _movieRepository.getMoviesVideoById(id);
      return _trailer;
    }catch(e){
      debugPrint("Movie getMoviesVideoById error : $e");
      return null;
    }finally{
      if(_trailer == null){
        state = MovieState.ErrorMovie;
      }else{
        state = MovieState.LoadedMovie;
      }
    }
  }

  @override
  Future<Result> getNowPlayingFilms() async{
    try{
      state = MovieState.LoadingMovie;
      _resultNowPlaying =await _movieRepository.getNowPlayingFilms();
      return _resultNowPlaying;
    }catch(e){
      debugPrint("Movie getNowPlayingFilms error : $e");
      return null;
    }finally{
      if(_resultNowPlaying == null){
        state = MovieState.ErrorMovie;
      }else{
        state = MovieState.LoadedMovie;
      }
    }
  }

  @override
  Future<Result> getSimilarMovies(int id) async{
    try{
      state = MovieState.LoadingMovie;
      _result =await _movieRepository.getSimilarMovies(id);
      return _result;
    }catch(e){
      debugPrint("Movie getSimilarMovies error : $e");
      return null;
    }finally{
      if(_result == null){
        state = MovieState.ErrorMovie;
      }else{
        state = MovieState.LoadedMovie;
      }
    }
  }

  @override
  Future<Result> getUpcomingFilms() async{
    try{
      state = MovieState.LoadingMovie;
      _resultUpcoming =await _movieRepository.getUpcomingFilms();
      return _resultUpcoming;
    }catch(e){
      debugPrint("Movie getUpcomingFilms error : $e");
      return null;
    }finally{
      if(_resultUpcoming == null){
        state = MovieState.ErrorMovie;
      }else{
        state = MovieState.LoadedMovie;
      }
    }
  }

  @override
  Future<ResultSearch> searchByName(String name) async{
    try{
      state = MovieState.LoadingMovie;
      _resultSearch =await _movieRepository.searchByName(name);
      if(_resultSearch == null){
        state = MovieState.ErrorMovie;
        throw Exception("Data is null");
      }else{
        state = MovieState.LoadedMovie;
        return _resultSearch;
      }
    }catch(e){
      debugPrint("Movie searchByName error : $e");
      state = MovieState.ErrorMovie;
      return null;
    }

  }

  Result get result => _result;

  Trailer get video => _trailer;

  Category get category => _category;

  Result get resultNowPlaying => _resultNowPlaying;

  @override
  Future<void> getPhoto(String url) async{
    try{
      state = MovieState.LoadingMovie;
      await _movieRepository.getPhoto(url);
    }catch(e){
      debugPrint("Movie getPhoto error : $e");
      return null;
    }finally{
      if(_result == null){
        state = MovieState.ErrorMovie;
      }else{
        state = MovieState.LoadedMovie;
      }
    }
  }

  @override
  Future<Result> getFilmsByGenreId(int genreId, int page) async{
    try{
      state = MovieState.LoadingMovie;
      _filmsByGenre =await _movieRepository.getFilmsByGenreId(genreId, page);
      return _filmsByGenre;
    }catch(e){
      debugPrint("Movie getFilmsByGenreId error : $e");
      throw Exception("Get Films By Genre "+ e);
    }finally{
      if(_filmsByGenre == null){
        state = MovieState.ErrorMovie;
      }else{
        state = MovieState.LoadedMovie;
      }
    }
  }

}