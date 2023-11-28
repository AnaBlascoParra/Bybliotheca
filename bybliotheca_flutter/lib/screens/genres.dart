import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bybliotheca_flutter/models/models.dart';
import 'package:bybliotheca_flutter/screens/screens.dart';
import 'package:http/http.dart' as http;
import '../services/services.dart';

class GenresScreen extends StatefulWidget {
  const GenresScreen({super.key});

  @override
  GenresScreenState createState() => GenresScreenState();
}

class GenresScreenState extends State<GenresScreen> {
  List<String> genres = [];
  final background = const AssetImage("assets/background.png");

  @override
  void initState() {
    super.initState();
    fetchGenres();
  }

  Future<void> fetchGenres() async {
    final url = 'http://188.171.201.11:8080/books';
    String? token = await UserService().readToken();
    final response = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": token!
    });

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      final List<String> fetchedGenres = [];
      for (final bookData in jsonResponse) {
        final Book book = Book.fromJson(bookData);
        if (!fetchedGenres.contains(book.genre)) {
          fetchedGenres.add(book.genre);
        }
      }

      setState(() {
        genres = fetchedGenres;
      });
    }
  }

  void navigateToBooksByGenre(String genre) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BooksByGenreScreen(genre: genre),
      ),
    );
  }

  Future<List<Book>> fetchBooksByGenre(String genre) async {
    final response =
        await http.get(Uri.parse('http://188.171.201.11:8080/books/$genre'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return List<Book>.from(jsonData.map((item) => Book.fromJson(item)));
    } else {
      throw Exception('Error! Could not fetch books from genre.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Genres',
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
            image: background,
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: genres.length,
          itemBuilder: (context, index) {
            final genre = genres[index];
            return ListTile(
              title: Text(
                '- $genre',
                style: TextStyle(
                  fontFamily: 'Times New Roman',
                  fontSize: 20,
                ),
              ),
              onTap: () async {
                navigateToBooksByGenre(genre);
              },
            );
          },
        ),
      ),
    );
  }
}
