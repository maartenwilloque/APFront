class AlbumOnly {
  String albumId;
  String title;
  int year;
  double rating;

  AlbumOnly(
      {required this.albumId,
      required this.title,
      required this.year,
      required this.rating});

  factory AlbumOnly.fromJson(Map<String, dynamic> json) {
    return AlbumOnly(
        albumId: json['albumId'],
        title: json['title'],
        year: json['year'],
        rating: json['rating']);
  }
}
