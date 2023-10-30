import 'package:http/http.dart' as http;
import 'dart:convert';

class ThumbnailApi {
  static String server = 'musicbrainz.org/ws/2/release/';
  static String result = '';

  static Future<String> fetchThumbnail(band, album, {int release = 0}) async {
    var url = Uri.parse(
        'http://musicbrainz.org/ws/2/release/?query=release:$album%20AND%20artist:$band&fmt=json');

    final getImdbResponse = await http.get(url);
    if (getImdbResponse.statusCode == 200) {
      final imdbJsonData =
          jsonDecode(getImdbResponse.body) as Map<String, dynamic>;

      final imdbId = imdbJsonData['releases'][release]['id'];
      final imdbResponse = await http
          .get(Uri.parse('http://coverartarchive.org/release/$imdbId'));
      if (imdbResponse.statusCode == 200) {
        final imdbImageJsonData =
            jsonDecode(imdbResponse.body) as Map<String, dynamic>;
        final imageUrl = imdbImageJsonData['images'][0]['thumbnails']['small'];
        result = imageUrl;
      } else {
        fetchThumbnail(band, album, release: release + 1);
      }
    }
    return result;
  }
}
