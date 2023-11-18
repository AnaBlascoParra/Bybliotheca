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
    final url = 'http://bybliotheca.duckdns.org:8080/books/title/$title';
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

  deleteBook(String title) async {
    String? token = await UserService().readToken();
    final url = 'http://bybliotheca.duckdns.org:8080/books/deletebook/$title';
    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token!
      },
    );
    if (response.statusCode == 200) {
      Navigator.pushReplacementNamed(context, '/allbooks');
    } else {
      throw Exception('Could not delete book');
    }
  }

  borrowBook(String title) async {
    String _userId = await UserService().readId();
    int userId = int.parse(_userId);
    String? token = await UserService().readToken();
    final url =
        'http://bybliotheca.duckdns.org:8080/books/title/$title/borrow/$userId';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token!
      },
    );
    if (response.statusCode == 200) {
      Navigator.pushReplacementNamed(context, '/allbooks');
    } else {
      throw Exception('Could not borrow book');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book Details',
          style: TextStyle(fontFamily: 'Enchanted Land', fontSize: 40),
        ),
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
        child: Center(
          child: FutureBuilder<Book>(
            future: _bookFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final book = snapshot.data!;
                return Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (book.img != null)
                        Container(
                          width: 170,
                          height: 250,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(File(book.img.toString())),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              book.title,
                              style: TextStyle(
                                fontFamily: 'Enchanted Land',
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Author: ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${book.author}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 3.0),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Summary: ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${book.summary}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 3.0),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Genre: ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${book.genre}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 3.0),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Pages: ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${book.npages}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 3.0),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Year: ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${book.year}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 3.0),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Stock: ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${book.qty}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                FutureBuilder<bool>(
                                  future: UserService().isAdmin(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Container();
                                    } else if (snapshot.hasError) {
                                      return Container();
                                    } else {
                                      final isAdmin = snapshot.data;
                                      if (isAdmin == true) {
                                        return IconButton(
                                          onPressed: () {
                                            navigateToEditScreen(book.title);
                                          },
                                          icon: Icon(Icons.edit),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }
                                  },
                                ),
                                FutureBuilder<bool>(
                                  future: UserService().isAdmin(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Container();
                                    } else if (snapshot.hasError) {
                                      return Container();
                                    } else {
                                      final isAdmin = snapshot.data;
                                      if (isAdmin == true) {
                                        return IconButton(
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
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: Text('Delete'),
                                                      onPressed: () {
                                                        deleteBook(book.title);
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          icon: Icon(Icons.delete_forever),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
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
      ),
    );
  }
}
