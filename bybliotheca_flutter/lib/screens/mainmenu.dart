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

  void navigateToMyBorrowings() async {
    String loggedUserId = await UserService().readId();
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyBorrowingsScreen(), //userId: loggedUserId
      ),
    );
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const BooksMenuScreen(),
    MyAccountScreen(),
    // MyBorrowingsScreen() // Eliminamos el tercer elemento
  ];

  void _onItemTapped(int index) {
    setState(() {
      // Ajustamos el manejo de índices si el tercer elemento fue eliminado
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
                  return Container(); // Si no es administrador, no muestra ningún contenido
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
          // Eliminamos el tercer elemento
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.school),
          //   label: 'My Borrowings',
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
