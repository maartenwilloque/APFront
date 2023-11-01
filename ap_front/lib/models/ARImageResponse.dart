class ARImageResponse {
  String albumId;

  ARImageResponse({required this.albumId});

  factory ARImageResponse.fromJson(Map<String, dynamic> json) {
    return ARImageResponse(albumId: json['albumId']);
  }
}
