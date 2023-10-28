import 'package:ap_front/models/member.dart';

class Band {
  String bandId;
  String name;
  String nationality;
  List<Member> members;

  Band(
      {required this.bandId,
      required this.name,
      required this.nationality,
      required this.members});

  factory Band.fromJson(Map<String, dynamic> json) {
    var membersFromJson = json['members'];
    List<Member> membersJson = List<dynamic>.from(membersFromJson)
        .map((e) => Member.fromJson(e))
        .toList();
    return Band(
        bandId: json['bandId'],
        name: json['name'],
        nationality: json['nationality'],
        members: membersJson);
  }
}
