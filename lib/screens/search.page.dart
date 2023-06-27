import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> products = [];
  String message = '';

  Future<void> searchProducts() async {
    final searchItem = searchController.text;
    final response = await http.post(
      Uri.parse('YOUR_API_ENDPOINT'),
      body: {'search': searchItem},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      setState(() {
        products = jsonData['products'];
        if (products.isEmpty) {
          message = 'No result found!';
        } else {
          message = '';
        }
      });
    } else {
      setState(() {
        message = 'Search failed. Please try again.';
      });
    }
  }

  Future<void> addToCart(Map<String, dynamic> product) async {
    final productName = product['name'];
    final productPrice = product['price'];
    final productImage = product['image'];
    final productQuantity = product['product_quantity'];

    final response = await http.post(
      Uri.parse('YOUR_API_ENDPOINT'),
      body: {
        'product_name': productName,
        'product_price': productPrice,
        'product_image': productImage,
        'product_quantity': productQuantity,
      },
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Product added to cart!'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to add product to cart.'),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8E44AD),

        title: Text('Search Page',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Rubik',
          ),),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Search products',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: searchProducts,
                  child: Text('Search'),
                ),
              ],
            ),
          ),
          if (message.isNotEmpty)
            Text(
              message,
              style: TextStyle(fontSize: 18),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () => addToCart(product),
                  child: Card(
                    child: Column(
                      children: [
                        Image.network(
                          'uploaded_img/${product['image']}',
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '₱${product['price']}/-',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
