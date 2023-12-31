import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:ap_front/models/album.dart';

class AlbumApi {
  static String server = 'api-gateway-maartenwilloque.cloud.okteto.net';

  static Future<Album> fetchAlbum(int id) async {
    var url = Uri.https(server, '/album/$id');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      sleep(const Duration(seconds: 1));
      return fetchAlbum(id);
    }
  }

// Count albums
  static Future<int> countAlbums() async {
    var url = Uri.https(server, '/albums');
    int result = 1;

    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> albumJson = json.decode(response.body);
      result = albumJson.length;
    }
    return result;
  }

// Get all albums
  static Future<List<Album>> fetchAlbums() async {
    var url = Uri.https(server, '/albums');
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

  // Get band with albums
  static Future<List<Album>> fetchAlbumsByBand(String bandId, album) async {
    var url = Uri.https(server, '/albums');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> albumJson = json.decode(response.body);
      List<Album> albums = albumJson
          .map((dynamic item) => Album.fromJson(item))
          .where((element) =>
              element.band.bandId == bandId && element.albumId != album.albumId)
          .toList()
          .cast<Album>();
      return albums;
    } else {
      throw Exception('Failed to load albums');
    }
  }
}
