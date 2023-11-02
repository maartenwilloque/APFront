import 'dart:convert';
import 'package:ap_front/models/bandWithAlbum.dart';
import 'package:http/http.dart' as http;

class BandApi {
  static String server = 'api-gateway-maartenwilloque.cloud.okteto.net';

  static Future<BandWithAlbum> fetchBandWithAlbums(String bandId) async {
    var url = Uri.https(server, '/band/$bandId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      BandWithAlbum band = json.decode(response.body);

      return band;
    } else {
      throw Exception('Failed to load albums');
    }
  }
}
