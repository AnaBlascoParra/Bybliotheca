import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bybliotheca_flutter/models/models.dart';
import 'package:bybliotheca_flutter/screens/screens.dart';
import 'package:http/http.dart' as http;

class ByGenreScreen extends StatefulWidget {
  const ByGenreScreen({super.key});

  @override
  ByGenreScreenState createState() => ByGenreScreenState();
}

class ByGenreScreenState extends State<ByGenreScreen> {
  List<String> genres = [];
  final _background = const AssetImage("assets/background.png");

  @override
  void initState() {
    super.initState();
    fetchGenres();
  }

  //ENDPOINTS

  // genres
  Future<void> fetchGenres() async {
    final response = await http.get(Uri.parse('/genres'));

    if (response.statusCode == 200) {
      // Success
      setState(() {
        genres = List<String>.from(json.decode(response.body));
      });
    } else {
      // Failure
      throw Exception('Error! Could not load genres from API.');
    }
  }

  // books/{genre}
  Future<List<Book>> fetchBooksByGenre(String genre) async {
    final response = await http.get(Uri.parse('/books/$genre'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return List<Book>.from(jsonData.map((item) => Book.fromJson(item)));
    } else {
      throw Exception('Error! Could not fetch books from genre.');
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
        title: Text('Genres'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: _background,
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: genres.length,
          itemBuilder: (context, index) {
            final genre = genres[index];
            return ListTile(
              title: Text(genre),
              onTap: () async {
                final books = await fetchBooksByGenre(genre);
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
