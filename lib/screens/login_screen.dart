import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projecteiei/main.dart';
import 'package:flutter_projecteiei/screens/create_account_screen.dart';
import 'package:flutter_projecteiei/services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  AuthService _service = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  suffixIcon: Icon(Icons.email, size: 20),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  filled: true, // กำหนดให้มีสีพื้นหลัง
                  fillColor:
                      Colors.blue[100], // กำหนดสีพื้นหลังให้เป็นสีฟ้าอ่อน
                ),
              ),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                suffixIcon: Icon(
                  Icons.lock,
                  size: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                filled: true, // กำหนดให้มีสีพื้นหลัง
                fillColor: Colors.blue[100], // กำหนดสีพื้นหลังให้เป็นสีฟ้าอ่อน
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  bool res = await _service.login(
                      _emailController.text, _passwordController.text);
                  if (res) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Logged in")));

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyHomePage(title: 'Home')));
                  }
                },
                child: const Text("Login")),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreateAccountScreen()));
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue, // กำหนดสีของเส้นขอบเป็นสีน้ำเงิน
                    width: 2, // กำหนดความหนาของเส้นขอบเป็น 2 pixels
                  ),
                  borderRadius: BorderRadius.circular(
                      5), // กำหนดลักษณะของมุมกรอบให้เป็นวงกลม
                ),
                child: Text(
                  "No account? Create Your Account",
                  style: TextStyle(
                    color: Colors.blue, // กำหนดสีของ Text เป็นสีน้ำเงิน
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
