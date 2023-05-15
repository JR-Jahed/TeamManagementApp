import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_management/common/routes.dart';
import 'package:team_management/providers/add_member_list_provider.dart';
import 'package:team_management/providers/team_details_provider.dart';

class TeamDetails extends ConsumerWidget {
  const TeamDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Team',
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {

          ref.watch(teamDetailsProvider);
          final teamDetails = ref.read(teamDetailsProvider.notifier).value;

          if(teamDetails == null) {
            return const CircularProgressIndicator();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  teamDetails.teamName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, bottom: 20),
                child: Text(
                  teamDetails.teamCategory,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, bottom: 10, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Members',
                    ),

                    OutlinedButton(
                      onPressed: () {
                        ref.read(addMemberListProvider.notifier).getAddMemberList(teamDetails.teamName);
                        Navigator.of(context).pushNamed(addMemberListRoute);
                      },
                      child: const Text(
                        'Add Member',
                      ),
                    )
                  ],
                ),
              ),

              ListView.builder(
                itemCount: teamDetails.members.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      teamDetails.members[index].name,
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

















