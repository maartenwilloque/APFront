class AverageRating {
  String albumId;
  double score;

  AverageRating({required this.albumId, required this.score});

  factory AverageRating.fromJson(Map<String, dynamic> json) {
    return AverageRating(albumId: json['albumId'], score: json['score']);
  }
}
