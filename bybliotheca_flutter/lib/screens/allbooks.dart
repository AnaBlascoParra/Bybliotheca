import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bybliotheca_flutter/models/models.dart';
import 'package:bybliotheca_flutter/screens/screens.dart';
import 'package:http/http.dart' as http;
import '../services/services.dart';

class AllBooksScreen extends StatefulWidget {
  const AllBooksScreen({super.key});

  @override
  AllBooksScreenState createState() => AllBooksScreenState();
}

class AllBooksScreenState extends State<AllBooksScreen> {
  List<Book> books = [];
  final background = const AssetImage("assets/background.png");

  Future<void> fetchBooks() async {
    final url = 'http://localhost:8080/books';
    String? token = await UserService().readToken();

    final response = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": token!
    });

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      final List<Book> fetchedBooks =
          jsonResponse.map((data) => Book.fromJson(data)).toList();

      setState(() {
        books = fetchedBooks;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    books.clear();
    fetchBooks();
  }

  void navigateToBookDetails(String title) async {
    String? token = await UserService().readToken();
    final url = 'http://localhost:8080/books/title/$title';
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

  //UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All books',
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
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
            return ListTile(
              title: Text(book.title),
              onTap: () async {
                navigateToBookDetails(book.title);
              },
              subtitle: Text(book.author),
              //TO-DO: imagen preview
            );
          },
        ),
      ),
    );
  }
}
