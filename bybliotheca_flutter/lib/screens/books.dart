import 'package:flutter/material.dart';



  // return MaterialApp(
  //       debugShowCheckedModeBanner: false,
  //       home: Scaffold(
  //         appBar: AppBar(
  //           title: const Text('Bybliotheca'),
  //         ),
  //         body: GestureDetector(
  //           onTap:(){
  //           Navigator.pushReplacementNamed(context, 'byauthor');
  //           },
  //           child: Stack(
  //             children: [
  //               Container(
  //                 width: 120,
  //                 height: 40,
  //                 decoration: const BoxDecoration(
  //                   color: Colors.black,
  //                   image: DecorationImage(
  //                     image: AssetImage("assets/_byauthor.png"),
  //                     fit: BoxFit.cover,
  //                   ),
  //                 ),
  //               ),
  //               const Positioned.fill(
  //                 child: Center(
  //                   child: Text(
  //                     "By Author",
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 16,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),