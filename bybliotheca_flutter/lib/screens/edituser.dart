import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bybliotheca_flutter/models/models.dart';
import '../services/services.dart';
import 'screens.dart';

class EditUserScreen extends StatefulWidget {
  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final background = const AssetImage("assets/background.png");
  late Future<User> _user;

  @override
  void initState() {
    super.initState();
    _user = getUserById();
  }

  Future<User> getUserById() async {
    String id = await UserService().readId();
    int userId = int.parse(id);
    final url = 'http://bybliotheca.duckdns.org:8080/users/id/$userId';
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

  Future<void> updateUser(User updatedUser) async {
    String? token = await UserService().readToken();
    final url = 'http://bybliotheca.duckdns.org:8080/users/updateuser';
    final response = await http.put(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': token!
        },
        body: json.encode(updatedUser.toJson()));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final updatedUser = User.fromJson(jsonData);
      Navigator.pushReplacementNamed(context, '/myaccount');
    } else {
      throw Exception('Failed to update user');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit User',
          style: TextStyle(fontFamily: 'Enchanted Land', fontSize: 40),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/myaccount');
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: background,
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<User>(
          future: _user,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final user = snapshot.data!;
              return Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text(
                      '${user.name} ${user.surname}',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextFormField(
                      initialValue: user.username,
                      decoration: InputDecoration(labelText: 'Username'),
                      onChanged: (value) {
                        user.username = value;
                      },
                    ),
                    TextFormField(
                      initialValue: user.email,
                      decoration: InputDecoration(labelText: 'Email'),
                      onChanged: (value) {
                        user.email = value;
                      },
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 48, 25, 6)),
                      ),
                      onPressed: () {
                        updateUser(user);
                      },
                      child: Text('Save'),
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
