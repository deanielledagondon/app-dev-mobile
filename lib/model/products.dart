import 'dart:convert';

List<Products> productsFromJson(String str) =>
    List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Products {
  final int productID;
  final int userID;
  final String productName;
  final int price;
  final String description;
  final String category;
  final int imageURL;
  final String review;

  Products({
    required this.productID,
    required this.userID,
    required this.productName,
    required this.price,
    required this.description,
    required this.category,
    required this.imageURL,
    required this.review,
  });
// Convert JSON data to Products model
  factory Products.fromJson(Map<String, dynamic> json) => Products(
    productID: json['productID'],
    userID: json['userID'],
    productName: json['productName'],
    price: json['price'],
    description: json['description'],
    category: json['category'],
    imageURL: json['imageURL'],
    review: json['review'],
  );

// Convert Products model to JSON data
  Map<String, dynamic> toJson() => {
    'productID': productID,
    'userID': userID,
    'productName': productName,
    'price': price,
    'description': description,
    'category': category,
    'imageURL': imageURL,
    'review': review,
  };
}

