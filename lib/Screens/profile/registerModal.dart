import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_app/components/customTextFeild.dart';

class RegisterModal extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final Color customColor = Color(0xFF0B1520);

  RegisterModal({super.key});

  Future<void> _handleRegister(BuildContext context) async {
    if (passwordController.text == confirmPasswordController.text) {
      try {
        final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        print('Registration Successful: ${userCredential.user?.email}');
        // Navigate to another screen after successful registration
      } catch (error) {
        print('Registration Failed: $error');
      }
    } else {
      print("Passwords do not match.");
    }
  }

  @override
Widget build(BuildContext context) {
  return SafeArea(
    child: Scaffold(
      backgroundColor: customColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 22.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: customColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Header
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'inter',
                      ),
                    ),
                  ),
                  CustomTextField(
                    title: 'Email',
                    hint: 'youremail@email.com',
                    controller: emailController,
                    margin: EdgeInsets.symmetric(vertical: 1),
                    obsecureText: false,
                    padding: EdgeInsets.all(10),
                  ),
                  CustomTextField(
                    title: 'Full Name',
                    hint: 'Your Full Name',
                    margin: EdgeInsets.symmetric(vertical: 1),
                    controller: nameController,
                    obsecureText: false,
                    padding: EdgeInsets.all(10),
                  ),
                  CustomTextField(
                    title: 'Password',
                    hint: 'Enter your Password',
                    obsecureText: true,
                    margin: EdgeInsets.symmetric(vertical: 1),
                    controller: passwordController,
                    padding: EdgeInsets.all(10),
                  ),
                  CustomTextField(
                    title: 'Retype Password',
                    hint: 'Retype the same password',
                    obsecureText: true,
                    margin: EdgeInsets.symmetric(vertical: 1),
                    controller: confirmPasswordController,
                    padding: EdgeInsets.all(10),
                  ),
                  // Register Button
                  Container(
                    margin: EdgeInsets.only(top: 16, bottom: 6),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        _handleRegister(context); // Call Firebase register
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: customColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'inter',
                        ),
                      ),
                    ),
                  ),
                  // Google Sign-In Button with only the icon
                  Container(
                    margin: EdgeInsets.only(top: 16, bottom: 6),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add your Google sign-in handling logic here
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      child: SvgPicture.asset(
                        'assets/images/gLogo.svg', // Use the SVG logo
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Custom Back Button
          Positioned(
            top: 10,
            left: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop(); // Go back to the previous screen
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.arrow_back,
                  color: customColor,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}