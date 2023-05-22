import 'package:bybliotheca_flutter/screens/screens.dart';
import 'package:flutter/material.dart';

void main() => runApp(const BybliothecaApp());

class BybliothecaApp extends StatelessWidget {
  const BybliothecaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 51, 32, 14),
        accentColor: const Color.fromARGB(255, 184, 160, 91),
        appBarTheme: const AppBarTheme(color: Color.fromARGB(255, 51, 32, 14)),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 51, 32, 14),
          unselectedItemColor: Color.fromARGB(255, 184, 160, 91),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const MainMenu(),
      routes: {
        '/allbooks': (context) => AllBooksScreen(),
        '/byauthor': (context) => ByAuthorScreen(),
        '/bygenre': (context) => ByGenreScreen()
      },
    );
  }
}

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    const BooksMenuScreen(),
    MyAccountScreen(),
    MyBorrowingsScreen()
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
