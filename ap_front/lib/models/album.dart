import 'package:ap_front/models/band.dart';
import 'package:ap_front/models/song.dart';

class Album {
  String albumId;
  String title;
  int year;
  Band band;
  List<Song> songs;
  double rating;

  Album(
      {required this.albumId,
      required this.title,
      required this.year,
      required this.band,
      required this.songs,
      required this.rating});

  factory Album.fromJson(Map<String, dynamic> json) {
    var bandFomJson = json['band'];
    Band bandJson = Band.fromJson(bandFomJson);
    var songsFromJson = json['songs'];
    List<Song> songsJson =
        List<dynamic>.from(songsFromJson).map((e) => Song.fromJson(e)).toList();

    return Album(
        albumId: json['albumId'],
        title: json['title'],
        year: json['year'],
        band: bandJson,
        songs: songsJson,
        rating: json['rating']);
  }
}
