import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/Views/details.dart';
import '../constant/colors.dart';
import '../provider.dart/cart.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Instance_of_FavoriteCart = Provider.of<Favorite>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: AppBarColor,
        title: Text(
          "Favorite",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 30, left: 30),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: Instance_of_FavoriteCart.selectedProduct.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Details(
                                product: Instance_of_FavoriteCart
                                    .selectedProduct[index]),
                          ),
                        );
                      },
                      child: Card(
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(9),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.network(
                                    Instance_of_FavoriteCart
                                        .selectedProduct[index].image,
                                    width: 100,
                                    height: 80,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    Instance_of_FavoriteCart
                                        .selectedProduct[index].title
                                        .substring(0, 5),
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Instance_of_FavoriteCart.delete(
                                          Instance_of_FavoriteCart
                                              .selectedProduct[index]);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Text(
                                    "\$${Instance_of_FavoriteCart.selectedProduct[index].price.toDouble()}",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
