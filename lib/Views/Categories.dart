import 'package:flutter/material.dart';
import 'package:store_app/Categories/MenClothingCategory.dart';
import 'package:store_app/Categories/WomanClothingCategory.dart';
import 'package:store_app/Categories/jeweleryCategory.dart';
import 'package:store_app/constant/colors.dart';
import '../Categories/electronicsCategories.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          centerTitle: true,
          backgroundColor: AppBarColor,
          title: Text(
            "Categories",
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomCardOfCategory(
                Title: "Electronics",
                Image: "assets/img/electronic.jpg",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ElectronicsCategories(),
                    ),
                  );
                },
              ),
              CustomCardOfCategory(
                Title: "jewelery",
                Image: "assets/img/jewelery.jpg",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => jeweleryCategories(),
                    ),
                  );
                },
              ),
              CustomCardOfCategory(
                Title: "men's clothing",
                Image: "assets/img/menclothing.jpg",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MenCategories(),
                    ),
                  );
                },
              ),
              CustomCardOfCategory(
                Title: "women's clothing",
                Image: "assets/img/womenclothing.jpg",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WomanCategories(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class CustomCardOfCategory extends StatelessWidget {
  final String Title;
  final String Image;
  final void Function()? onTap;
  const CustomCardOfCategory({
    required this.Title,
    required this.Image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(top: 15, bottom: 15, left: 8, right: 8),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(
                Image,
              ),
            ),
            Row(
              children: [
                Text(
                  Title,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 20,
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

