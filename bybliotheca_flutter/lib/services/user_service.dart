import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/models.dart';

class UserService {
  final storage = const FlutterSecureStorage();

  bool isAdmin(User user) {
    return user.role == 'ADMIN';
  }

  readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  readId() async {
    return await storage.read(key: 'id') ?? '';
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

  Future logout() async {
    await storage.deleteAll();
    return;
  }
}
