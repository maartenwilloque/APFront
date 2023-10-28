class Member {
  String firstName;
  String lastName;
  String nickName;
  String instrument;

  Member(
      {required this.firstName,
      required this.lastName,
      required this.nickName,
      required this.instrument});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
        firstName: json['firstName'],
        lastName: json['lastName'],
        nickName: json['nickName'],
        instrument: json['instrument']);
  }
}
