import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bybliotheca_flutter/screens/screens.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../services/user_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _background = const AssetImage("assets/background.png");
  final storage = const FlutterSecureStorage();

  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Future<String?> login(String username, String password) async {
    final url = 'http://bybliotheca.duckdns.org:8080/login';

    final Map<String, dynamic> data = {
      'username': '$username',
      'password': '$password',
    };

    var body = json.encode(data);

    var response = await http.post(
      Uri.parse('http://bybliotheca.duckdns.org:8080/login'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": "Some token"
      },
      body: body,
    );

    final Map<String, dynamic> decodedResponse = json.decode(response.body);

    if (decodedResponse['status'] == 403) {
      final snackBar = SnackBar(
        content: Text('Password or user incorrect.'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (decodedResponse['deleted'] == 1) {
      final snackBar = SnackBar(
        content: Text('User deleted. Please contact the library manager.'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      await storage.write(key: 'token', value: decodedResponse['token']);
      await storage.write(key: 'id', value: decodedResponse['id'].toString());
      Navigator.pushReplacementNamed(context, '/mainmenu');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login',
            style: TextStyle(fontFamily: 'Enchanted Land', fontSize: 40)),
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
