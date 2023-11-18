import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';
import '../services/services.dart';
import 'screens.dart';

class EditBookScreen extends StatefulWidget {
  final String title;

  EditBookScreen({required this.title});

  @override
  _EditBookScreenState createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  late Future<Book> _bookFuture;
  String? _imagePath;
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
      throw Exception('Could not fetch book details');
    }
  }

  Future<void> updateBookDetails(Book updatedBook) async {
    String? token = await UserService().readToken();
    final url = 'http://bybliotheca.duckdns.org:8080/books/updatebook';
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
      throw Exception('Failed to update book details');
    }
  }

  void _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      PlatformFile file = result.files.first;
      setState(() {
        _imagePath = file.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Book',
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
                      initialValue: book.author,
                      decoration: InputDecoration(labelText: 'Author'),
                      onChanged: (value) {
                        book.author = value;
                      },
                    ),
                    TextFormField(
                      initialValue: book.summary,
                      decoration: InputDecoration(labelText: 'Summary'),
                      onChanged: (value) {
                        book.summary = value;
                      },
                    ),
                    TextFormField(
                      initialValue: book.genre,
                      decoration: InputDecoration(labelText: 'Genre'),
                      onChanged: (value) {
                        book.genre = value;
                      },
                    ),
                    TextFormField(
                      initialValue: book.npages.toString(),
                      decoration: InputDecoration(labelText: 'Number of Pages'),
                      onChanged: (value) {
                        book.npages = int.parse(value);
                      },
                    ),
                    TextFormField(
                      initialValue: book.year.toString(),
                      decoration: InputDecoration(labelText: 'Year'),
                      onChanged: (value) {
                        book.year = int.parse(value);
                      },
                    ),
                    TextFormField(
                      initialValue: book.qty.toString(),
                      decoration: InputDecoration(labelText: 'Stock'),
                      onChanged: (value) {
                        book.qty = int.parse(value);
                      },
                    ),
                    TextFormField(
                      initialValue: book.img.toString(),
                      autocorrect: false,
                      decoration: const InputDecoration(
                        labelText: 'Cover',
                      ),
                      readOnly: true,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 48, 25, 6)),
                      ),
                      child: Text('Select new cover'),
                      onPressed: () {
                        _pickImage();
                      },
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 48, 25, 6)),
                      ),
                      onPressed: () {
                        if (_imagePath != null) {
                          book.img = _imagePath!;
                        }
                        updateBookDetails(book);
                      },
                      child: Text('Update Book'),
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
