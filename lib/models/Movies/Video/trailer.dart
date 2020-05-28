import 'dart:convert';

Trailer trailerFromJson(String str) => Trailer.fromJson(json.decode(str));

String trailerToJson(Trailer data) => json.encode(data.toJson());

class Trailer {
  int id;
  List<ResultVideo> results;

  Trailer({
    this.id,
    this.results,
  });

  factory Trailer.fromJson(Map<String, dynamic> json) => Trailer(
    id: json["id"],
    results: List<ResultVideo>.from(json["results"].map((x) => ResultVideo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class ResultVideo {
  String id;
  String iso6391;
  String iso31661;
  String key;
  String name;
  String site;
  int size;
  String type;

  ResultVideo({
    this.id,
    this.iso6391,
    this.iso31661,
    this.key,
    this.name,
    this.site,
    this.size,
    this.type,
  });

  factory ResultVideo.fromJson(Map<String, dynamic> json) => ResultVideo(
    id: json["id"],
    iso6391: json["iso_639_1"],
    iso31661: json["iso_3166_1"],
    key: json["key"],
    name: json["name"],
    site: json["site"],
    size: json["size"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "iso_639_1": iso6391,
    "iso_3166_1": iso31661,
    "key": key,
    "name": name,
    "site": site,
    "size": size,
    "type": type,
  };
}
