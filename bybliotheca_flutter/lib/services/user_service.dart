import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/models.dart';

class UserService {
  final storage = const FlutterSecureStorage();

  Future<bool> isAdmin() async {
    bool isAdmin;
    String id = await UserService().readId();
    int userId = int.parse(id);
    final url = 'http://188.171.201.11:8080/users/id/$userId';
    String? token = await UserService().readToken();
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Authorization": token!
      },
    );

    final Map<String, dynamic> decodedResponse = json.decode(response.body);

    if (decodedResponse['role'] == 'ADMIN') {
      isAdmin = true;
    } else {
      isAdmin = false;
    }
    return isAdmin;
  }

  readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  readId() async {
    return await storage.read(key: 'id') ?? '';
  }

  Future logout() async {
    await storage.deleteAll();
    return;
  }
}
