import 'dart:convert';

User userJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());


class User {
  int? id;
  String? username;
  String? dni;
  String? email;
  String? password;
  String? name;
  String? surname;

  User({
      this.username,
      this.dni,
      this.email,
      this.password,
      this.name,
      this.surname});

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        dni: json["dni"],
        email: json["email"],
        password: json["password"],
        name: json["name"],
        surname: json["surname"],);

  Map<String, dynamic> toJson() => {
        "username": username,
        "dni": dni,
        "email": email,
        "password": password,
        "name": name,
        "surname": surname
      };
}
