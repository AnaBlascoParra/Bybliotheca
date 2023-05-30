import 'package:flutter/material.dart';
import 'package:bybliotheca_flutter/screens/screens.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectedIndex = 0;
  late String loggedUserId;
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _extractUserIdFromToken();
  }

  Future<void> _extractUserIdFromToken() async {
    final prefs = await SharedPreferences.getInstance();
    final jwttoken = prefs.getString('jwt_token');
    final token = jwttoken;

    final Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);

    setState(() {
      loggedUserId = decodedToken['sub'];
      _widgetOptions = <Widget>[
        const BooksMenuScreen(),
        MyAccountScreen(userId: loggedUserId),
        MyBorrowingsScreen(userId: loggedUserId)
      ];
    });
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

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
        title: const Text('Bybliotheca'),
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
