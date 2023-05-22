import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bybliotheca_flutter/classes/book.dart';
import 'package:http/http.dart' as http;

class AllBooksScreen extends StatefulWidget {
  @override
  AllBooksScreenState createState() => AllBooksScreenState();
}

class AllBooksScreenState extends State<AllBooksScreen> {
  
  List<Book> books = [];

  @override
  void initState(){
    super.initState();
    fetchBooks();
  }

   Future<void> fetchBooks() async {
    
    final response = await http.get(Uri.parse('/allbooks'));

    if (response.statusCode == 200) {
      // Success
      final List<dynamic> bookData = json.decode(response.body);
      setState(() {
        books = bookData.map((data) => Book.fromJson(data)).toList();
      });
    } else {
      // Failure
      throw Exception('Error! Could not load books from API.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All books'),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return ListTile(
            title: Text(book.title),
            subtitle: Text(book.author),
            //imagen preview
          );
        },
      ),
    );
  }

}