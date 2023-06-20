import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomCardOfCategory extends StatelessWidget {
  final String Title;
  final String Image;
  void Function()? onTap;
  CustomCardOfCategory({
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
