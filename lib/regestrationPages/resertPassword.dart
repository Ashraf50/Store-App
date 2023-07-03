import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:store_app/regestrationPages/Authcubit/auth_cubit.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ResetPasswordLoading) {
          showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: SpinKitFadingCircle(
                  color: Color(0xffe5642a),
                  size: 160.0,
                ),
              );
            },
          );
        } else if (state is ResetPasswordSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SignIn(),
            ),
          );
          showSnackBar(context, "Check the email");
        } else if (state is ResetPasswordFailure) {
          showSnackBar(context, state.massageError);
        }
      },
      child: SafeArea(
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
                          BlocProvider.of<AuthCubit>(context)
                              .ResetPassword(
                            email: email_controller.text,
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
      ),
    );
  }
}
