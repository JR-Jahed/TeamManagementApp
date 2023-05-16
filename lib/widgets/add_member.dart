import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:team_management/providers/team_details_provider.dart';
import '../providers/add_member_list_provider.dart';

class AddMember extends ConsumerWidget {
  const AddMember({Key? key}) : super(key: key);

  void sendData(final ref, final userId) async {
    String endpoint = "http://10.0.2.2:8000/invite_user/";

    final teamName = ref.read(teamDetailsProvider.notifier).value.teamName;

    print("line 18  $teamName  $userId");

    Response response = await post(
        Uri.parse(endpoint),
        body: {
          "id": userId.toString(),
          "team_name": teamName,
        }
    );

    if(response.statusCode == 200) {
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Member',
        ),
      ),

      body: Consumer(
        builder: (context, ref, child) {

          ref.watch(addMemberListProvider);

          final addMemberList = ref.read(addMemberListProvider.notifier).value;

          if(addMemberList == null) {
            return const CircularProgressIndicator();
          }

          return ListView.builder(
            itemCount: addMemberList.memberList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 16, top: 10, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      addMemberList.memberList[index].name,
                    ),

                    OutlinedButton(
                      onPressed: () {
                        sendData(ref, addMemberList.memberList[index].id);
                      },
                      child: Row(
                        children: const [
                          Text(
                            'Invite',
                          ),
                          Icon(
                            Icons.add,
                          )
                        ],
                      ),
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
