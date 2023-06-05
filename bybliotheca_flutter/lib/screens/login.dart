import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:bybliotheca_flutter/screens/screens.dart';
import 'package:http/http.dart' as http;

import '../services/user_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _background = const AssetImage("assets/background.png");

  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  void login(String username, String password) async {
    final url = 'http://localhost:8080/login';

    Map data = {
      'username': '$username',
      'password': '$password',
    };

    var body = json.encode(data);

    var response = await http.post(
      Uri.parse('http://localhost:8080/login'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      Navigator.pushReplacementNamed(context, '/mainmenu');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            image: _background,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 48, 25, 6)),
                    ),
                    child: const Text('Login'),
                    onPressed: () {
                      login(usernameController.text.trim(),
                          passwordController.text.trim());
                      // UserService().login(usernameController.text.trim(),passwordController.text.trim());
                    }),
                TextButton(
                  child: const Text(
                    'Sign up',
                    style: TextStyle(color: Color.fromARGB(255, 48, 25, 6)),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/register');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
