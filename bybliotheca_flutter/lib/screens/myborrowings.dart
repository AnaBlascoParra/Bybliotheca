import 'package:flutter/material.dart';

import '../models/models.dart';

class MyBorrowingsScreen extends StatefulWidget {
  final String? userId;

  MyBorrowingsScreen({required this.userId});

  @override
  MyBorrowingsScreenState createState() => MyBorrowingsScreenState();
}

class MyBorrowingsScreenState extends State<MyBorrowingsScreen> {
  late List<Book>? books = [];
  final _background = const AssetImage("assets/background.png");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Borrowings',
            style: TextStyle(fontFamily: 'Enchanted Land', fontSize: 40)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/mainmenu');
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: _background,
            fit: BoxFit.cover,
          ),
        ),
        // child: ListView.builder(
        //   itemCount: authors.length,
        //   itemBuilder: (context, index) {
        //     final author = authors[index];
        //     return ListTile(
        //       title: Text(author),
        //       onTap: () async {
        //         Navigator.pushReplacementNamed(context, '/byauthor');
        //         //books = await fetchBooksByAuthor(author);
        //         // if (books!.isNotEmpty) {
        //         //   navigateToBookDetails(books![0].id);
        //         // }
        //       },
        //     );
        //   },
        // ),
      ),
    );
  }
}
