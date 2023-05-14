import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_management/common/routes.dart';
import 'package:team_management/widgets/username_login_button.dart';

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
      body: Column(
        children: [

        ],
      ),

    );
  }
}





















