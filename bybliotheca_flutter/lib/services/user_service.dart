import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';

class UserService {
  // Future<void> register(String? username, String? dni, String? email,
  //     String? password, String? name, String? surname) async {
  //   try {
  //     var url = 'http://localhost:8080/register';
  //     var data = {
  //       "username": username,
  //       "dni": dni,
  //       "email": email,
  //       "password": password,
  //       "name": name,
  //       "surname": surname,
  //     };
  //     var body = json.encode(data);
  //     var response = await http.post(Uri.parse(url),
  //         headers: {"Content-Type": "application/json"}, body: body);
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  void login(String usernameController, String passwordController) async {
    var url = 'http://localhost:8080/login';

    Map data = {
      'username': '$usernameController',
      'password': '$passwordController',
    };

    var body = json.encode(data);

    var response = await http.post(
      Uri.parse('http://localhost:8080/login'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final token = responseData['token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);
    }
  }

  Future<User> fetchUser(String id) async {
    var url = 'http://localhost:8080/users/$id';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final userData = json.decode(response.body);
      return User(
        username: userData['username'],
        dni: userData['dni'],
        email: userData['email'],
        password: userData['password'],
        name: userData['name'],
        surname: userData['surname'],
      );
    } else {
      throw Exception('Error obtaining user data');
    }
  }
}
