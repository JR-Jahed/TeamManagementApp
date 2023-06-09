import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_management/common/routes.dart';
import 'package:team_management/providers/join_team_provider.dart';
import 'package:team_management/providers/logged_in_user_provider.dart';
import 'package:team_management/providers/team_details_provider.dart';
import 'package:team_management/widgets/username_login_button.dart';
import '../providers/team_provider.dart';

class MyHomePage extends ConsumerWidget {
  MyHomePage(
      this.widget,
      {
      super.key,
    }
  );

  Widget? widget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'team_management',
        ),
        actions: [
          widget == null ? UsernameLoginButton(null) : widget!,
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(createTeamRoute);
                    },
                    child: const Text(
                      'Create Team',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(joinTeamProvider.notifier).getJoinTeams(
                        ref.read(loggedInUserProvider.notifier).value
                      );
                      Navigator.of(context).pushNamed(joinTeamRoute);
                    },
                    child: const Text(
                      'Join Team',
                    ),
                  ),
                ],
              ),
            ),

            FutureBuilder(
              future: ref.read(teamsProvider.notifier).getTeams(
                ref.read(loggedInUserProvider.notifier).value
              ),
              builder: (context, snapshot) {

                if(snapshot.hasData) {
                  final teams = snapshot.data!.teams;

                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListView.builder(
                      itemCount: teams.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {

                        return ListTile(
                          title: Text(
                            teams[index].teamName,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),

                          onTap: () {
                            ref.read(teamDetailsProvider.notifier).getTeamDetails(teams[index].teamName);
                            Navigator.of(context).pushNamed(teamDetailsRoute);
                          },
                        );
                      },
                    ),
                  );
                }

                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}





















