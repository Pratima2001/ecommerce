import 'package:ecommerce1/Pages/Purchase/cartPage.dart';
import 'package:ecommerce1/Pages/favouriteProducts.dart';
import 'package:ecommerce1/Pages/homePage.dart';
import 'package:ecommerce1/Pages/profileScreen.dart';
import 'package:ecommerce1/Pages/subpage.dart';
import 'package:flutter/material.dart';

class AppComponent extends StatefulWidget {
  const AppComponent({super.key});

  @override
  State<AppComponent> createState() => _AppComponentState();
}

class _AppComponentState extends State<AppComponent> {
  int selectedIndex = 0;
  final List<Widget> _pages = [
    const HomePage(),
    SearchProducts(
      showAllProducts: true,
    ),
    FavouriteProducts(),
    CartPage(
      showBackbutton: false,
    ),
    ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: _pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (s) {
          setState(() {
            selectedIndex = s;
          });
        },
        selectedItemColor: Colors.black,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            label: "Favourite",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    ));
  }
}
