import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bybliotheca_flutter/screens/screens.dart';
import 'package:bybliotheca_flutter/models/models.dart';
import '../services/services.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final user = User(
      username: '', dni: '', email: '', password: '', name: '', surname: '');
  final background = const AssetImage("assets/background.png");

  Future<void> register() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      final url = 'http://localhost:8080/register';

      try {
        final response = await http.post(
          Uri.parse(url),
          headers: <String, String>{
            'Content-type': 'application/json',
            'Accept': 'application/json',
            "Authorization": "Some token",
            'Access-Control-Allow-Origin': '*',
          },
          body: jsonEncode(user.toJson()),
        );

        if (response.statusCode == 200) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      } catch (e) {
        print('Connection error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register',style: TextStyle(fontFamily:'Enchanted Land')),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            image: background,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.name,
                    onSaved: (value) => user.username = value!,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                    ),
                  ),
                  // const SizedBox(height: 16.0),
                  TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.name,
                    onSaved: (value) => user.name = value!,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                  ),
                  // const SizedBox(height: 16.0),
                  TextFormField(
                    onSaved: (value) => user.surname = value!,
                    decoration: const InputDecoration(
                      labelText: 'Surname',
                    ),
                  ),
                  // const SizedBox(height: 16.0),
                  TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (value) => user.email = value!,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  // const SizedBox(height: 16.0),
                  TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.name,
                    onSaved: (value) => user.dni = value!,
                    decoration: const InputDecoration(
                      labelText: 'Dni',
                    ),
                  ),
                  // const SizedBox(height: 16.0),
                  TextFormField(
                    autocorrect: false,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    onSaved: (value) => user.password = value!,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  // const SizedBox(height: 16.0),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 48, 25, 6)),
                      ),
                      child: Text('Sign up'),
                      onPressed: () {
                        register();
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
