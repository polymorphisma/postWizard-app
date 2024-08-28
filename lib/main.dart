import 'package:flutter/material.dart';
import 'package:post_wizard/Screens/forgot_password.dart';
import 'package:post_wizard/Screens/home_screen.dart';
import 'package:post_wizard/Screens/login_screen.dart';
import 'package:post_wizard/Screens/signup.dart';
import 'package:post_wizard/Utilities/routes.dart';
import 'package:post_wizard/Screens/upload_screen.dart';

void main() => runApp(const AuthApp());

class AuthApp extends StatelessWidget {
  const AuthApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        MyRoutes.homeScreen: (context) => HomeScreen(),
        MyRoutes.loginScreen: (context) => LoginScreen(),
        MyRoutes.signUp: (context) => SignUp(),
        MyRoutes.forgotPassword: (context) => ForgotPassword(),
        MyRoutes.upload: (context) => UploadImagePage(),
      },
    );
  }
}
