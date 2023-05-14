import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:team_management/providers/logged_in_user_provider.dart';

import '../common/routes.dart';

class CreateTeam extends ConsumerWidget {
  CreateTeam({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final categoryController = TextEditingController();

  Future<void> sendData(final context, final ref) async {

    String endpoint = "http://10.0.2.2:8000/create_team/";

    try {

      final user = ref.read(loggedInUserProvider.notifier).value;
      final json = jsonDecode(user.toString());

      Response response = await post(
          Uri.parse(endpoint),
          body: {
            'team_name': nameController.text,
            'team_category': categoryController.text,
            'user_id': json["id"].toString(),
          }
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Team created successfully !!!',
            ),
          ),
        );

        Navigator.of(context).pushNamedAndRemoveUntil(homeRoute, (route) => false);
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'An error occurred line 34',
            ),
          ),
        );
      }
    }
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'An error occurred !!!',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Team',
        ),
      ),

      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                height: .5,
                color: Colors.black38,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: 'Team Name',
                ),
              ),
            ),
            Container(
              height: .5,
              color: Colors.black38,
            ),


            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                height: .5,
                color: Colors.black38,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: categoryController,
                decoration: const InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: 'Team Category',
                ),
              ),
            ),
            Container(
              height: .5,
              color: Colors.black38,
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () {
                  sendData(context, ref);
                },
                child: const Text(
                  'Submit',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
