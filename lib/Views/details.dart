import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/Categories/MenClothingCategory.dart';
import 'package:store_app/Categories/WomanClothingCategory.dart';
import 'package:store_app/Categories/electronicsCategories.dart';
import 'package:store_app/Categories/jeweleryCategory.dart';
import 'package:store_app/Models/ProductModel.dart';
import '../constant/colors.dart';
import '../provider.dart/cart.dart';
import 'checkOut.dart';

// ignore: must_be_immutable
class Details extends StatefulWidget {
  ProductModel product;
  Details({
    required this.product,
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool showMore = true;
  @override
  Widget build(BuildContext context) {
    final Instance_of_cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: AppBarColor,
        title: Text(
          "Details",
          style: TextStyle(fontSize: 20, color: Colors.black),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      alignment: Alignment.bottomCenter,
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50)),
                        color: Colors.grey[300],
                      ),
                    ),
                    Positioned(
                      top: 140,
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25)),
                        child: Image.network(
                          widget.product.image,
                          height: 200,
                          width: 200,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 110,
            ),
            Text(
              "\$${widget.product.price.toString()}",
              style: TextStyle(fontSize: 22),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Rating: ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${widget.product.ratingModel.rate.toString()}",
                      style: TextStyle(fontSize: 20),
                    ),
                    Icon(
                      Icons.star,
                      size: 25,
                      color: Color.fromARGB(255, 255, 191, 0),
                    ),
                  ],
                ),
                TextButton.icon(
                  onPressed: () {
                    if (widget.product.Category == "men's clothing") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MenCategories(),
                        ),
                      );
                    } else if (widget.product.Category == "women's clothing") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WomanCategories(),
                        ),
                      );
                    } else if (widget.product.Category == "jewelery") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => jeweleryCategories(),
                        ),
                      );
                    } else if (widget.product.Category == "electronics") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ElectronicsCategories(),
                        ),
                      );
                    }
                  },
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.grey[700],
                  ),
                  label: Text(
                    widget.product.Category,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                "Details:",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 13,
            ),
            Text(
              widget.product.description,
              style: TextStyle(
                fontSize: 23,
                overflow: TextOverflow.fade,
              ),
              maxLines: showMore ? 3 : null,
            ),
            TextButton(
              onPressed: () {
                setState(
                  () {
                    if (showMore == true) {
                      showMore = false;
                    } else {
                      showMore = true;
                    }
                  },
                );
              },
              child: Text(
                showMore ? "Show more" : "show less",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
