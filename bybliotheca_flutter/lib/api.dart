import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api{
    
  // Register
  Future register(String usernameController, String dniController, String emailController, String passwordController, String nameController, String surnameController) async {
    var url = 'http://localhost:8080/register';

    Map data = {
      'username':'$usernameController',
      'dni':'$dniController',
      'email':'$emailController',
      'password':'$passwordController',
      'name':'$nameController',
      'surname':'$surnameController'
    };

    var body = json.encode(data);

    var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: body);

  }

  //Login
  void login(String usernameController, String passwordController) async{
    var url = 'http://localhost:8080/login';
    
     Map data = {
      'username':'$usernameController',
      'password':'$passwordController',
    };

    var body = json.encode(data);

    var response = await http.post(
      Uri.parse('http://localhost:8080/login'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

  }



  //CRUD BOOKS

  //Create
  Future addBook(String titleController, String authorController, String summaryController, String genreController, int pagesController, int yearController, int qtyController) async {
    var url = 'http://localhost:8080/addBook';

    Map data = {
      'title': '$titleController',
      'author': '$authorController',
      'summary': '$summaryController',
      'genre': '$genreController',
      'nPages': '$pagesController',
      'year': '$yearController',
      'qty': '$qtyController'
    };

    var body = json.encode(data);

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
  }

  //Update
  Future editBook(String id, String titleController, String authorController, String summaryController, String genreController, int pagesController, int yearController, int qtyController) async {
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

  //Delete
  Future deleteBook(String id) async {
    int bookId = int.parse(id);
    var url = 'http://localhost:8080/deleteBook/$bookId';

    var response =
        await http.delete(Uri.parse(url), headers: {"Content-Type": "application/json"});
  }
  
}


