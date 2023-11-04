import 'dart:convert';
import 'dart:ffi';

import 'package:ap_front/models/averageRating.dart';
import 'package:ap_front/models/rating.dart';
import 'package:ap_front/models/ratingWithAlbum.dart';
import 'package:http/http.dart' as http;

class RatingApi {
  static String server = 'api-gateway-maartenwilloque.cloud.okteto.net';

//Post Rating
  static Future<Rating> createRating(Rating rating) async {
    var url = Uri.https(server, '/rating');

    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(rating));
    if (response.statusCode == 200) {
      return Rating.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create rating');
    }
  }

//Get Rating
  static Future<AverageRating> getRating(String albumId) async {
    var url = Uri.https(server, '/rating/$albumId');

    final http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return AverageRating.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get rating');
    }
  }

  static Future<String> deleteRating(Long id) async {
    var url = Uri.https(server, '/rating/$id');
    final http.Response response = await http.delete(url);
    if (response.statusCode == 200) {
      return "deleted";
    } else {
      throw Exception('Failed to get rating');
    }
  }

  static Future<List<RatingWithAlbum>> getRatingsWithAlbum(
      String userId) async {
    var url = Uri.https(server, '/ratings/$userId');

    final http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> ratingsJson = json.decode(response.body);
      List<RatingWithAlbum> ratings = ratingsJson
          .map((dynamic item) => RatingWithAlbum.fromJson(item))
          .toList();
      return ratings;
    } else {
      throw Exception('Failed to load ratings');
    }
  }
}
