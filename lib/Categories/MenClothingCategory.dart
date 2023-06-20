import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:store_app/Models/ProductModel.dart';
import 'package:store_app/constant/colors.dart';
import '../Views/details.dart';
import '../provider.dart/cart.dart';
import '../services/CategoriesService.dart';

// ignore: must_be_immutable
class MenCategories extends StatefulWidget {
  @override
  State<MenCategories> createState() => _MenCategoriesState();
}

class _MenCategoriesState extends State<MenCategories> {
  @override
  Widget build(BuildContext context) {
    final Instance_of_cart = Provider.of<Cart>(context);
    final Instance_of_Favorite = Provider.of<Favorite>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          centerTitle: true,
          backgroundColor: AppBarColor,
          title: Text(
            "men's clothing Category",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
        body: FutureBuilder<List<ProductModel>>(
          future: CategoriesService()
              .getCategoriesProduct(category_name: "men's clothing"),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<ProductModel> products = snapshot.data!;
              return GridView.builder(
                clipBehavior: Clip.none,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 7,
                  mainAxisExtent: 220,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(
                            product: products[index],
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Stack(
                        children: [
                          Card(
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(9),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.network(
                                    products[index].image,
                                    width: 100,
                                    height: 80,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        products[index].title.substring(0, 5),
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 155, 155, 155),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "\$${products[index].price.toDouble()}",
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Instance_of_Favorite.add(
                                              products[index]);
                                        },
                                        icon: Icon(
                                      Instance_of_Favorite.IsSelected(
                                              products[index])
                                          ? Icons.favorite
                                          : FontAwesomeIcons.heart,
                                      size: 20,
                                      color: Instance_of_Favorite.IsSelected(
                                              products[index])
                                          ? Colors.red
                                          : Colors.black,
                                    ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 3,
                            right: 3,
                            child: IconButton(
                              onPressed: () {
                                Instance_of_cart.add(products[index]);
                              },
                              icon: Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: SpinKitFadingCircle(
                  color: Color.fromARGB(255, 170, 176, 172),
                  size: 160.0,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
