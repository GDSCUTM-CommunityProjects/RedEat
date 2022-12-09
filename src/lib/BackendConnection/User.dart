import 'package:flutter/foundation.dart';

class User {
  final String username;
  final String password;
  final String first_name;
  final String last_name;
  final String email;

  const User(
      {required this.username,
      required this.password,
      required this.first_name,
      required this.last_name,
      required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      password: json['password'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      email: json['email'],
    );
  }
}
