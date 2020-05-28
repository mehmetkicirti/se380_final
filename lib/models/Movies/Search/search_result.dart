import 'dart:convert';

ResultSearch resultSearchFromJson(String str) => ResultSearch.fromMap(json.decode(str));

String resultSearchToJson(ResultSearch data) => json.encode(data.toMap());

class ResultSearch {
  int page;
  int totalResults;
  int totalPages;
  List<SearchElements> results;

  ResultSearch({
    this.page,
    this.totalResults,
    this.totalPages,
    this.results,
  });

  factory ResultSearch.fromMap(Map<String, dynamic> json) => ResultSearch(
    page: json["page"],
    totalResults: json["total_results"],
    totalPages: json["total_pages"],
    results: List<SearchElements>.from(json["results"].map((x) => SearchElements.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "page": page,
    "total_results": totalResults,
    "total_pages": totalPages,
    "results": List<dynamic>.from(results.map((x) => x.toMap())),
  };
}

class SearchElements {
  int voteCount;
  double popularity;
  int id;
  bool video;
  String mediaType;
  double voteAverage;
  String title;
  DateTime releaseDate;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String posterPath;
  String knownForDepartment;
  String name;
  List<SearchElements> knownFor;
  String profilePath;
  int gender;
  String originalName;
  List<String> originCountry;
  DateTime firstAirDate;

  SearchElements({
    this.voteCount,
    this.popularity,
    this.id,
    this.video,
    this.mediaType,
    this.voteAverage,
    this.title,
    this.releaseDate,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.posterPath,
    this.knownForDepartment,
    this.name,
    this.knownFor,
    this.profilePath,
    this.gender,
    this.originalName,
    this.originCountry,
    this.firstAirDate,
  });

  factory SearchElements.fromMap(Map<String, dynamic> json) => SearchElements(
    voteCount: json["vote_count"] == null ? null : json["vote_count"],
    popularity: json["popularity"] == null ? null : json["popularity"].toDouble(),
    id: json["id"],
    video: json["video"] == null ? null : json["video"],
    mediaType: json["media_type"],
    voteAverage: json["vote_average"] == null ? null : json["vote_average"].toDouble(),
    title: json["title"] == null ? null : json["title"],
    releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
    originalLanguage: json["original_language"] == null ? null : json["original_language"],
    originalTitle: json["original_title"] == null ? null : json["original_title"],
    genreIds: json["genre_ids"] == null ? null : List<int>.from(json["genre_ids"].map((x) => x)),
    backdropPath: json["backdrop_path"] == null ? null : json["backdrop_path"],
    adult: json["adult"] == null ? null : json["adult"],
    overview: json["overview"] == null ? null : json["overview"],
    posterPath: json["poster_path"] == null ? null : json["poster_path"],
    knownForDepartment: json["known_for_department"] == null ? null : json["known_for_department"],
    name: json["name"] == null ? null : json["name"],
    knownFor: json["known_for"] == null ? null : List<SearchElements>.from(json["known_for"].map((x) => SearchElements.fromMap(x))),
    profilePath: json["profile_path"] == null ? null : json["profile_path"],
    gender: json["gender"] == null ? null : json["gender"],
    originalName: json["original_name"] == null ? null : json["original_name"],
    originCountry: json["origin_country"] == null ? null : List<String>.from(json["origin_country"].map((x) => x)),
    firstAirDate: json["first_air_date"] == null ? null : DateTime.parse(json["first_air_date"]),
  );

  Map<String, dynamic> toMap() => {
    "vote_count": voteCount == null ? null : voteCount,
    "popularity": popularity == null ? null : popularity,
    "id": id,
    "video": video == null ? null : video,
    "media_type": mediaType,
    "vote_average": voteAverage == null ? null : voteAverage,
    "title": title == null ? null : title,
    "release_date": releaseDate == null ? null : "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    "original_language": originalLanguage == null ? null : originalLanguage,
    "original_title": originalTitle == null ? null : originalTitle,
    "genre_ids": genreIds == null ? null : List<dynamic>.from(genreIds.map((x) => x)),
    "backdrop_path": backdropPath == null ? null : backdropPath,
    "adult": adult == null ? null : adult,
    "overview": overview == null ? null : overview,
    "poster_path": posterPath == null ? null : posterPath,
    "known_for_department": knownForDepartment == null ? null : knownForDepartment,
    "name": name == null ? null : name,
    "known_for": knownFor == null ? null : List<dynamic>.from(knownFor.map((x) => x.toMap())),
    "profile_path": profilePath == null ? null : profilePath,
    "gender": gender == null ? null : gender,
    "original_name": originalName == null ? null : originalName,
    "origin_country": originCountry == null ? null : List<dynamic>.from(originCountry.map((x) => x)),
    "first_air_date": firstAirDate == null ? null : "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
  };
}
