import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/Views/checkOut.dart';
import 'package:store_app/provider.dart/cart.dart';
import 'package:store_app/widget/customCard.dart';
import '../constant/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final Instance_of_cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppBarColor,
        title: Text(
          "Trend",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        actions: [
          Stack(
            children: [
              Container(
                child: Text(
                  "${Instance_of_cart.selectedProduct.length}",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Checkout(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.add_shopping_cart,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 9),
            child: Row(
              children: [
                Text(
                  "\$ ${Instance_of_cart.price}",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: CustomCard(),
      ),
    );
  }
}
