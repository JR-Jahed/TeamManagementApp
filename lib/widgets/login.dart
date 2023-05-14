import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:team_management/providers/logged_in_user_provider.dart';
import 'package:team_management/common/routes.dart';
import '../data/user.dart';

class Login extends ConsumerWidget {

  Login({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> sendData(final context, final ref) async {

    String endpoint = "http://10.0.2.2:8000/login_user/";

    try {
      Response response = await post(
          Uri.parse(endpoint),
          body: {
            'email': emailController.text,
            'password': passwordController.text,
          }
      );

      if (response.statusCode == 200) {

        final data = response.body;

        final json = jsonDecode(data);

        final user = User.fromJson(json);

        ref.read(loggedInUserProvider.notifier).setUser = user;

        Navigator.of(context).pushNamedAndRemoveUntil(homeRoute, (route) => false);
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'An error occurred !!!',
            ),
          ),
        );
      }
    }
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'An error occurred !!!'
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
          'Login',
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () {
                  sendData(context, ref);
                },
                child: const Text('Submit'),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Don't have account?",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(createAccountRoute);
                },
                child: const Text('Create Account'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




















