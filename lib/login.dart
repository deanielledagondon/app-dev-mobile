import 'package:app_dev_system/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'register.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  List<String> _messages = [];

  void login(String email, String password) async {
    final Uri url = Uri.parse(
        'http://your-api-endpoint/login'); // Replace with your API endpoint

    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      // Login successful
      final responseData = json.decode(response.body);

      if (responseData['user_type'] == 'user') {
        // User is a registered user
        final user = responseData['user'];

        // Store user data in shared preferences or a state management solution
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('user_name', user['name']);
        prefs.setString('user_email', user['email']);
        prefs.setString('user_username', user['username']);
        prefs.setInt('user_id', user['id']);
        prefs.setString('user_image', user['pp']);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // User is not a registered user, treat as guest
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('guest', true);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } else {
      // Login failed
      setState(() {
        _messages = ['Incorrect email or password!'];
      });
    }
  }

  void continueAsGuest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('guest', true);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  void navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              RegisterPage()), // Replace with your RegisterPage widget
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      if (_messages.isNotEmpty)
                        Column(
                          children: _messages
                              .map(
                                (message) => Dismissible(
                                  key: Key(message),
                                  direction: DismissDirection.horizontal,
                                  onDismissed: (_) {
                                    setState(() {
                                      _messages.remove(message);
                                    });
                                  },
                                  child: Container(
                                    color: Colors.white,
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          message,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        const Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      const SizedBox(height: 20),
                      const Text(
                        'LOGIN NOW',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Rubik',
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          labelText: 'Email',
                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Rubik'),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                          labelText: 'Password',
                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Rubik'),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            String email = _emailController.text;
                            String password = _passwordController.text;
                            login(email, password);
                          }
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFF8E44AD)),
                          minimumSize:
                              MaterialStateProperty.all(const Size(80.0, 48.0)),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Rubik",
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          continueAsGuest(); // Call continueAsGuest function
                        },
                        child: const Text(
                          'Continue as a Guest',
                          style: TextStyle(
                            color: Color(0xFF8E44AD),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Rubik",
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Rubik",
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          navigateToRegister(); // Navigate to the RegisterPage
                        },
                        child: const Text(
                          'Register now',
                          style: TextStyle(
                            color: Color(0xFF8E44AD),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Rubik",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
