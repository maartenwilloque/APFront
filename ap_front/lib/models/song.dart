class Song {
  String title;
  int duration;
  String spotifyId;

  Song({required this.title, required this.duration, required this.spotifyId});

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
        title: json['title'],
        duration: json['duration'],
        spotifyId: json['spotifyId']);
  }
}
