import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show basename;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_app/Views/Categories.dart';
import 'package:store_app/Views/checkOut.dart';
import 'package:store_app/constant/colors.dart';
import 'package:store_app/regestrationPages/SignIn.dart';

import '../widget/CustomListTile.dart';
import 'Favorite.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  final userDetails = FirebaseAuth.instance.currentUser;
  File? imgPath;
  String? imgName;
  uploadImage(ImageSource cameraOrGallary) async {
    final pickedImg = await ImagePicker().pickImage(source: cameraOrGallary);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
          int random = Random().nextInt(9999999);
          imgName = "$random$imgName";
        });
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }
  }

  ChoosePhoto() async {
    await uploadImage(ImageSource.gallery);
    if (imgPath != null) {
      final storageRef = FirebaseStorage.instance.ref(imgName);
      await storageRef.putFile(imgPath!);
      String url = await storageRef.getDownloadURL();
      users.doc(userDetails!.uid).update(
        {
          "imgLink": url,
        },
      );
    }
  }

  TakePhoto() async {
    await uploadImage(ImageSource.camera);
    if (imgPath != null) {
      final storageRef = FirebaseStorage.instance.ref(imgName);
      await storageRef.putFile(imgPath!);
      String url = await storageRef.getDownloadURL();
      users.doc(userDetails!.uid).update(
        {
          "imgLink": url,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          // elevation: 0,
          centerTitle: true,
          backgroundColor: AppBarColor,
          title: const Text(
            "Profile",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        body: FutureBuilder<DocumentSnapshot>(
            future: users.doc(userDetails!.uid).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }
              if (snapshot.hasData && !snapshot.data!.exists) {
                return Text("Document does not exist");
              }
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                return SingleChildScrollView(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      clipBehavior: Clip.hardEdge,
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Stack(children: [
                                imgPath == null
                                    ? data["imgLink"] == null
                                        ? CircleAvatar(
                                            backgroundColor: Colors.grey[300],
                                            maxRadius: 60,
                                            backgroundImage: AssetImage(
                                              "assets/img/avatar.png",
                                            ))
                                        : CircleAvatar(
                                            maxRadius: 60,
                                            backgroundImage:
                                                NetworkImage(data["imgLink"]))
                                    : ClipOval(
                                        child: Image.file(imgPath!,
                                            height: 145,
                                            width: 145,
                                            fit: BoxFit.cover)),
                                Positioned(
                                    bottom: -5,
                                    right: -12,
                                    child: IconButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                        height: 150,
                                                        child: Column(
                                                            children: [
                                                              GestureDetector(
                                                                  onTap: () {
                                                                    ChoosePhoto();
                                                                  },
                                                                  child: Container(
                                                                      width: double
                                                                          .infinity,
                                                                      height:
                                                                          50,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              15)),
                                                                      child: Center(
                                                                          child: Text(
                                                                              "Choose Photo",
                                                                              style: TextStyle(fontSize: 20, color: Colors.blue))))),
                                                              GestureDetector(
                                                                  onTap: () {
                                                                    TakePhoto();
                                                                  },
                                                                  child: Container(
                                                                      width: double
                                                                          .infinity,
                                                                      height:
                                                                          50,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              15)),
                                                                      child: Center(
                                                                          child: Text(
                                                                              "Take Photo",
                                                                              style: TextStyle(fontSize: 20, color: Colors.blue))))),
                                                              GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Container(
                                                                      width: double
                                                                          .infinity,
                                                                      height:
                                                                          50,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              15)),
                                                                      child: Center(
                                                                          child: Text(
                                                                              "Cancel",
                                                                              style: TextStyle(fontSize: 20, color: Colors.blue)))))
                                                            ])));
                                              });
                                        },
                                        icon: Icon(
                                          Icons.add_a_photo,
                                          color: const Color.fromARGB(
                                              173, 0, 0, 0),
                                        )))
                              ]),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              "${data["username"]}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Text("${userDetails!.email}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.grey)),
                            const SizedBox(height: 10)
                          ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            "Content",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    CustomListTile(
                      Title: "favorite",
                      icon: Icon(Icons.favorite, color: Colors.grey),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FavoritePage(),
                          ),
                        );
                      },
                    ),
                    CustomListTile(
                      Title: "Cart",
                      icon: Icon(Icons.shopping_cart, color: Colors.grey),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Checkout(),
                          ),
                        );
                      },
                    ),
                    CustomListTile(
                      Title: "Categories",
                      icon: Icon(Icons.category, color: Colors.grey),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Categories(),
                          ),
                        );
                      },
                    ),
                    CustomListTile(
                      Title: "Settings",
                      icon: Icon(Icons.settings, color: Colors.grey),
                      onTap: () {},
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, bottom: 10, top: 15),
                      child: Row(
                        children: [
                          Text(
                            "preferences",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    CustomListTile(
                      Title: "Sign out",
                      icon: Icon(
                        Icons.logout,
                        color: Colors.grey,
                      ),
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignIn(),
                          ),
                        );
                      },
                    ),
                  ],
                ));
              } else {
                return Center(
                    child: SpinKitFadingCircle(
                        color: Color.fromARGB(255, 194, 191, 189),
                        size: 160.0));
              }
            }));
  }
}
