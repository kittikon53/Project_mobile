import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_projecteiei/screens/login_screen.dart';
import 'package:flutter_projecteiei/services/auth_service.dart';

class CreateAccountScreen extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  AuthService _service = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create account"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(hintText: "Email"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(hintText: "Password"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  bool res = await _service.register(
                      _emailController.text, _passwordController.text);
                  if (res) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("completed")));
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  }
                },
                child: const Text("Create account"))
          ],
        ),
      ),
    );
  }
}
