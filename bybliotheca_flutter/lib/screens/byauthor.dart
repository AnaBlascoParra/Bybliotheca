import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bybliotheca_flutter/entities/book.dart';
import 'package:bybliotheca_flutter/screens/screens.dart';
import 'package:http/http.dart' as http;

class ByAuthorScreen extends StatefulWidget {
  @override
  ByAuthorScreenState createState() => ByAuthorScreenState();
}

class ByAuthorScreenState extends State<ByAuthorScreen> {
  List<String> authors = [];
  final _background = const AssetImage("assets/background.png");

  @override
  void initState() {
    super.initState();
    fetchAuthors();
  }

  //ENDPOINTS

  // authors
  Future<void> fetchAuthors() async {
    final response = await http.get(Uri.parse('/authors'));
    if (response.statusCode == 200) {
      // Success
      setState(() {
        authors = List<String>.from(json.decode(response.body));
      });
    } else {
      // Failure
      throw Exception('Error! Could not load authors from API.');
    }
  }

  // books/{author}
  Future<List<Book>> fetchBooksByAuthor(String author) async {
    final response = await http.get(Uri.parse('/books/$author'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return List<Book>.from(jsonData.map((item) => Book.fromJson(item)));
    } else {
      throw Exception('Error! Could not fetch books by author.');
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
        title: Text('Authors'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: _background,
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: authors.length,
          itemBuilder: (context, index) {
            final author = authors[index];
            return ListTile(
              title: Text(author),
              onTap: () async {
                final books = await fetchBooksByAuthor(author);
                if (books.isNotEmpty) {
                  navigateToBookDetails(books[0].id);
                }
              },
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
