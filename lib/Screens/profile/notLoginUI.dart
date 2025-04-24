import 'package:flutter/material.dart';
import 'package:recipe_app/Screens/profile/login_model.dart';
import 'package:recipe_app/Screens/profile/registerModal.dart';
import 'package:recipe_app/animations/leftTransition.dart';

class Notloginui extends StatelessWidget {
  final Color customColor = const Color(0xFF0B1520);

  const Notloginui({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: customColor,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App Logo or Icon
                    Container(
                      margin: const EdgeInsets.only(bottom: 40),
                      child: Column(
                        children: [
                          Icon(
                            Icons.fastfood_rounded,
                            color: Colors.white,
                            size: 100,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Recipe Delight",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Subtitle
                    Text(
                      "Discover new recipes and save your favorites!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Buttons for Login and Register
                    Column(
                      children: [
                        // Login Button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, CustomPageRoute(page: LoginModal()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: customColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Register Button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, CustomPageRoute(page: RegisterModal()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            side: BorderSide(color: Colors.white, width: 2),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
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
        ),
    );
  }
}
