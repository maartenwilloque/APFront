import 'dart:ffi';

import 'package:ap_front/models/albumOnly.dart';

class RatingWithAlbum {
  Long id;
  String name;
  int score;
  AlbumOnly album;

  RatingWithAlbum({
    required this.id,
    required this.name,
    required this.score,
    required this.album,
  });

  factory RatingWithAlbum.fromJson(Map<String, dynamic> json) {
    var albumFromJson = json['album'];
    AlbumOnly albumOnlyJson = AlbumOnly.fromJson(albumFromJson);
    return RatingWithAlbum(
        id: json['id'],
        name: json['name'],
        score: json['score'],
        album: albumOnlyJson);
  }
}
