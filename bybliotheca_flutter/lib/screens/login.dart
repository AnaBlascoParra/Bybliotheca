import 'package:flutter/material.dart';
import 'package:bybliotheca_flutter/screens/screens.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _background = const AssetImage("assets/background.png");
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    // Make an HTTP POST request to the Java Spring API
    final response = await http.post(
      Uri.parse('http://localhost:8080/login'),
      headers: {'Content-Type': 'application/json'},
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      // Successful login
      Navigator.pushReplacementNamed(context, '/mainmenu');
    } else {
      // Failed login
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
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  child: const Text('Login'),
                  onPressed: _login,
                ),
                TextButton(
                  child: const Text('Sign up'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
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
