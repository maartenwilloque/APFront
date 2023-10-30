class Rating {
  String albumId;
  int score;
  String name;

  Rating({required this.albumId, required this.score, required this.name});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
        albumId: json['albumId'], score: json['score'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {
        'score': score,
        'albumId': albumId,
        'name': name,
      };
}
