import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/Views/details.dart';
import '../constant/colors.dart';
import '../provider.dart/cart.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    final Instance_of_cart = Provider.of<Cart>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            centerTitle: true,
            backgroundColor: AppBarColor,
            title: Text(
              "Checkout",
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
                      style: TextStyle(fontSize: 17, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ]),
        body: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            children: [
              Expanded(
                
                child: ListView.builder(
                  // padding: EdgeInsets.all(5),
                  itemCount: Instance_of_cart.selectedProduct.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Details(
                                  product:
                                      Instance_of_cart.selectedProduct[index]),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 4,
                          child: ListTile(
                            title: Text(
                                "${Instance_of_cart.selectedProduct[index].title}"),
                            subtitle: Text(
                                "\$${Instance_of_cart.selectedProduct[index].price} : ${Instance_of_cart.selectedProduct[index].Category}"),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "${Instance_of_cart.selectedProduct[index].image}"),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                Instance_of_cart.delete(
                                    Instance_of_cart.selectedProduct[index]);
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5,
                  child: Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Column(
                            children: [
                              Text(
                                "Total Price",
                                style: TextStyle(
                                    fontSize: 22, color: Colors.black),
                              ),
                              Text(
                                "${Instance_of_cart.price}\$",
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Card(
                              elevation: 4,
                              child: GestureDetector(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(7),
                                      height: 40,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: Text(
                                          "Pay Now",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Icon(Icons.arrow_forward_ios),
                                  ],
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
