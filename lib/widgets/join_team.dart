import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_management/providers/join_team_provider.dart';
import 'package:team_management/providers/logged_in_user_provider.dart';

class JoinTeam extends ConsumerWidget {
  const JoinTeam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Join Team',
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          ref.watch(joinTeamProvider);
          final teams = ref.read(joinTeamProvider.notifier).value;

          if (teams == null) {
            return const CircularProgressIndicator();
          }

          return ListView.builder(
            itemCount: teams.teams.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 16, top: 10, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      teams.teams[index].teamName,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: OutlinedButton(
                            onPressed: () {
                              ref.read(joinTeamProvider.notifier).acceptInvitation(
                                ref.read(loggedInUserProvider.notifier).value,
                                teams.teams[index].teamName,
                              );
                            },
                            child: const Text(
                              'Accept',
                            ),
                          ),
                        ),

                        OutlinedButton(
                          onPressed: () {
                            ref.read(joinTeamProvider.notifier).declineInvitation(
                              ref.read(loggedInUserProvider.notifier).value,
                              teams.teams[index].teamName,
                            );
                          },
                          child: const Text(
                            'Decline',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
