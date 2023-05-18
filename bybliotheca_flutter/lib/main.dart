import 'package:bybliotheca_flutter/screens/screens.dart';
import 'package:flutter/material.dart';

void main() => runApp(const BybliothecaApp());

class BybliothecaApp extends StatelessWidget {
  const BybliothecaApp({super.key});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      home: MainMenu(),
    );
  }
}

final _byauthor = new AssetImage("assets/byauthor.png");
final _bygenre = new AssetImage("assets/bygenre.png");

class MainMenu extends StatefulWidget{
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() =>
    _MainMenuState();
}

class _MainMenuState extends State<MainMenu>{

  int _selectedIndex = 0;
    static const TextStyle optionStyle =
        TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    static const List<Widget> _widgetOptions = <Widget>[
      //aquí las rutas de cada botón
    ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }
    
  @override
    Widget build(BuildContext context) {
      return Scaffold(
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
            label: 'Nosep',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
       
    }

}

  


