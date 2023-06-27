import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_dev_system/model/orders.dart';



class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  int userId = 0;

  @override
  void initState() {
    super.initState();
    loginGuestUser();
  }

  Future<void> loginGuestUser() async {
    http.Response response = await http.get(Uri.parse('config.php'));
    if (response.statusCode == 200) {
      setState(() {
        userId = 0; // Set the guest user ID
      });
      http.post(Uri.parse('config.php'), body: {'user_id': userId.toString()});
    }
  }

  Future<void> cancelOrder(String orderId) async {
    http.post(Uri.parse('config.php'), body: {'cancel_order': orderId});
    setState(() {
      // Order cancellation logic
    });
  }

  Future<void> confirmPayment(String orderId) async {
    http.post(Uri.parse('config.php'), body: {'confirm_payment': orderId});
    setState(() {
      // Payment confirmation logic
    });
  }

  Future<void> markOrderAsDelivered(String orderId) async {
    http.post(Uri.parse('config.php'), body: {'delivered_order': orderId});
    setState(() {
      // Order delivery logic
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF8E44AD),

          title: const Text('Order History',
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
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Placed orders',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FutureBuilder<List<Order>>(
                future: fetchOrders(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Order> orders = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        Order order = orders[index];
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Placed on: ${order.placedOn}'),
                              Text('Name: ${order.name}'),
                              Text('Number: ${order.number}'),
                              Text('Email: ${order.email}'),
                              Text('Address: ${order.address}'),
                              Text('Payment Method: ${order.method}'),
                              Text('Orders: ${order.totalProducts}'),
                              Text('Total Price: ₱${order.totalPrice}'),
                              Text(
                                'Order Status: ${order.paymentStatus}',
                                style: TextStyle(
                                  color: order.paymentStatus == 'Pending' ? Colors.red : Colors.green,
                                ),
                              ),
                              Text(
                                'Delivery Status: ${order.deliveryStatus}',
                                style: TextStyle(
                                  color: order.deliveryStatus == 'Pending' ? Colors.red : Colors.green,
                                ),
                              ),
                              Text('Remarks: ${order.remarks}'),
                              if (order.paymentStatus == 'Pending')
                                Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () => cancelOrder(order.id),
                                      child: const Text('Cancel Order'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () => confirmPayment(order.id),
                                      child: const Text('Confirm Payment'),
                                    ),
                                  ],
                                ),
                              if (order.paymentStatus != 'Cancelled' && order.deliveryStatus == 'Delivered')
                                ElevatedButton(
                                  onPressed: () => markOrderAsDelivered(order.id),
                                  child: const Text('Mark as Delivered'),
                                ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
    );
  }

  Future<List<Order>> fetchOrders() async {
    http.Response response = await http.get(Uri.parse('config.php'));
    if (response.statusCode == 200) {
      // Parse the response and return a list of Order objects
      return [];
    } else {
      throw Exception('Failed to fetch orders');
    }
  }
}


