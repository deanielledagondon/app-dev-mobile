import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:app_dev_system/model/users.dart';

// import 'package:app_dev_system/conn/api.dart';


import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();


  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _middleInitialController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumController = TextEditingController();

  bool _termsAccepted = false;
  String _errorMessage = '';

  void navigateToLoginPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              LoginPage()),
    );
  }

  Future<void> _uploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final imageBytes = await pickedImage.readAsBytes();
      final base64Image = base64Encode(imageBytes);
      setState(() {
        _profilePicture = base64Image;
      });
    }
  }

  final String _UserType = 'User';
  String _profilePicture = '';

  void register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final middleInitial = _middleInitialController.text;
    final username = _usernameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final age = _ageController.text;
    final address = _addressController.text;
    final phoneNum = _phoneNumController.text;

    // Create a new User instance
    final user = User(
      id: 0, // Set to 0 or default value since it will be assigned by the server
      firstName: firstName,
      lastName: lastName,
      middleInitial: middleInitial,
      username: username,
      email: email,
      password: password,
      age: int.parse(age),
      phoneNum: phoneNum,
      address: address,
      userType: _UserType,
      pp: _profilePicture,
    );

    // Convert the user to JSON
    final userJson = userToJson([user]);

    // Make the POST request to the server
    final response = await http.post(
      Uri.parse('https://app-dev-project.000webhostapp.com/register.php'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: userJson,
    );

    if (response.statusCode == 200) {
      // Registration successful, navigate to login page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      // Registration failed, show error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registration Failed'),
            content: Text('An error occurred while registering. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
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
                  if (_errorMessage.isNotEmpty)
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            _errorMessage,
                            style: TextStyle(color: Colors.black),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _errorMessage = '';
                              });
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 20),
                  const Text(
                    'REGISTER NOW',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Rubik',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _firstNameController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            labelText: 'First Name',
                            labelStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Rubik'),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          controller: _lastNameController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            labelText: 'Last Name',
                            labelStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Rubik'),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          controller: _middleInitialController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            labelText: 'Middle Initial',
                            labelStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Rubik'),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your middle initial';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            labelText: 'Username',
                            labelStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Rubik'),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
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
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
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
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            labelText: 'Confirm Password',
                            labelStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Rubik'),
                          ),
                          obscureText: true,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password.';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match.';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _ageController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            labelText: 'Age',
                            labelStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Rubik'),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your age.';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          controller: _addressController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            labelText: 'Address',
                            labelStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Rubik'),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your address.';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _phoneNumController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      labelText: 'Phone No.',
                      labelStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Rubik'),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
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
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton(
                        onPressed: _uploadImage,
                        child: Text(
                          'Upload Profile Picture',
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all(const Color(0xFF8E44AD)),
                          minimumSize:
                              MaterialStateProperty.all(const Size(80.0, 48.0)),
                        ),
                      ),
                    ),
                  ),
                  if (_profilePicture.isNotEmpty)
                    Image.memory(
                      base64Decode(_profilePicture),
                      height: 100,
                    ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: _termsAccepted,
                        onChanged: (value) {
                          setState(() {
                            _termsAccepted = value!;
                          });
                        },
                        checkColor: Colors.white, // Set the check color
                        fillColor: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.selected)) {
                            return Color(0xFF8E44AD); // Set the fill color when selected
                          } else {
                            return Colors.grey; // Set the default fill color
                          }
                        }),
                      ),
                      const Text(
                        'I agree to the Terms and Conditions',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: register,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF8E44AD)),
                      minimumSize:
                          MaterialStateProperty.all(const Size(80.0, 48.0)),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Rubik",
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      navigateToLoginPage(); // Navigate to the RegisterPage
                    },
                    child: const Text(
                      'Login now',
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
        ),
      ),
    );
  }
}
