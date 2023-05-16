import 'user.dart';

class TeamDetails {
  String teamName;
  String teamCategory;
  int admin;
  List<User> members;

  TeamDetails({
    required this.teamName,
    required this.teamCategory,
    required this.admin,
    required this.members,
  });

  factory TeamDetails.fromJson(Map<String, dynamic> json) => TeamDetails(
    teamName: json["team_name"],
    teamCategory: json["team_category"],
    admin: json["admin"],
    members: List<User>.from(
      json["members"].map(
        (x) => User.fromJson(x)
      ),
    ),
  );
}