import 'package:flutter/material.dart';
import 'package:store_app/Views/Categories.dart';
import 'package:store_app/Views/chatPage.dart';
import 'package:store_app/Views/menuPage.dart';
import 'Favorite.dart';
import 'Home.dart';
import 'checkOut.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentIndex = 0;
  change_item(int value) {
    print(value);
    setState(() {
      currentIndex = value;
    });
  }

  List pages = [
    Home(),
    Categories(),
    Checkout(),
    FavoritePage(),
    ChatPage(),
    MenuPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(currentIndex),
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Categories",
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: "My Products",
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorite",
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.wechat),
            label: "Chat",
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: "Menu",
          ),
        ],
        elevation: 20,
        currentIndex: currentIndex,
        onTap: change_item,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
