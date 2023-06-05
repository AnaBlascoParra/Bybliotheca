import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';
import 'services.dart';

class BookService {
  final List<Book> books = [];

  Future<List<String>?> getAuthors() async {
    try {
      var url = 'http://localhost:8080/authors';
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<Book> books = booksFromJson(response.body);
        List<String> authors = books.map((book) => book.author).toList();
        return authors;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Book>?> getBooksByAuthor(String author) async {
    try {
      var url = 'http://localhost:8080/books/$author';
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<Book> books = booksFromJson(response.body);
        return books;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future editBook(
      String id,
      String titleController,
      String authorController,
      String summaryController,
      String genreController,
      int pagesController,
      int yearController,
      int qtyController) async {
    var url = 'http://localhost:8080/updateBook';

    int bookId = int.parse(id);

    Map data = {
      'id': '$bookId',
      'title': '$titleController',
      'author': '$authorController',
      'summary': '$summaryController',
      'genre': '$genreController',
      'nPages': '$pagesController',
      'year': '$yearController',
      'qty': '$qtyController'
    };

    var body = json.encode(data);

    var response = await http.put(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
  }

  Future deleteBook(int id) async {
    var url = 'http://localhost:8080/deleteBook/$id';

    var response = await http
        .delete(Uri.parse(url), headers: {"Content-Type": "application/json"});
  }
}
