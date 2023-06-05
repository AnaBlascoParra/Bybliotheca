import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bybliotheca_flutter/models/models.dart';

class BookDetailsScreen extends StatefulWidget {
  final int? bookId;

  BookDetailsScreen({required this.bookId});

  @override
  _BookDetailsScreenState createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  late Future<Book> _bookFuture;

  @override
  void initState() {
    super.initState();
    _bookFuture = fetchBookDetails(widget.bookId);
  }

  Future<Book> fetchBookDetails(int? bookId) async {
    final response = await http.get(Uri.parse('/books/$bookId'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return Book.fromJson(jsonData);
    } else {
      throw Exception('Error! Could not fetch book details.');
    }
  }

  Future<void> updateBook(int? bookId) async {
    final url = Uri.parse('/updateBook');
    final client = http.Client();

    try {
      final response = await client.put(url);
      if (response.statusCode == 200) {
        // Success
      } else {
        throw Exception('Error! Could not update book.');
      }
    } finally {
      client.close();
    }
  }

  Future<void> deleteBook(int? bookId) async {
    final url = Uri.parse('/deleteBook/$bookId');
    final client = http.Client();

    try {
      final response = await client.delete(url);
      if (response.statusCode == 200) {
        // Success
      } else {
        throw Exception('Error! Could not delete book.');
      }
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
      ),
      body: FutureBuilder<Book>(
        future: _bookFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
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
                    'Quantity: ${book.qty}',
                    style: TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    onPressed: () {
                      updateBook(widget.bookId);
                    },
                    icon: Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      deleteBook(widget.bookId);
                    },
                    icon: Icon(Icons.delete_forever),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
