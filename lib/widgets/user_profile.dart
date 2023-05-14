import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_management/common/constants.dart';
import 'package:team_management/providers/logged_in_user_provider.dart';
import 'package:team_management/common/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends ConsumerWidget {
  const UserProfile({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final user = ref.read(loggedInUserProvider.notifier).value;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
        ),
        actions: [
          TextButton(
            onPressed: () async {

              final sp = await SharedPreferences.getInstance();
              sp.remove(loggedInUser);

              ref.read(loggedInUserProvider.notifier).setUser = null;

              Navigator.of(context).pushNamedAndRemoveUntil(homeRoute, (route) => false);
            },
            child: const Text(
              'Logout',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              user!.name,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              user.email,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

}