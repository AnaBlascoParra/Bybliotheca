import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bybliotheca_flutter/models/models.dart';
import 'package:bybliotheca_flutter/screens/screens.dart';
import 'package:http/http.dart' as http;
import '../services/services.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  UserListScreenState createState() => UserListScreenState();
}

class UserListScreenState extends State<UserListScreen> {
  List<User> users = [];
  final background = const AssetImage("assets/background.png");

  Future<void> getUsers() async {
    final url = 'http://localhost:8080/users';
    String? token = await UserService().readToken();

    final response = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": token!
    });

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      final List<User> fetchedUsers =
          jsonResponse.map((data) => User.fromJson(data)).toList();

      setState(() {
        users = fetchedUsers;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    users.clear();
    getUsers();
  }

  Future<void> updateUser(User updatedUser) async {
    String? token = await UserService().readToken();
    final url = 'http://localhost:8080/users/updateuser';
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

  deleteUser(User deletedUser) async {
    String? token = await UserService().readToken();
    final url = 'http://localhost:8080/books/deleteuser';
    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token!
      },
    );
    if (response.statusCode == 200) {
      Navigator.pushReplacementNamed(context, '/userlist');
    } else {
      throw Exception('Could not delete user');
    }
  }

  // void navigateToUserProfile(String username) async {
  //   String? token = await UserService().readToken();
  //   final url = 'http://localhost:8080/users/username/$username';
  //   final response = await http.get(Uri.parse(url), headers: {
  //     'Content-type': 'application/json',
  //     'Accept': 'application/json',
  //     "Authorization": token!
  //   });

  //   if (response.statusCode == 200) {
  //     final jsonData = json.decode(response.body);
  //     final user = User.fromJson(jsonData);
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => OtherAccountScreen(username: user.username),
  //       ),
  //     );
  //   } else {
  //     throw Exception('Could not fetch user details');
  //   }
  // }

  //UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List',
            style: TextStyle(fontFamily: 'Enchanted Land', fontSize: 40)),
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
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return ListTile(
              title: Text('${user.name} ${user.surname}'),
              onTap: () async {
                // navigateToUserProfile(user.username);
              },
              subtitle: Text(user.username),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      updateUser(user);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteUser(user);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
