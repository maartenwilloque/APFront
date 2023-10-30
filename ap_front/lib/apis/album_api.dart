import 'dart:convert';
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
      throw Exception('Failed to load album');
    }
  }

  /*static Future<int> countAlbums() async {
    var url = Uri.https(server, '/api/albums');
    int result = 0;

    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap = json.decode(response.body);
      result = jsonMap.length;
    }
    return result;
  }*/
}
