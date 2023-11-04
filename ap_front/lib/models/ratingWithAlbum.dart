import 'package:ap_front/models/albumbase.dart';

class RatingWithAlbum {
  int id;
  String name;
  int score;
  Albumbase album;

  RatingWithAlbum({
    required this.id,
    required this.name,
    required this.score,
    required this.album,
  });

  factory RatingWithAlbum.fromJson(Map<String, dynamic> json) {
    var albumFromJson = json['album'];
    Albumbase albumOnlyJson = Albumbase.fromJson(albumFromJson);
    return RatingWithAlbum(
        id: json['id'],
        name: json['name'],
        score: json['score'],
        album: albumOnlyJson);
  }
}
