import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bybliotheca_flutter/models/models.dart';
import '../services/services.dart';
import 'screens.dart';

class BookDetailsScreen extends StatefulWidget {
  final String title;

  BookDetailsScreen({required this.title});

  @override
  _BookDetailsScreenState createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  late Future<Book> _bookFuture;
  final background = const AssetImage("assets/background.png");

  @override
  void initState() {
    super.initState();
    _bookFuture = fetchBookDetails(widget.title);
  }

  Future<Book> fetchBookDetails(String title) async {
    final url = 'http://localhost:8080/books/title/$title';
    String? token = await UserService().readToken();
    final response = await http.get(Uri.parse(url), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": token!
    });
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return Book.fromJson(jsonData);
    } else {
      throw Exception('Could not fetch book');
    }
  }

  void navigateToEditScreen(String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditBookScreen(title: title),
      ),
    );
  }

  deleteBook(Book book) async {
    String? token = await UserService().readToken();
    final url = 'http://localhost:8080/books/deletebook';
    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token!
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details',
            style: TextStyle(fontFamily: 'Enchanted Land', fontSize: 40)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
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
        child: FutureBuilder<Book>(
          future: _bookFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final book = snapshot.data!;
              return Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Author: ${book.author}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Summary: ${book.summary}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Genre: ${book.genre}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Number of Pages: ${book.npages}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Year: ${book.year}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Stock: ${book.qty}',
                      style: TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      onPressed: () {
                        navigateToEditScreen(book.title);
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirm Delete'),
                              content: Text(
                                  'Are you sure you want to delete this book?'),
                              actions: [
                                TextButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Delete'),
                                  onPressed: () {
                                    deleteBook(book);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.delete_forever),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
