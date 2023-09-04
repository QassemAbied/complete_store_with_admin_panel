import 'package:complete_store_with_admin_panel/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';
import '../provider/product_provider.dart';
import '../provider/wishlist_provider.dart';
import '../widget/text_widget.dart';
import 'cart/cart_screen.dart';
import 'category_screen/category_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final List<Map<String, dynamic>> screens = [
    {
      'pages': const HomeScreen(),
      'title': 'Home',
    },
    {
      'pages': const CategoryScreen(),
      'title': 'Category',
    },
    {
      'pages': const CartScreen(),
      'title': 'Cart',
    },
    {
      'pages': const SettingsScreen(),
      'title': 'Settings',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(text:screens[currentIndex]['title'],
          textSize: 25,
          maxLines: 1,
          isText: true,
          color: Colors.white,  ),
      ),
      body: screens[currentIndex]['pages'],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0.0,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon:
                  Icon(currentIndex == 0 ? IconlyBold.home : IconlyLight.home),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(currentIndex == 1
                  ? IconlyBold.category
                  : IconlyLight.category),
              label: 'Category'),
          BottomNavigationBarItem(
              icon: Icon(currentIndex == 2 ? IconlyBold.buy : IconlyLight.buy),
              label: 'Buy'),
          BottomNavigationBarItem(
              icon: Icon(
                  currentIndex == 3 ? IconlyBold.user2 : IconlyLight.user2),
              label: 'Settings'),
        ],
      ),
    );
  }
}
