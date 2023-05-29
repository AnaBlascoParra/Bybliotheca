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
        hintColor: const Color.fromARGB(255, 184, 160, 91),
        appBarTheme: const AppBarTheme(color: Color.fromARGB(255, 51, 32, 14)),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 51, 32, 14),
          unselectedItemColor: Color.fromARGB(255, 184, 160, 91),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const InitScreen(),
      routes: {
        '/mainmenu': (context) => MainMenu(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/allbooks': (context) => AllBooksScreen(),
        '/byauthor': (context) => ByAuthorScreen(),
        '/bygenre': (context) => ByGenreScreen()
      },
    );
  }
}
