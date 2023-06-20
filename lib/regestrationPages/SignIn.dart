import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:store_app/regestrationPages/resertPassword.dart';
import 'package:store_app/regestrationPages/signUp.dart';
import '../constant/snackBar.dart';
import '../provider.dart/googleSignIn.dart';
import '../widget/CustomButton.dart';
import '../widget/customTextField.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  bool visibility = true;
  Sign() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: SpinKitFadingCircle(
              color: Color(0xffe5642a),
              size: 160.0,
            ),
          );
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email_controller.text,
        password: password_controller.text,
      );
      showSnackBar(context, "successful");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, "incorrect Email");
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, "incorrect password");
      } else {
        showSnackBar(context, e.code);
      }
    }
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    email_controller.dispose();
    password_controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final google_sign_in = Provider.of<GoogleSignInProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
                      "Login",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              CustomTExtField(
                autovalidateMode: AutovalidateMode.disabled,
                controller: email_controller,
                validator: (p0) {
                  return null;
                },
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
                autovalidateMode: AutovalidateMode.disabled,
                controller: password_controller,
                validator: (p0) {
                  return null;
                },
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
              Padding(
                padding: const EdgeInsets.only(right: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Reset_Password(),
                          ),
                        );
                      },
                      child: Text(
                        "Forget Password?",
                        style: TextStyle(
                          color: Color(0xff12a14a),
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomButton(
                buttonTitle: "Login",
                onTap: () async {
                  await Sign();
                  Navigator.pushReplacementNamed(
                    context,
                    "bottomBar",
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "don't have an account? ",
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
                          builder: (context) => SignUp(),
                        ),
                      );
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff12a14a),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 330,
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.6,
                        color: Colors.purple[900],
                      ),
                    ),
                    Text(
                      "Sign in with",
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: "Schyler",
                        color: Colors.green,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.6,
                        color: Colors.purple[900],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      "assets/img/facebook-app-symbol.png",
                      width: 30,
                      color: Color(0xffe5642a),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await google_sign_in.googleLogin();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BottomAppBar(),
                          ));
                    },
                    child: Image.asset(
                      "assets/img/google.png",
                      width: 30,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
