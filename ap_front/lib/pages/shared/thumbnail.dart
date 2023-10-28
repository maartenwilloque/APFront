import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> getThumbnail(band, album) async {
  String imageUrl0 = '';

  final getImdbResponse = await http.get(Uri.parse(
      'http://musicbrainz.org/ws/2/release/?query=release:$album%20AND%20artist:$band&fmt=json'));
  if (getImdbResponse.statusCode == 200) {
    final imdbJsonData =
        jsonDecode(getImdbResponse.body) as Map<String, dynamic>;
    final imdbId = imdbJsonData['releases'][0]['id'];
    final imdbResponse =
        await http.get(Uri.parse('http://coverartarchive.org/release/$imdbId'));
    if (imdbResponse.statusCode == 200) {
      final imdbImageJsonData =
          jsonDecode(imdbResponse.body) as Map<String, dynamic>;
      final imageUrl = imdbImageJsonData['images'][0]['thumbnails']['small'];
      imageUrl0 = imageUrl;
    } else {
      throw Exception('Failed to fetch album thumbnail');
    }
  }

  return imageUrl0;
}
