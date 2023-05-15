import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import '../data/teams.dart';

class TeamsProvider extends StateNotifier<Teams?> {

  TeamsProvider(): super(null);

  Future<Teams> getTeams(final user) async {
    String endpoint = "http://10.0.2.2:8000/get_teams_of_user/";

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
      return teams;
    }

    throw Exception(response.reasonPhrase);
  }

  Teams? get value => state;

  set setUser(Teams? val) {
    state = val;
  }
}

final teamsProvider = StateNotifierProvider<TeamsProvider, Teams?>(
      (ref) => TeamsProvider(),
);