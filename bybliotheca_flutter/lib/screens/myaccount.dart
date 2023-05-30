import 'package:flutter/material.dart';

import '../models/models.dart';
import '../services/services.dart';

class MyAccountScreen extends StatefulWidget {
  final String userId;

  MyAccountScreen({required this.userId});

  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  late User _user;
  late UserService _userService;

  @override
  void initState() {
    super.initState();
    _userService = UserService();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    try {
      final user = await _userService.fetchUser(widget.userId);
      setState(() {
        _user = user;
      });
    } catch (e) {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
      ),
      body: _user != null
          ? Column(
              children: [
                Text('Username: ${_user.username}'),
                Text('Name: ${_user.name}'),
                Text('Surname: ${_user.surname}'),
                Text('Email: ${_user.email}'),
                Text('Dni: ${_user.dni}'),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
