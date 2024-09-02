import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:post_wizard/Utilities/routes.dart';
import 'package:dio/dio.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false; // To show loading indicator

  // Function to make API call
  Future<bool> loginUser(String username, String password) async {
    try {
      var response = await Dio().post(
        'http://10.0.2.2:3000/api/v1/user/login', // Replace with your API endpoint
        data: {
          'username': username,
          'password': password,
        },
      );
      // Assuming the response returns a JSON object with a success field
      if (response.statusCode == 200 && response.data['success'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // Handle error
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
              ),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText('Welcome To PostWizard!',
                      textStyle: const TextStyle(
                        color: Colors.red,
                        fontSize: 30,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Times New Roman',
                        fontWeight: FontWeight.w500,
                      ),
                      speed: const Duration(
                        milliseconds: 450,
                      )),
                ],
                onTap: () {
                  debugPrint("Welcome back!");
                },
                isRepeatingAnimation: true,
                totalRepeatCount: 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 32,
                ),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        hintText: 'example@xyz.com',
                      ),
                      controller: usernameController,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.lock),
                        hintText: 'password',
                      ),
                      controller: passwordController,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, MyRoutes.forgotPassword);
                      },
                      child: const Text(
                        'Forgot Password?',
                      ),
                    ),
                    isLoading // Show loading indicator if API call is in progress
                        ? const CircularProgressIndicator()
                        : TextButton.icon(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        // Perform login logic
                        bool isAuthenticated = await loginUser(
                          usernameController.text,
                          passwordController.text,
                        );

                        setState(() {
                          isLoading = false;
                        });

                        if (isAuthenticated) {
                          // Navigate to Home Screen
                          Navigator.pushNamed(context, MyRoutes.homeScreen);
                        } else {
                          // Show error message
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Login failed. Please try again.'),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.login),
                      label: Container(
                        alignment: Alignment.center,
                        width: 150,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              MyRoutes.signUp,
                            );
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
