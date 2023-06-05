import 'package:flutter/material.dart';

import '../models/models.dart';
import '../services/services.dart';

class MyAccountScreen extends StatefulWidget {
  //final String userId;

  //MyAccountScreen({required this.userId});

  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  final _background = const AssetImage("assets/background.png");
  late User _user;
  late UserService _userService;

  @override
  void initState() {
    super.initState();
    _userService = UserService();
    //_fetchUser();
  }

  // Future<void> _fetchUser() async {
  //   try {
  //     final user = await _userService.fetchUser(widget.userId);
  //     setState(() {
  //       _user = user;
  //     });
  //   } catch (e) {
  //     //
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/mainmenu');
          },
        ),
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
                Text('Username: '),
                Text('Name: '),
                Text('Surname: '),
                Text('Email: '),
                Text('Dni: '),
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/mainmenu');
        },
        child: Icon(Icons.arrow_back),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('My Account'),
  //     ),
  //     body: //_user != null
  //         /*?*/
  //         Container(
  //       decoration: BoxDecoration(
  //         image: DecorationImage(
  //           image: _background,
  //           fit: BoxFit.cover,
  //         ),
  //       ),
  //       Column(
  //         children: [
  //           Text('Username: '), //${_user.username}
  //           Text('Name: '), //${_user.name}
  //           Text('Surname: '), //${_user.surname}
  //           Text('Email: '), //${_user.email}
  //           Text('Dni: '), //${_user.dni}
  //         ],
  //       ),
  //       //: Center(child: CircularProgressIndicator()),
  //     ),
  //   );
  // }
}
