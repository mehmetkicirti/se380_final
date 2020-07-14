import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:se380final/models/Movies/Category/category.dart';
import 'package:se380final/models/Movies/Film/movie.dart';
import 'package:se380final/models/Movies/Search/search_result.dart';
import 'package:se380final/models/Movies/Video/trailer.dart';
import 'package:se380final/models/result.dart';
import 'package:se380final/services/Abstract/IMovieService.dart';
class MovieManager implements IMovieService{
  static const apiKey = "2db2a61f1c80d0ecff424dbc5354b726";
  static const baseUrl = "https://api.themoviedb.org/3";
  final http.Client _httpClient = http.Client();

  @override
  Future<Category> getAllCategoryName({bool isTv = false}) async{
    String type = isTv ? "tv" : "movie";
    final url = "$baseUrl/genre/$type/list?api_key=$apiKey";
    final response = await _httpClient.get(url);
    if(response.statusCode != 200){
      if(response.statusCode == 408) {
        throw Exception("When is getting data, is not have any connection..");
      }else{
        throw Exception("When is getting data, there is an error occurred..");
      }
    }
    final responseJSON = jsonDecode(response.body);
    return Category.fromMap(responseJSON);
  }

  @override
  Future<Result> getByCategoryMovies(int genreId) async{
    final url = "$baseUrl/discover/movie?api_key=$apiKey&with_genres=$genreId";
    var response = await _httpClient.get(url);
    if(response.statusCode != 200){
      if(response.statusCode == 408) {
        throw Exception("When is getting data, is not have any connection..");
      }else{
        throw Exception("When is getting data, there is an error occurred..");
      }
    }
    final responseJSON = jsonDecode(response.body);
    return Result.fromMap(responseJSON);
  }

  @override
  Future<Movie> getMovieById(int id) async{
    final url = "$baseUrl/movie/$id?api_key=$apiKey&append_to_response=videos";
    var response = await _httpClient.get(url);
    if(response.statusCode != 200){
      if(response.statusCode == 408) {
        throw Exception("When is getting data, is not have any connection..");
      }else{
        throw Exception("When is getting data, there is an error occurred..");
      }
    }
    final responseJSON = jsonDecode(response.body);
    return Movie.fromMap(responseJSON);
  }

  @override
  Future<Trailer> getMoviesVideoById(int id) async{
    final url = "$baseUrl/movie/videos/$id?api_key=$apiKey";
    var response = await _httpClient.get(url);
    if(response.statusCode != 200){
      if(response.statusCode == 408) {
        throw Exception("When is getting data, is not have any connection..");
      }else{
        throw Exception("When is getting data, there is an error occurred..");
      }
    }
    final responseJSON = jsonDecode(response.body);
    return Trailer.fromJson(responseJSON);
  }

  @override
  Future<Result> getNowPlayingFilms({int page = 1}) async{
    final url = "$baseUrl/movie/now_playing?api_key=$apiKey&page=$page";
    var response = await _httpClient.get(url);
    if(response.statusCode != 200){
      if(response.statusCode == 408) {
        throw Exception("When is getting data, is not have any connection..");
      }else{
        throw Exception("When is getting data, there is an error occurred..");
      }
    }
    final responseJSON = jsonDecode(response.body);
    return Result.fromMap(responseJSON);
  }

  @override
  Future<void> getPhoto(String picture) async{
    final url = "https://image.tmdb.org/t/p/original"+picture;
    var response = await _httpClient.get(url);
    if(response.statusCode != 200){
      if(response.statusCode == 408) {
        throw Exception("When is getting data, is not have any connection..");
      }else{
        throw Exception("When is getting data, there is an error occurred..");
      }
    }
  }

  @override
  Future<Result> getSimilarMovies(int id) async{
    final url = "$baseUrl/movie/$id/similar?api_key=$apiKey";
    var response = await _httpClient.get(url);
    if(response.statusCode != 200){
      if(response.statusCode == 408) {
        throw Exception("When is getting data, is not have any connection..");
      }else{
        throw Exception("When is getting data, there is an error occurred..");
      }
    }
    final responseJSON = jsonDecode(response.body);
    return Result.fromMap(responseJSON);
  }

  @override
  Future<Result> getUpcomingFilms({int page = 1}) async{
    final url = "$baseUrl/movie/upcoming?api_key=$apiKey&page=$page";
    var response = await _httpClient.get(url);
    if(response.statusCode != 200){
      if(response.statusCode == 408) {
        throw Exception("When is getting data, is not have any connection..");
      }else{
        throw Exception("When is getting data, there is an error occurred..");
      }
    }
    final responseJSON = jsonDecode(response.body);
    return Result.fromMap(responseJSON);
  }

  @override
  Future<ResultSearch> searchByName(String name) async{
    String url = "$baseUrl/search/multi?api_key=$apiKey";
    url+=(name == "" ? "" : "&query=$name");
    var response = await _httpClient.get(url);
    if(response.statusCode != 200){
      if(response.statusCode == 408) {
        throw Exception("When is getting data, is not have any connection..");
      }else{
        throw Exception("When is getting data, there is an error occurred..");
      }
    }
    final responseJSON = jsonDecode(response.body);
    return ResultSearch.fromMap(responseJSON);
  }

  @override
  Future<Result> getFilmsByGenreId(int genreId,int page) async{
    String url = "$baseUrl/discover/movie?api_key=$apiKey&page=$page&with_genres=$genreId";
    final response = await _httpClient.get(url);
    if(response.statusCode != 200){
      if(response.statusCode == 408){
        throw Exception("When is getting data, is not have any connection..");
      }else{
        throw Exception("When is getting data, there is an error occurred..");
      }
    }

    final responseJSON =jsonDecode(response.body);
    return Result.fromMap(responseJSON);
  }

}