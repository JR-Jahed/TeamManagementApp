import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import '../data/teams.dart';

class JoinTeamProvider extends StateNotifier<Teams?> {

  JoinTeamProvider(): super(null);

  Future<Teams> getJoinTeams(final user) async {
    String endpoint = "http://10.0.2.2:8000/teams_invited/";

    final json = jsonDecode(user.toString());

    Response response = await post(
        Uri.parse(endpoint),
        body: {
          "id": json["id"].toString(),
        }
    );

    if (response.statusCode == 200) {

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final teams = Teams.fromMap(json);

      setUser = teams;

      return teams;
    }

    throw Exception(response.reasonPhrase);
  }

  Future<Teams> acceptInvitation(final user, final teamName) async {
    String endpoint = "http://10.0.2.2:8000/accept_invitation/";
    return acceptDecline(endpoint, user, teamName);
  }

  Future<Teams> declineInvitation(final user, final teamName) async {
    String endpoint = "http://10.0.2.2:8000/decline_invitation/";
    return acceptDecline(endpoint, user, teamName);
  }

  Future<Teams> acceptDecline(final endpoint, final user, final teamName) async {

    final json = jsonDecode(user.toString());

    Response response = await post(
        Uri.parse(endpoint),
        body: {
          "id": json["id"].toString(),
          "team_name": teamName,
        }
    );

    if (response.statusCode == 200) {

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final teams = Teams.fromMap(json);

      setUser = teams;

      return teams;
    }

    throw Exception(response.reasonPhrase);
  }

  Teams? get value => state;

  set setUser(Teams? val) {
    state = val;
  }
}

final joinTeamProvider = StateNotifierProvider<JoinTeamProvider, Teams?>(
      (ref) => JoinTeamProvider(),
);