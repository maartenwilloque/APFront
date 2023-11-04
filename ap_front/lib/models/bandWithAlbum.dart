import 'package:ap_front/models/albumbase.dart';
import 'package:ap_front/models/member.dart';

class BandWithAlbum {
  String bandId;
  String name;
  String nationality;
  List<Member> members;
  List<Albumbase> albums;

  BandWithAlbum(
      {required this.bandId,
      required this.name,
      required this.nationality,
      required this.members,
      required this.albums});

  factory BandWithAlbum.fromJson(Map<String, dynamic> json) {
    var membersFromJson = json['members'];
    List<Member> membersJson = List<dynamic>.from(membersFromJson)
        .map((e) => Member.fromJson(e))
        .toList();
    var albumsFromJson = json['albums'];
    List<Albumbase> albumJson = List<dynamic>.from(albumsFromJson)
        .map((e) => Albumbase.fromJson(e))
        .toList();
    return BandWithAlbum(
        bandId: json['bandId'],
        name: json['name'],
        nationality: json['nationality'],
        members: membersJson,
        albums: albumJson);
  }
}
