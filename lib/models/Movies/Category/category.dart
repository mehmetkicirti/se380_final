import 'dart:convert';

Category genreFromJson(String str) => Category.fromMap(json.decode(str));

String genreToJson(Category data) => json.encode(data.toMap());

class Category {
  List<GenreElement> genres;

  Category({
    this.genres,
  });

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    genres: List<GenreElement>.from(json["genres"].map((x) => GenreElement.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "genres": List<dynamic>.from(genres.map((x) => x.toMap())),
  };
}

class GenreElement {
  int id;
  String name;

  GenreElement({
    this.id,
    this.name,
  });

  factory GenreElement.fromMap(Map<String, dynamic> json) => GenreElement(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
  };
}
