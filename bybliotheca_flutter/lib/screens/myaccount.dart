import 'package:flutter/material.dart';

import '../models/models.dart';
import '../services/services.dart';

class MyAccountScreen extends StatefulWidget {
  final String username;

  MyAccountScreen({required this.username});

  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  final _background = const AssetImage("assets/background.png");
  late User _user;
  late UserService userService;

  @override
  void initState() {
    super.initState();
    userService = UserService();
    _fetchUser();
  }

  void _fetchUser() async {
    _user = await UserService().getUserById(widget.userId);
    setState(() {});
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
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: _background,
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Username: ${_user.username}'),
              Text('Name: ${_user.name}'),
              Text('Surname: ${_user.surname}'),
              Text('Email: ${_user.email}'),
              Text('Dni:${_user.dni} '),
              const SizedBox(height: 16.0),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 48, 25, 6)),
                  ),
                  child: const Text('Edit'),
                  onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
