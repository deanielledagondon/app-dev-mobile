import 'package:app_dev_system/screens/contact.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF8E44AD),
          title: const Text('About Us',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Rubik',
            ),),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Why choose us?',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Welcome to MakoTek, the leading IT shop that caters to all your computing and gaming needs. At MakoTek, we are dedicated to providing you with the best deals and affordable prices, making top-notch technology accessible to all.',
                    ),
                    const Text(
                      'Conveniently located at C.L. Fule Arcade, M. Basa Street, Cagayan de Oro City, Makotek invites you to step into our world of technology. Explore our showroom, experience the latest innovations, and immerse yourself in the possibilities of the digital realm.',
                    ),
                    const Text(
                      'Join us at MakoTek and let us empower you with the best in technology, affordability, and exceptional customer service.',
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        // Handle button press
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContactPage(),
                          ),
                        );
                      },
                      child: const Text('Contact us'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "client's reviews",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),

                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}



