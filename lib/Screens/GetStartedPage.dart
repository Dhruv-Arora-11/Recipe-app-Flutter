import 'package:flutter/material.dart';
import 'package:recipe_app/Screens/first_page.dart';
import 'package:recipe_app/Screens/loadingScreen.dart';
import 'package:recipe_app/Screens/profile/login_model.dart';
import 'package:recipe_app/animations/leftTransition.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final screenSize = MediaQuery.of(context).size;
    final isLargeScreen = screenSize.width > 600;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/food 2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(screenSize.width * 0.05), // Responsive padding
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Find the perfect\nrecipes everyday",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isLargeScreen ? 40 : 30, // Larger text for larger screens
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.02), // Responsive spacing
                  Text(
                    "More than 20 thousand recipes of\nhealthy and healthy food",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isLargeScreen ? 24 : 20, // Adjusted for screen size
                      color: const Color.fromARGB(255, 242, 231, 231),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.05), // Responsive spacing
                  SizedBox(
                    width: isLargeScreen ? screenSize.width * 0.4 : screenSize.width * 0.7, // Responsive button width
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.08,
                          vertical: screenSize.height * 0.02,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          CustomPageRoute(page: LoginModal())
                        );
                      },
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: isLargeScreen ? 22 : 18, // Responsive font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
