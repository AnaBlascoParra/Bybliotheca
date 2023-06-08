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
        title: const Text('Register',
            style: TextStyle(fontFamily: 'Enchanted Land', fontSize: 40)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.name,
                    onSaved: (value) => user.username = value!,
                    validator: (value) {
                      return (value != null && value.length >= 3)
                          ? null
                          : 'Username must have more than 6 characters';
                    },
                    decoration: const InputDecoration(
                      hintText: 'Username',
                      labelText: 'Username',
                    ),
                  ),
                  // const SizedBox(height: 16.0),
                  TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.name,
                    onSaved: (value) => user.name = value!,
                    decoration: const InputDecoration(
                      hintText: 'First name',
                      labelText: 'Name',
                    ),
                  ),
                  // const SizedBox(height: 16.0),
                  TextFormField(
                    onSaved: (value) => user.surname = value!,
                    decoration: const InputDecoration(
                      hintText: 'Last name',
                      labelText: 'Surname',
                    ),
                  ),
                  // const SizedBox(height: 16.0),
                  TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        labelText: 'Email', hintText: 'Email Address'),
                    onSaved: (value) => user.email = value!,
                  ),
                  // const SizedBox(height: 16.0),
                  TextFormField(
                      autocorrect: false,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        labelText: 'Dni',
                      ),
                      onSaved: (value) => user.dni = value!,
                      validator: (value) {
                        String pattern = r'^[0-9]{8}[A-Z]$';
                        RegExp regExp = RegExp(pattern);
                        return regExp.hasMatch(value ?? '')
                            ? null
                            : 'DNI must consist of 8 numbers and 1 capital letter';
                      }),
                  // const SizedBox(height: 16.0),
                  TextFormField(
                    autocorrect: false,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      hintText: '*******',
                      labelText: 'Password',
                    ),
                    onSaved: (value) => user.password = value!,
                    validator: (value) {
                      String pattern =
                          r'(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)';
                      RegExp regExp = RegExp(pattern);
                      return regExp.hasMatch(value ?? '')
                          ? null
                          : 'Password must have atleast 1 uppercase letter, 1 lowercase letter, numbers & a special character ';
                    },
                  ),
                  // const SizedBox(height: 16.0),
                  // TextFormField(
                  //   autocorrect: false,
                  //   obscureText: true,
                  //   keyboardType: TextInputType.visiblePassword,
                  //   decoration: const InputDecoration(
                  //     hintText: '*******',
                  //     labelText: 'Confirm Password',
                  //   ),
                  //   validator: (value) {
                  //     return (value != null && value == user.password)
                  //         ? null
                  //         : 'The password and the c_password must be the same';
                  //   },
                  // ),
                  const SizedBox(height: 16.0),
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
