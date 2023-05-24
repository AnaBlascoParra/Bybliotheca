import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bybliotheca_flutter/screens/screens.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _dniController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();

  final _background = const AssetImage("assets/background.png");

  RegisterScreen({super.key});

  Future<void> _register(BuildContext context) async {
    final url = 'http://localhost:8080/register';
    final response = await http.post(
      Uri.parse(url),
      body: {
        'username': _usernameController.text,
        'dni': _dniController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'name': _nameController.text,
        'surname': _surnameController.text,
      },
    );

    if (response.statusCode == 200) {
      //print('Account created. Please wait for the admin to verify it.');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainMenu()),
      );
    } else {
      //print('Error!');
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
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _dniController,
                  decoration: const InputDecoration(
                    labelText: 'DNI',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _surnameController,
                  decoration: const InputDecoration(
                    labelText: 'Surname',
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  child: Text('Sign up'),
                  onPressed: () => _register(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
