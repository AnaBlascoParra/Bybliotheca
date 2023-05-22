import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bybliotheca_flutter/entities/book.dart';
import 'package:bybliotheca_flutter/screens/screens.dart';
import 'package:http/http.dart' as http;


class AllBooksScreen extends StatefulWidget {
  const AllBooksScreen({super.key});

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

  //ENDPOINTS

  // allbooks
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

  void navigateToBookDetails(int bookId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsScreen(bookId: bookId),
      ),
    );
  }

  //UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All books'),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return ListTile(
            title: Text(book.title),
             onTap: () async {
              if (books.isNotEmpty) {
                navigateToBookDetails(books[0].id);
              }
            },
            subtitle: Text(book.author),
            //TO-DO: imagen preview
          );
        },
      ),
    );
  }

}