import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bybliotheca_flutter/screens/screens.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({super.key});
  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  final _frontcover = const AssetImage("assets/frontcover.png");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Stack(fit: StackFit.expand, children: [
          Image(
            image: _frontcover,
            fit: BoxFit.cover,
          )
        ])));
  }
}
