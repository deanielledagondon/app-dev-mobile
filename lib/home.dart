import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int cartItems = 0; // Track the number of items in the cart

  void addToCart() {
    setState(() {
      cartItems++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          // You can customize the app bar according to your needs
          title: Text('Home'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Header(),
              HomeSection(),
              ProductsSection(addToCart: addToCart),
              AboutSection(),
              HomeContactSection(),
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Header'),
    );
  }
}

class HomeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Our mission is to build your dream'),
          Text('Step into our virtual store and discover a world of possibilities, where quality meets affordability.'),
          ElevatedButton(
            onPressed: () {
              // Add your discover more button functionality here
            },
            child: Text('Discover more'),
          ),
        ],
      ),
    );
  }
}

class ProductsSection extends StatelessWidget {
  final Function addToCart;

  ProductsSection({required this.addToCart});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Latest Products'),
          Container(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 6, // Replace with the actual number of products
              itemBuilder: (context, index) {
                // Replace with your product widget implementation
                return ProductItem(
                  addToCart: addToCart,
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Add your load more button functionality here
            },
            child: Text('Load more'),
          ),
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Function addToCart;

  ProductItem({required this.addToCart});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.asset('images/product-image.jpg'), // Replace with the actual product image
          Text('Product Name'),
          Text('Product Price'),
          ElevatedButton(
            onPressed: () {
              addToCart(); // Call the addToCart function
            },
            child: Text('Add to cart'),
          ),
        ],
      ),
    );
  }
}

class AboutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.asset('images/about-image.jpg'), // Replace with the actual about image
          Text('About Us'),
          Text('Description of the company'),
          ElevatedButton(
            onPressed: () {
              // Add your read more button functionality here
            },
            child: Text('Read more'),
          ),
        ],
      ),
    );
  }
}

class HomeContactSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Have any questions?'),
          ElevatedButton(
            onPressed: () {
              // Add your contact us button functionality here
            },
            child: Text('Contact us'),
          ),
        ],
      ),
    );
  }
}

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Footer'),
    );
  }
}
