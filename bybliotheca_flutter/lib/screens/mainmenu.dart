import 'package:flutter/material.dart';
import 'package:bybliotheca_flutter/screens/screens.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/services.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});
  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectedIndex = 0;

  void navigateToMyAccount() async {
    String loggedUserId = await UserService().readId();
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyAccountScreen(userId: loggedUserId),
        ),
      );
  }
 
  void navigateToMyBorrowings() async {
    String loggedUserId = await UserService().readId();
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyBorrowingsScreen(userId: loggedUserId),
        ),
      );
  }
  

  static final List<Widget> _widgetOptions = <Widget>[
    const BooksMenuScreen(),
    MyAccountScreen(userId: UserService().readId()), //??: No sé cómo pasarle el userId aquí, no sé si está bien
    MyBorrowingsScreen(userId: UserService().readId())
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Bybliotheca',
            style: TextStyle(fontFamily: 'Enchanted Land', fontSize: 40)),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/addbook');
            },
          ),
        ],
      ),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'My Borrowings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
