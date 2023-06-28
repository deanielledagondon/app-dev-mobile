import 'package:app_dev_system/home.dart';
import 'package:app_dev_system/register.dart';
import 'package:flutter/material.dart';
import 'package:app_dev_system/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Dev',
      theme: ThemeData(
        primaryColor: const Color(0xFF8E44AD),
      ),
      home: LoginPage(),
    );
  }
}