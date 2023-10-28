import 'package:ap_front/models/band.dart';
import 'package:ap_front/models/song.dart';

class Album {
  String albumId;
  String title;
  int year;
  Band band;
  List<Song> songs;

  Album(
      {required this.albumId,
      required this.title,
      required this.year,
      required this.band,
      required this.songs});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
        albumId: json['albumId'],
        title: json['title'],
        year: json['year'],
        band: json['band'],
        songs: json['songs']);
  }
}
