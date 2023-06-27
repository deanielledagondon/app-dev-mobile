import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_dev_system/model/products.dart';

class Shop extends StatelessWidget {
  const Shop({Key? key});

  Future<List<Products>> fetchProducts() async {
    final response = await http.get(Uri.parse('http://localhost/phpmyadmin/index.php?route=/sql&pos=0&db=makotek&table=products'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<Products> products = [];

      for (var item in jsonData) {
        final product = Products(
          productID: item['productID'],
          userID: item['userID'],
          productName: item['productName'],
          price: item['price'],
          description: item['description'],
          category: item['category'],
          imageURL: item['imageURL'],
          review: item['review'],
        );
        products.add(product);
      }

      return products;
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8E44AD),
        title: const Text('Latest Products',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Rubik',
          ),),
      ),
      body: FutureBuilder<List<Products>>(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final products = snapshot.data!;

            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.productName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product.price.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product.description,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product.description,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Failed to fetch products'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
