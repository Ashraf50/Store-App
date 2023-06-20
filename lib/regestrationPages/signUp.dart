import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../constant/snackBar.dart';
import '../widget/CustomButton.dart';
import '../widget/customTextField.dart';
import 'SignIn.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignInState();
}

bool visibility = true;

class _SignInState extends State<SignUp> {
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  final userName_controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  register() async {
    showDialog(
        context: context,
        builder: (context) {
          return SpinKitFadingCircle(
            color: Color(0xffe5642a),
            size: 160.0,
          );
        });
    try {
      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email_controller.text,
        password: password_controller.text,
      );
      // send data to database
      CollectionReference users =
          FirebaseFirestore.instance.collection("Users");
      users
          .doc(user.user!.uid)
          .set(
            {
              'username': userName_controller.text,
              'email': email_controller.text,
              'password': password_controller.text,
            },
          )
          .then(
            (value) => print("User Added"),
          )
          .catchError((error) => print("Failed to add user: $error"));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, "The password provided is to weak");
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, "The account already exists");
      } else {
        showSnackBar(context, "Error");
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    password_controller.dispose();
    email_controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/img/logo.png",
                  width: 300,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
                CustomTExtField(
                  validator: (p0) {
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.disabled,
                  controller: userName_controller,
                  lableText: "Enter Username",
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.person,
                      color: Color(0xff12a14a),
                      size: 27,
                    ),
                  ),
                ),
                CustomTExtField(
                  validator: (value) {
                    return value != null && !EmailValidator.validate(value)
                        ? "Enter a valid email"
                        : null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: email_controller,
                  lableText: "Enter Your Email",
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.email_sharp,
                      color: Color(0xff12a14a),
                    ),
                  ),
                ),
                CustomTExtField(
                  validator: (value) {
                    return value!.length < 6
                        ? "Enter at least 6 character"
                        : null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: password_controller,
                  lableText: "Enter Your Password",
                  obscureText: visibility,
                  keyboardType: TextInputType.text,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        if (visibility == true) {
                          visibility = false;
                        } else {
                          visibility = true;
                        }
                      });
                    },
                    icon: visibility
                        ? Icon(
                            Icons.visibility,
                            color: Color(0xff12a14a),
                          )
                        : Icon(
                            Icons.visibility_off,
                            color: Color(0xff12a14a),
                          ),
                  ),
                ),
                CustomButton(
                  buttonTitle: "Register",
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      await register();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignIn(),
                        ),
                      );
                    } else {
                      showSnackBar(context, "check the email or password");
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "already have an account? ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignIn(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff12a14a),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
