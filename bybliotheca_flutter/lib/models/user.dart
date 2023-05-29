import 'dart:convert';

User userJson(String str) => User.fromJson(json.decode(str));

class User {
  int? id;
  String username;
  String dni;
  String email;
  String password;
  String name;
  String surname;

  User(
      {required this.username,
      required this.dni,
      required this.email,
      required this.password,
      required this.name,
      required this.surname});

  factory User.fromJson(Map<String, dynamic> json) => User(
      username: json['username'],
      dni: json['dni'],
      email: json['email'],
      password: json['password'],
      name: json['name'],
      surname: json['surname']);

  Map<String, dynamic> toJson() => {
        "username": username,
        "dni": dni,
        "email": email,
        "password": password,
        "name": name,
        "surname": surname
      };
}
