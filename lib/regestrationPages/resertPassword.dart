import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:store_app/widget/CustomButton.dart';
import '../constant/snackBar.dart';
import 'SignIn.dart';

class Reset_Password extends StatefulWidget {
  const Reset_Password({super.key});

  @override
  State<Reset_Password> createState() => _Reset_PasswordState();
}

class _Reset_PasswordState extends State<Reset_Password> {
  final email_controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Reset_pass() async {
    showDialog(
        context: context,
        builder: (context) {
          return SpinKitFadingCircle(
            color: Color.fromARGB(146, 12, 16, 49),
            size: 160.0,
          );
        });
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email_controller.text);
      showSnackBar(context, "check the email");
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "${e.code}");
      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    email_controller.dispose();
    super.dispose();
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
                Text(
                  "Enter your email to reset password.",
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value) {
                      return value != null && !EmailValidator.validate(value)
                          ? "Enter a valid email"
                          : null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: email_controller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: "Enter Your Email",
                      suffixIcon: Icon(
                        Icons.email,
                        color: Color(0xff12a14a),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                CustomButton(
                    buttonTitle: "Reset Password",
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        await Reset_pass();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignIn(),
                          ),
                        );
                      } else {
                        showSnackBar(context, "check the email address!");
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
