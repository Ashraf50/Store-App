import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:store_app/provider.dart/cart.dart';
import 'package:store_app/provider.dart/googleSignIn.dart';
import 'package:store_app/regestrationPages/Authcubit/auth_cubit.dart';
import 'package:store_app/regestrationPages/SignIn.dart';
import 'Views/bottomNavigationBar.dart';
import 'constant/snackBar.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return Cart();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return Favorite();
          },
        ),
        ChangeNotifierProvider(create: (context) {
          return GoogleSignInProvider();
        }),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
      ],
      child: MaterialApp(
        routes: {
          "bottomBar": (context) => BottomBar(),
        },
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: Color.fromARGB(255, 181, 180, 180),
              ));
            } else if (snapshot.hasError) {
              return showSnackBar(context, "Something went wrong");
            } else if (snapshot.hasData) {
              return BottomBar();
            } else {
              return SignIn();
            }
          },
        ),
      ),
    );
  }
}
