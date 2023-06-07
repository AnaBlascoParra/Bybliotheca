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

  Future logout() async {
    await storage.deleteAll();
    return;
  }
}
