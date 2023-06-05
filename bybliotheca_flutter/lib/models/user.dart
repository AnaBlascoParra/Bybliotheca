import 'dart:convert';

User userJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());

class User {
  String username;
  String dni;
  String email;
  String password;
  String name;
  String surname;
  String? role;

  User(
      {required this.username,
      required this.dni,
      required this.email,
      required this.password,
      required this.name,
      required this.surname});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      dni: json['dni'],
      email: json['email'],
      password: json['password'],
      name: json['name'],
      surname: json['surname'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'dni': dni,
      'email': email,
      'password': password,
      'name': name,
      'surname': surname
    };
  }
}
