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
    final Uri url = Uri.parse('http://your-api-endpoint/login'); // Replace with your API endpoint

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
      MaterialPageRoute(builder: (context) => RegisterPage()), // Replace with your RegisterPage widget
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
                          color: Colors.red,
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                message,
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                        .toList(),
                  ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      String email = _emailController.text;
                      String password = _passwordController.text;
                      login(email, password);
                    }
                  },
                  child: Text('Login'),
                ),
                TextButton(
                  onPressed: () {
                    continueAsGuest(); // Call continueAsGuest function
                  },
                  child: Text('Continue as a Guest'),
                ),
                Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    navigateToRegister(); // Navigate to the RegisterPage
                  },
                  child: Text('Register now'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

