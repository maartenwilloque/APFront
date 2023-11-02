import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<String>> searchSpotify(String query) async {
  const clientId = '13c125885d9646e2a75ec99f562c7bdf';
  const clientSecret = 'f6f912e98eb8469aa61ffab88b7cbbc5';
  final credentials = base64.encode('$clientId:$clientSecret'.codeUnits);

  final response = await http.post(
    Uri.parse('https://accounts.spotify.com/api/token'),
    headers: {
      'Authorization': 'Basic $credentials',
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: {
      'grant_type': 'client_credentials',
    },
  );

  if (response.statusCode == 200) {
    final token = json.decode(response.body)['access_token'];
    final searchResponse = await http.get(
      Uri.parse('https://api.spotify.com/v1/search?q=$query&type=track'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (searchResponse.statusCode == 200) {
      final data = json.decode(searchResponse.body);
      final tracks = data['tracks']['items'];
      List<String> trackUris = [];
      for (var track in tracks) {
        trackUris.add(track['uri']);
      }
      return trackUris;
    }
  }

  return [];
}
