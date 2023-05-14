import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_management/widgets/create_account.dart';
import 'package:team_management/widgets/home.dart';
import 'package:team_management/widgets/login.dart';
import 'package:team_management/widgets/user_profile.dart';
import 'package:team_management/widgets/username_login_button.dart';
import 'common/constants.dart';
import 'common/routes.dart';
import 'data/user.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final sp = await SharedPreferences.getInstance();
  final user = sp.getString(loggedInUser);

  var userObject;

  if(user != null) {
    final json = jsonDecode(user);
    userObject = User.fromJson(json);
  }

  runApp(
    ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: MyHomePage(UsernameLoginButton(userObject)),

        routes: {
          homeRoute: (context) => MyHomePage(null),
          createAccountRoute: (context) => CreateAccount(),
          loginRoute: (context) => Login(),
          userProfileRoute: (context) => const UserProfile(),
        },
      ),
    ),
  );
}
