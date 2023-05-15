import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_management/data/add_member_list.dart';
import 'package:team_management/widgets/add_member.dart';
import 'package:team_management/widgets/create_account.dart';
import 'package:team_management/widgets/create_team.dart';
import 'package:team_management/widgets/home.dart';
import 'package:team_management/widgets/login.dart';
import 'package:team_management/widgets/team_details.dart';
import 'package:team_management/widgets/user_profile.dart';
import 'common/routes.dart';

void main() async {

  runApp(
    ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: loginRoute,

        routes: {
          homeRoute: (context) => MyHomePage(null),
          createAccountRoute: (context) => CreateAccount(),
          loginRoute: (context) => Login(),
          userProfileRoute: (context) => const UserProfile(),
          createTeamRoute: (context) => CreateTeam(),
          teamDetailsRoute: (context) => const TeamDetails(),
          addMemberListRoute: (context) => const AddMember(),
        },
      ),
    ),
  );
}
