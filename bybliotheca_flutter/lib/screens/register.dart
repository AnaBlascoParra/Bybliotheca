import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bybliotheca_flutter/screens/screens.dart';
import '../entities/user.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _background = const AssetImage("assets/background.png");
  User user = User("", "", "", "", "", "");
  String url = "http://localhost:8080/register";

  Future _register() async {
    var res = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json
            .encode({'username': user.username, 'password': user.password}));
    if (res.body != null) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/mainmenu');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
                TextField(
                  controller: TextEditingController(text: user.username),
                  onChanged: (val) {
                    user.username = val;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: TextEditingController(text: user.dni),
                  onChanged: (val) {
                    user.dni = val;
                  },
                  decoration: const InputDecoration(
                    labelText: 'DNI',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: TextEditingController(text: user.email),
                  onChanged: (val) {
                    user.email = val;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: TextEditingController(text: user.password),
                  onChanged: (val) {
                    user.password = val;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: TextEditingController(text: user.name),
                  onChanged: (val) {
                    user.name = val;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: TextEditingController(text: user.surname),
                  onChanged: (val) {
                    user.surname = val;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Surname',
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                    child: Text('Sign up'),
                    onPressed: () {
                      _register();
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
