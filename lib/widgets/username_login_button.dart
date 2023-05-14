import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_management/providers/logged_in_user_provider.dart';
import 'package:team_management/common/routes.dart';

import '../data/user.dart';

class UsernameLoginButton extends ConsumerWidget {
  UsernameLoginButton(this.user, {super.key});

  User? user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () {
        if(this.user != null) {
          ref.read(loggedInUserProvider.notifier).setUser = this.user;
        }

        final user = ref.read(loggedInUserProvider.notifier).value;

        if (user == null) {
          Navigator.of(context).pushNamed(loginRoute);
        }
        else {
          Navigator.of(context).pushNamed(userProfileRoute);
        }
      },
      child: Consumer(
        builder: (context, ref, child) {
          final user = ref.read(loggedInUserProvider.notifier).value;

          return Text(
            user == null ? (this.user == null ? 'Login' : this.user!.name) : user.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          );
        },
      ),
    );
  }
}
