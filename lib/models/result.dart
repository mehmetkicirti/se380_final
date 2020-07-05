import 'dart:convert';

Result resultFromJson(String str) => Result.fromMap(json.decode(str));

String resultToJson(Result data) => json.encode(data.toMap());

class Result {
  List<ResultElement> results;
  int page;
  int totalResults;
  //Dates dates;
  int totalPages;

  Result({
    this.results,
    this.page,
    this.totalResults,
    //this.dates,
    this.totalPages,
  });

  factory Result.fromMap(Map<String, dynamic> json) => Result(
    results: List<ResultElement>.from(json["results"].map((x) => ResultElement.fromMap(x))),
    page: json["page"],
    totalResults: json["total_results"],
    //dates: Dates.fromMap(json["dates"]) != null ? Dates.fromMap(json["dates"]) : null,
    totalPages: json["total_pages"],
  );
  Map<String, dynamic> toMap() => {
    "results": List<dynamic>.from(results.map((x) => x.toMap())),
    "page": page,
    "total_results": totalResults,
    //"dates": dates.toMap(),
    "total_pages": totalPages,
  };
}

//class Dates {
//  DateTime maximum;
//  DateTime minimum;
//
//  Dates({
//    this.maximum,
//    this.minimum,
//  });
//
//  factory Dates.fromMap(Map<String, dynamic> json) => Dates(
//    maximum: DateTime.parse(json["maximum"]),
//    minimum: DateTime.parse(json["minimum"]),
//  );
//
//  Map<String, dynamic> toMap() => {
//    "maximum": "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
//    "minimum": "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
//  };
//}

class ResultElement {
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  DateTime releaseDate;

  ResultElement({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  factory ResultElement.fromMap(Map<String, dynamic> json) => ResultElement(
    popularity: json["popularity"].toDouble(),
    voteCount: json["vote_count"],
    video: json["video"],
    posterPath: json['poster_path'] != null ?"https://image.tmdb.org/t/p/original"+json["poster_path"] : "https://tr.123rf.com/klipart-vekt%C3%B6r/mevcut.html?sti=lc7gd1vupx6g1wma79|",
    id: json["id"],
    adult: json["adult"],
    backdropPath: json['backdrop_path'] != null ? "https://image.tmdb.org/t/p/original"+json["backdrop_path"] : "https://tr.123rf.com/klipart-vekt%C3%B6r/mevcut.html?sti=lc7gd1vupx6g1wma79|",
    originalLanguage: json["original_language"],
    originalTitle: json["original_title"],
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    title: json["title"],
    voteAverage: json["vote_average"].toDouble(),
    overview: json["overview"],
    releaseDate: DateTime.parse(json["release_date"]),
  );
  Map<String, dynamic> toMap() => {
    "popularity": popularity,
    "vote_count": voteCount,
    "video": video,
    "poster_path": posterPath,
    "id": id,
    "adult": adult,
    "backdrop_path": backdropPath,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "title": title,
    "vote_average": voteAverage,
    "overview": overview,
    "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
  };
}
