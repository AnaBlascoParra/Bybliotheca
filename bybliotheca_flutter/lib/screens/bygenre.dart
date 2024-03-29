import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bybliotheca_flutter/models/models.dart';
import 'package:bybliotheca_flutter/screens/screens.dart';
import 'package:http/http.dart' as http;
import '../services/services.dart';

class BooksByGenreScreen extends StatefulWidget {
  final String genre;

  const BooksByGenreScreen({required this.genre});

  @override
  _BooksByGenreScreenState createState() => _BooksByGenreScreenState();
}

class _BooksByGenreScreenState extends State<BooksByGenreScreen> {
  List<Book> books = [];
  final background = const AssetImage("assets/background.png");

  @override
  void initState() {
    super.initState();
    fetchBooksByGenre(widget.genre);
  }

  Future<void> fetchBooksByGenre(String genre) async {
    final url = 'http://188.171.201.11:8080/books/genre/$genre';
    String? token = await UserService().readToken();
    final response = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": token!
    });
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<Book> fetchedBooks =
          List<Book>.from(jsonData.map((item) => Book.fromJson(item)));
      setState(() {
        books = fetchedBooks;
      });
    }
  }

  void navigateToBookDetails(String title) async {
    String? token = await UserService().readToken();
    final url = 'http://188.171.201.11:8080/books/title/$title';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": token!
    });

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final book = Book.fromJson(jsonData);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookDetailsScreen(title: book.title),
        ),
      );
    } else {
      throw Exception('Could not fetch book details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.genre,
            style: TextStyle(fontFamily: 'Enchanted Land', fontSize: 40)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/genres');
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: background,
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
            return ListTile(
              title: Text(
                '- ${book.title}',
                style: TextStyle(
                  fontFamily: 'Times New Roman',
                  fontSize: 20,
                ),
              ),
              onTap: () async {
                navigateToBookDetails(book.title);
              },
              subtitle: Text(book.author,
                  style: TextStyle(fontStyle: FontStyle.italic)),
              //TO-DO: imagen preview
            );
          },
        ),
      ),
    );
  }
}
