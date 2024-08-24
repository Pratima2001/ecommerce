import 'package:flutter/material.dart';
import 'home/favouriteProducts.dart';
import 'home/homePage.dart';
import 'home/myOrders.dart';
import 'products/subpage.dart';
import 'purchase/cartPage.dart';

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
    const FavouriteProducts(),
    CartPage(
      showBackbutton: false,
    ),
    const MyOrders()
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
          BottomNavigationBarItem(
              icon: Icon(Icons.production_quantity_limits), label: "My orders"),
        ],
      ),
    ));
  }
}
