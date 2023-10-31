import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:ap_front/models/album.dart';

class AlbumApi {
  static String server = 'album-service-maartenwilloque.cloud.okteto.net';

  static Future<Album> fetchAlbum(int id) async {
    var url = Uri.https(server, '/api/album/$id');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      sleep(const Duration(seconds: 1));
      return fetchAlbum(id);
    }
  }

  static Future<int> countAlbums() async {
    var url = Uri.https(server, '/api/albums');
    int result = 1;

    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> albumJson = json.decode(response.body);
      result = albumJson.length;
    }
    return result;
  }

  static Future<List<Album>> fetchAlbums() async {
    var url = Uri.https(server, '/api/albums');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> albumJson = json.decode(response.body);
      List<Album> albums = albumJson
          .map((dynamic item) => Album.fromJson(item))
          .toList()
          .cast<Album>();
      return albums;
    } else {
      throw Exception('Failed to load albums');
    }
  }

  static Future<List<Album>> fetchAlbumsByBand(String bandId) async {
    var url = Uri.https(server, '/api/albums');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> albumJson = json.decode(response.body);
      List<Album> albums = albumJson
          .map((dynamic item) => Album.fromJson(item))
          .where((element) => element.band.bandId == bandId)
          .toList()
          .cast<Album>();
      return albums;
    } else {
      throw Exception('Failed to load albums');
    }
  }
}
