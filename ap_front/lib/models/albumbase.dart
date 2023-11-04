class Albumbase {
  String albumId;
  String title;
  int year;
  Albumbase({
    required this.albumId,
    required this.title,
    required this.year,
  });

  factory Albumbase.fromJson(Map<String, dynamic> json) {
    return Albumbase(
      albumId: json['albumId'],
      title: json['title'],
      year: json['year'],
    );
  }
}
