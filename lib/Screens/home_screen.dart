import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:post_wizard/Utilities/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: const Text(
              'PostWizard',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Times',
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/welcome.png',
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 10,
                    width: 10,
                  ),
      
                  Image.asset(
                    'assets/images/welcomee.png',
                    fit: BoxFit.cover,
                    scale: 2.0,
                  ),
                ],
              ),
            ),
          ),
          // drawer: const Drawer(),
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushNamed(context, MyRoutes.upload);
              },
              label: const Text("Upload")
          ),
        ),
      ),
    );
  }
}
