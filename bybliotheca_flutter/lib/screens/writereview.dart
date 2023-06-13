import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/models.dart';
import '../services/services.dart';
import 'screens.dart';

class WriteReviewScreen extends StatefulWidget {
  final String title;

  WriteReviewScreen({required this.title});

  @override
  _WriteReviewScreenState createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  late Future<Book> _bookFuture;
  late Future<User> _user;
  String? _imagePath;
  final background = const AssetImage("assets/background.png");

  @override
  void initState() {
    super.initState();
    _user = getUserById();
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
      throw Exception('Could not fetch book details');
    }
  }

  Future<User> getUserById() async {
    String id = await UserService().readId();
    int userId = int.parse(id);
    final url = 'http://localhost:8080/users/id/$userId';
    String? token = await UserService().readToken();
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": token!
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return User.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch user data');
    }
  }


  Future<void> writeReview(Book updatedBook) async {
    String? token = await UserService().readToken();
    String title = widget.title;
    final url = 'http://localhost:8080/books/title/$title';
    final response = await http.put(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': token!
        },
        body: json.encode(updatedBook.toJson()));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final updatedBook = Book.fromJson(jsonData);
      Navigator.pop(context, updatedBook);
      Navigator.pushReplacementNamed(context, '/allbooks');
    } else {
      throw Exception('Failed to write review');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Write review',
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
                    SizedBox(height: 8),
                    Text(
                      'Title: ${book.title}',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Write your review here'),
                      onChanged: (value) {
                        book.reviews.add(value as Long?);
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'How would you rate this book from 1 to 5?'),
                      onChanged: (value) {
                        book.ratings.add(int.parse(value));
                      },
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 48, 25, 6)),
                      ),
                      onPressed: () {
                        writeReview(book);
                      },
                      child: Text('Post review'),
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
