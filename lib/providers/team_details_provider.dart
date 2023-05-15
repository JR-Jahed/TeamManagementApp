import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

import '../data/team_details.dart';

class TeamDetailsProvider extends StateNotifier<TeamDetails?> {

  TeamDetailsProvider(): super(null);

  Future<TeamDetails> getTeamDetails(final teamName) async {

    String endpoint = "http://10.0.2.2:8000/get_team_details/";

    Response response = await post(
      Uri.parse(endpoint),
      body: {
        "team_name": teamName
      }
    );

    if(response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final teamDetails = TeamDetails.fromJson(json);

      setTeamDetails = teamDetails;

      return teamDetails;
    }

    throw Exception(response.reasonPhrase);
  }

  TeamDetails? get value => state;

  set setTeamDetails(TeamDetails? val) {
    state = val;
  }
}

final teamDetailsProvider = StateNotifierProvider<TeamDetailsProvider, TeamDetails?>(
      (ref) => TeamDetailsProvider(),
);