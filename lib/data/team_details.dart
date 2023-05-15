import 'user.dart';

class TeamDetails {
  String teamName;
  String teamCategory;
  List<User> members;

  TeamDetails({
    required this.teamName,
    required this.teamCategory,
    required this.members,
  });

  factory TeamDetails.fromJson(Map<String, dynamic> json) => TeamDetails(
    teamName: json["team_name"],
    teamCategory: json["team_category"],
    members: List<User>.from(
      json["members"].map(
        (x) => User.fromJson(x)
      ),
    ),
  );
}