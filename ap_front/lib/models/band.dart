import 'package:ap_front/models/members.dart';

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
    return Band(
        bandId: json['bandId'],
        name: json['name'],
        nationality: json['nationality'],
        members: json['members']);
  }
}
