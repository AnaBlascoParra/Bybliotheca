class User {
  String username;
  String dni;
  String email;
  String password;
  String name;
  String surname;

  User(this.username, this.dni, this.email, this.password, this.name,
      this.surname);

  // factory User.fromJson(Map<String, dynamic> json) {
  //   return User(
  //     id: json['id'],
  //     username: json['username'],
  //     dni: json['dni'],
  //     email: json['email'],
  //     password: json['password'],
  //     name: json['name'],
  //     surname: json['surname'],
  //   );
  // }
}
