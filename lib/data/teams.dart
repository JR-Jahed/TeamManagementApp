class Teams {

  Teams({
    required this.teams,
  });

  List<Team> teams;

  factory Teams.fromMap(Map<String, dynamic> json) => Teams(
      teams: List<Team>.from(json["teams"].map((x) => Team.fromJson(x)))
  );
}


class Team {
  String teamName;

  Team({
    required this.teamName,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    teamName: json["team"],
  );
}