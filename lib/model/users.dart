import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String middleInitial;
  final String username;
  final String email;
  final String password;
  final int age;
  final String phoneNum;
  final String address;
  final String userType;
  final String pp; // profile picture

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.middleInitial,
    required this.username,
    required this.email,
    required this.password,
    required this.age,
    required this.phoneNum,
    required this.address,
    required this.userType,
    required this.pp,
  });

  // Convert JSON data to User model
  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    firstName: json['firstName'],
    lastName: json['lastName'],
    middleInitial: json['middleInitial'],
    username: json['username'],
    email: json['email'],
    password: json['password'],
    age: json['age'],
    phoneNum: json['phoneNum'],
    address: json['address'],
    userType: json['user_type'],
    pp: json['pp'],
  );

  // Convert User model to JSON data
  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'middleInitial': middleInitial,
    'username': username,
    'email': email,
    'password': password,
    'age': age,
    'phoneNum': phoneNum,
    'address': address,
    'user_type': userType,
    'pp': pp,
  };
}
