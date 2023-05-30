import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bybliotheca_flutter/models/models.dart';
import 'package:bybliotheca_flutter/screens/screens.dart';
import 'package:bybliotheca_flutter/services/services.dart';
import 'package:http/http.dart' as http;

class ByAuthorScreen extends StatefulWidget {
  final int author;
  ByAuthorScreen({required this.author});
  @override
  ByAuthorScreenState createState() => ByAuthorScreenState();
}

class ByAuthorScreenState extends State<AuthorsScreen> {
  late List<Book>? books = [];

   @override
  void initState() {
    super.initState();
    fetchBooksByAuthor(widget.author);
  }

    void fetchBooksByAuthor(String author) async {
    books = (await BookService().getBooksByAuthor(author))!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}