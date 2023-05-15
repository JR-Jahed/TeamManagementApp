import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/add_member_list_provider.dart';

class AddMember extends ConsumerWidget {
  const AddMember({Key? key}) : super(key: key);

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
