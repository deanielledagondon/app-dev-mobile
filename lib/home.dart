import 'package:app_dev_system/cart.dart';
import 'package:app_dev_system/screens/about.dart';
import 'package:app_dev_system/screens/contact.dart';
import 'package:app_dev_system/screens/orders.dart';
import 'package:app_dev_system/screens/search.page.dart';
import 'package:app_dev_system/screens/shop.dart';
import 'package:app_dev_system/user_edit-profile.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;

  List<IconData> iconList = [
    Icons.home,
    Icons.info_outline,
    Icons.email,
    Icons.shopping_bag_outlined,
  ];

  List<String> titleList = [
    'Home',
    'About',
    'Contact',
    'Orders',
  ];

  List<Widget> pageList = [
    Container(),
    AboutPage(),
    ContactPage(),
    OrdersPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8E44AD),
        automaticallyImplyLeading: false,
        title: const Text(
          'makotek',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Rubik',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(),
                ),
              );
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserProfile(),
                ),
              );
            },
            icon: const Icon(Icons.person),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartPage(),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 100,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/home-bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'OUR MISSION IS TO BUILD YOUR DREAM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutPage(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor:
                      MaterialStateProperty.all(const Color(0xFF8E44AD)),
                      minimumSize:
                      MaterialStateProperty.all(const Size(80.0, 48.0)),
                    ),
                    child: const Text(
                      'Discover More',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Rubik',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'LATEST PRODUCTS',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Rubik',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF8E44AD),
        child: const Icon(Icons.add_shopping_cart_outlined),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
              const Shop(), // Replace SearchScreen with your desired screen widget
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        splashColor: Colors.white,
        activeColor: Colors.white,
        icons: iconList,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        backgroundColor: const Color(0xFF8E44AD),
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => pageList[index],
            ),
          );
        },
      ),
    );
  }
}
