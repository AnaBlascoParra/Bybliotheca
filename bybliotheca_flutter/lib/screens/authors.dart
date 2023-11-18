import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bybliotheca_flutter/models/models.dart';
import 'package:bybliotheca_flutter/screens/screens.dart';
import 'package:bybliotheca_flutter/services/services.dart';
import 'package:http/http.dart' as http;

class AuthorsScreen extends StatefulWidget {
  @override
  AuthorsScreenState createState() => AuthorsScreenState();
}

class AuthorsScreenState extends State<AuthorsScreen> {
  List<String> authors = [];
  final background = const AssetImage("assets/background.png");

  @override
  void initState() {
    super.initState();
    fetchAuthors();
  }

  Future<void> fetchAuthors() async {
    final url = 'http://bybliotheca.duckdns.org:8080/books';
    String? token = await UserService().readToken();
    final response = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": token!
    });

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      final List<String> fetchedAuthors = [];
      for (final bookData in jsonResponse) {
        final Book book = Book.fromJson(bookData);
        if (!fetchedAuthors.contains(book.author)) {
          fetchedAuthors.add(book.author);
        }
      }

      setState(() {
        authors = fetchedAuthors;
      });
    }
  }

  Future<List<Book>> fetchBooksByAuthor(String author) async {
    final response = await http
        .get(Uri.parse('http://bybliotheca.duckdns.org:8080/books/$author'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return List<Book>.from(jsonData.map((item) => Book.fromJson(item)));
    } else {
      throw Exception('Error! Could not fetch books from author.');
    }
  }

  void navigateToBooksByAuthor(String author) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BooksByAuthorScreen(author: author),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authors',
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
          itemCount: authors.length,
          itemBuilder: (context, index) {
            final author = authors[index];
            return ListTile(
              title: Text(
                '- $author',
                style: TextStyle(
                  fontFamily: 'Times New Roman',
                  fontSize: 20,
                ),
              ),
              onTap: () async {
                navigateToBooksByAuthor(author);
              },
            );
          },
        ),
      ),
    );
  }
}
