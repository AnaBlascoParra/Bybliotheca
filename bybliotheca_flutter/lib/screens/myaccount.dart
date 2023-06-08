import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/services.dart';
import 'package:http/http.dart' as http;

import 'screens.dart';

class MyAccountScreen extends StatefulWidget {
  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  final _background = const AssetImage("assets/background.png");
  late Future<User> _user;

  @override
  void initState() {
    super.initState();
    _user = getUserById();
  }

  Future<User> getUserById() async {
    String id = await UserService().readId();
    int userId = int.parse(id);
    final url = 'http://localhost:8080/users/id/$userId';
    String? token = await UserService().readToken();
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": token!
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return User.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account',
            style: TextStyle(fontFamily: 'Enchanted Land', fontSize: 40)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/mainmenu');
          },
        ),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 48, 25, 6)),
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/userlist');
            },
            child: Text(
              'User List →',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: _background,
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<User>(
          future: _user,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final user = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Username: ${user.username}'),
                    Text('Name: ${user.name}'),
                    Text('Surname: ${user.surname}'),
                    Text('Email: ${user.email}'),
                    Text('Dni:${user.dni} '),
                    const SizedBox(height: 16.0),
                    IconButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/edituser');
                      },
                      icon: Icon(Icons.edit),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
