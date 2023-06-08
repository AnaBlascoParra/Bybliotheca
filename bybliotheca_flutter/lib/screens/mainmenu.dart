import 'package:flutter/material.dart';
import 'package:bybliotheca_flutter/screens/screens.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/services.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const BooksMenuScreen(),
    MyAccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index < 2 ? index : index + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Bybliotheca',
          style: TextStyle(fontFamily: 'Enchanted Land', fontSize: 40),
        ),
        actions: [
          FutureBuilder<bool>(
            future: UserService().isAdmin(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              } else if (snapshot.hasError) {
                return Container();
              } else {
                final isAdmin = snapshot.data;
                if (isAdmin == true) {
                  return IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/addbook');
                    },
                  );
                } else {
                  return Container();
                }
              }
            },
          ),
        ],
      ),
      // Resto del contenido del Scaffold
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'My Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
