class Order {
  final String id;
  final String placedOn;
  final String name;
  final String number;
  final String email;
  final String address;
  final String method;
  final int totalProducts;
  final double totalPrice;
  final String paymentStatus;
  final String deliveryStatus;
  final String remarks;

  Order({
    required this.id,
    required this.placedOn,
    required this.name,
    required this.number,
    required this.email,
    required this.address,
    required this.method,
    required this.totalProducts,
    required this.totalPrice,
    required this.paymentStatus,
    required this.deliveryStatus,
    required this.remarks,
  });
}