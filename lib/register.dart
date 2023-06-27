import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

import 'login.dart';

class RegisterPage extends StatefulWidget {
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
  final TextEditingController _confirmPasswordController =
  TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumController = TextEditingController();

  bool _termsAccepted = false;
  String _errorMessage = '';
  String _profilePicture = '';

  Future<void> _uploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final imageBytes = await pickedImage.readAsBytes();
      final base64Image = base64Encode(imageBytes);
      setState(() {
        _profilePicture = base64Image;
      });
    }
  }

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

    // Perform the registration API call
    final response = await http.post(
      Uri.parse('http://your-api-endpoint/register'), // Replace with your API endpoint
      body: {
        'firstName': firstName,
        'lastName': lastName,
        'middleInitial': middleInitial,
        'username': username,
        'email': email,
        'password': password,
        'cpassword': confirmPassword,
        'age': age,
        'address': address,
        'phoneNum': phoneNum,
        'pp': _profilePicture,
        'terms': _termsAccepted.toString(),
      },
    );

    if (response.statusCode == 200) {
      // Registration successful
      final responseData = response.body;

      if (responseData == 'Registered successfully!') {
        // Redirect to login page or perform any other necessary actions
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        setState(() {
          _errorMessage = responseData;
        });
      }
    } else {
      // Registration failed
      setState(() {
        _errorMessage = 'Registration failed. Please try again later.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (_errorMessage.isNotEmpty)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          _errorMessage,
                          style: TextStyle(color: Colors.white),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _errorMessage = '';
                            });
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(labelText: 'First Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your first name.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(labelText: 'Last Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your last name.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _middleInitialController,
                  decoration: InputDecoration(labelText: 'Middle Initial'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your middle initial.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a username.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an email.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please confirm your password.';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _ageController,
                  decoration: InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your age.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your address.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phoneNumController,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone number.';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: _uploadImage,
                  child: Text('Upload Profile Picture'),
                ),
                if (_profilePicture.isNotEmpty)
                  Image.memory(
                    base64Decode(_profilePicture),
                    height: 100,
                  ),
                Row(
                  children: [
                    Checkbox(
                      value: _termsAccepted,
                      onChanged: (value) {
                        setState(() {
                          _termsAccepted = value!;
                        });
                      },
                    ),
                    Text('I agree to the Terms and Conditions'),
                  ],
                ),
                ElevatedButton(
                  onPressed: register,
                  child: Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
