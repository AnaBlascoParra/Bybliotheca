import 'dart:convert';
import 'package:http/http.dart' as http;

class Api{
    
  // Register
  Future register(String username, String dni, String email, String password, String name, String surname) async {
    var url = 'http://localhost:8080/register';

    Map data = {
      'username':'$usernameController',
      'dni':'$dniController',
      'email':'$emailController',
      'password':'$passwordController',
      'name':'$nameController',
      'surname':'$surnameController'
    };

    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: body);

  }

}