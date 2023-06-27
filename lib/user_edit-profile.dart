import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController middleInitialController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();

  String profileImagePath = '';

  Future<void> fetchUserProfile() async {
    // Make an HTTP request to fetch the user profile data from the API endpoint
    final response = await http.get(Uri.parse('YOUR_API_ENDPOINT'));

    if (response.statusCode == 200) {
      // Parse the response JSON and populate the text controllers
      final jsonData = json.decode(response.body);

      setState(() {
        firstNameController.text = jsonData['firstName'];
        lastNameController.text = jsonData['lastName'];
        middleInitialController.text = jsonData['middleInitial'];
        usernameController.text = jsonData['username'];
        emailController.text = jsonData['email'];
        ageController.text = jsonData['age'];
        addressController.text = jsonData['address'];
        phoneNumController.text = jsonData['phoneNum'];
        profileImagePath = jsonData['pp'];
      });
    } else {
      // Handle error case
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to fetch user profile.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  Future<void> updateUserProfile() async {
    // Extract the updated profile data from the text controllers
    final updatedFirstName = firstNameController.text;
    final updatedLastName = lastNameController.text;
    final updatedMiddleInitial = middleInitialController.text;
    final updatedUsername = usernameController.text;
    final updatedEmail = emailController.text;
    final updatedAge = ageController.text;
    final updatedAddress = addressController.text;
    final updatedPhoneNum = phoneNumController.text;

    // Make an HTTP request to update the user profile data
    final response = await http.post(
      Uri.parse('YOUR_API_ENDPOINT'),
      body: {
        'firstName': updatedFirstName,
        'lastName': updatedLastName,
        'middleInitial': updatedMiddleInitial,
        'username': updatedUsername,
        'email': updatedEmail,
        'age': updatedAge,
        'address': updatedAddress,
        'phoneNum': updatedPhoneNum,
      },
    );

    if (response.statusCode == 200) {
      // Handle success case
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Profile updated successfully.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    } else {
      // Handle error case
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to update profile.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8E44AD),
        title: const Text('Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Rubik',
          ),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (profileImagePath.isNotEmpty)
                CircleAvatar(
                  backgroundImage: NetworkImage(profileImagePath),
                  radius: 60,
                ),
              TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              TextFormField(
                controller: middleInitialController,
                decoration: InputDecoration(labelText: 'Middle Initial'),
              ),
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: ageController,
                decoration: InputDecoration(labelText: 'Age'),
              ),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              TextFormField(
                controller: phoneNumController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: updateUserProfile,
                child: Text('Save Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
