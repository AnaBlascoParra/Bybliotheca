import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bybliotheca_flutter/models/models.dart';
import 'package:bybliotheca_flutter/screens/screens.dart';
import 'package:http/http.dart' as http;

import '../api.dart';

class AllBooksScreen extends StatefulWidget {
  const AllBooksScreen({super.key});

  @override
  AllBooksScreenState createState() => AllBooksScreenState();
}

class AllBooksScreenState extends State<AllBooksScreen> {
  List<Book> books = [];
  final _background = const AssetImage("assets/background.png");

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  // GET AllBooks
  Future<void> fetchBooks() async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/allbooks'));
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: _background,
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MainMenu(),
            ),
          );
        },
        child: Icon(Icons.arrow_back),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
