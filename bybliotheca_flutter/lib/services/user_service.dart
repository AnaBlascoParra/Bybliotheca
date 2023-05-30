import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class UserService {
    
  
  Future register(String? username, String? dni, String? email, String? password, String? name, String? surname) async {
    try {
      var url = 'http://localhost:8080/register';
      var data = {
        "username": username,
        "dni": dni,
        "email": email,
        "password": password,
        "name": name,
        "surname": surname,
      };
      var body = json.encode(data);
      var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    } catch (e) {
      log(e.toString());
    }

  }

  
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

}


