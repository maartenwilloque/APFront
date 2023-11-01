import 'dart:convert';

import 'package:ap_front/models/averageRating.dart';
import 'package:ap_front/models/rating.dart';
import 'package:http/http.dart' as http;

class RatingApi {
  static String server = 'user-service-maartenwilloque.cloud.okteto.net';

//Post Rating
  static Future<Rating> createRating(Rating rating) async {
    var url = Uri.https(server, '/api/rating');

    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(rating));
    if (response.statusCode == 201) {
      return Rating.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create rating');
    }
  }

//Get Rating
  static Future<AverageRating> getRating(String albumId) async {
    var url = Uri.https(server, '/api/rating/average/$albumId');

    final http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return AverageRating.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get rating');
    }
  }
}
