import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cartItems = [];
  double grandTotal = 0;

  Future<void> updateCart(int cartId, int cartQuantity) async {
    final response = await http.post(
      Uri.parse('YOUR_API_ENDPOINT'),
      body: {
        'cart_id': cartId.toString(),
        'cart_quantity': cartQuantity.toString(),
      },
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Cart quantity updated!'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
                fetchCartItems();
              },
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to update cart quantity.'),
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

  Future<void> deleteCartItem(int cartId) async {
    final response = await http.get(
      Uri.parse('YOUR_API_ENDPOINT?delete=$cartId'),
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Item deleted from cart!'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
                fetchCartItems();
              },
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to delete item from cart.'),
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

  Future<void> deleteAllCartItems() async {
    final response = await http.get(
      Uri.parse('YOUR_API_ENDPOINT?delete_all'),
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('All items deleted from cart!'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
                fetchCartItems();
              },
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to delete items from cart.'),
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

  Future<void> fetchCartItems() async {
    final response = await http.get(
      Uri.parse('YOUR_API_ENDPOINT'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      setState(() {
        cartItems = jsonData['cart_items'];
        grandTotal = jsonData['grand_total'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8E44AD),
        title: Text('Shopping Cart',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Rubik',
          ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (cartItems.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final cartItem = cartItems[index];
                  final cartId = cartItem['id'];

                  return Card(
                    child: ListTile(
                      leading: Image.network(
                        'uploaded_img/${cartItem['image']}',
                        width: 50,
                        height: 50,
                      ),
                      title: Text(cartItem['name']),
                      subtitle: Text('₱${cartItem['price']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => deleteCartItem(cartId),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: 60,
                            child: TextField(
                              onChanged: (value) {
                                // Handle quantity change
                              },
                              onSubmitted: (value) {
                                final cartQuantity = int.parse(value);
                                updateCart(cartId, cartQuantity);
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                isDense: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            if (cartItems.isEmpty)
              Padding(
                padding: EdgeInsets.all(16),
                child: Text('Your cart is empty.'),
              ),
            SizedBox(height: 16),
            if (cartItems.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: deleteAllCartItems,
                    child: Text('Delete All'),
                  ),
                ],
              ),
            SizedBox(height: 16),
            if (cartItems.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Grand Total:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '₱$grandTotal',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 16),
            if (cartItems.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Continue shopping
                    },
                    child: Text('Continue Shopping'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Proceed to checkout
                    },
                    child: Text('Proceed to Checkout'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
