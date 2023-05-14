import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CreateAccount extends StatelessWidget {
  CreateAccount({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> sendData(final context) async {

    String endpoint = "http://10.0.2.2:8000/create_user/";

    try {
      Response response = await post(
          Uri.parse(endpoint),
          body: {
            'name': nameController.text,
            'email': emailController.text,
            'password': passwordController.text,
          }
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Account created successfully !!!',
            ),
          ),
        );

        Navigator.of(context).pop();
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
            'An error occurred !!!',
          ),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
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
                  sendData(context);
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




















