import 'package:flutter/material.dart';
import 'package:post_wizard/Utilities/routes.dart';
import 'package:dio/dio.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false; // To show loading indicator

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/signup.png',
                fit: BoxFit.cover,
                height: 300,
                width: 350,
              ),
              const SizedBox(
                height: 20,
                width: 20,
              ),
              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Courier',
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
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
                        icon: Icon(Icons.person),
                        labelText: 'First Name',
                      ),
                      controller: firstNameController,
                    ),
                    const SizedBox(
                      height: 10,
                      width: 10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person_outline),
                        labelText: 'Last Name',
                      ),
                      controller: lastNameController,
                    ),
                    const SizedBox(
                      height: 10,
                      width: 10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        hintText: 'Email',
                      ),
                      controller: emailController,
                    ),
                    const SizedBox(
                      height: 10,
                      width: 10,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.lock),
                        labelText: 'Password',
                      ),
                      controller: passwordController,
                    ),
                    const SizedBox(
                      height: 10,
                      width: 10,
                    ),
                    isLoading
                        ? const CircularProgressIndicator()
                        : TextButton.icon(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        // Perform sign-up logic
                        var result = await signUpUser(
                          firstNameController.text,
                          lastNameController.text,
                          emailController.text,
                          passwordController.text,
                        );

                        setState(() {
                          isLoading = false;
                        });
                        bool isSignedUp = result['success'];
                        String message = result['message'];


                        if (isSignedUp) {
                          // Navigate to Home Screen or Show Success Message
                          Navigator.pushNamed(context, MyRoutes.loginScreen);
                        } else {
                          // Show error message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.create),
                      label: Container(
                        alignment: Alignment.center,
                        width: 150,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Text(
                          'Sign Up',
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
                        const Text('Already have an account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, MyRoutes.loginScreen);
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'By signing up you agree to our terms, conditions and privacy Policy.',
                      style: TextStyle(
                        fontSize: 13,
                      ),
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
  void showMessage(String message, {String messageType = "success"}){
    Color color = Colors.white;

    if (messageType != 'success'){
      color = Colors.red;
    }

    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.black
        ),
      ),

      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<Map<String, dynamic>> signUpUser(String firstName, String lastName, String email, String password) async {
    try {
      var response = await Dio().post(
        'http://10.0.2.2:3000/api/v1/user/register',
        data: {
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 201 && response.data['success'] == true) {
        return response.data;
      } else {
        return response.data;
      }
    } catch (e) {
      print(e);
      return {
        'success': false,
        'message': 'An error occurred. Please try again later.',
      };
    }
  }

}
