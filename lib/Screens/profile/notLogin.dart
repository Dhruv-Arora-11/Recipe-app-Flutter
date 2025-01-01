import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';  // Import this for SVG support
import 'package:recipe_app/Screens/profile/login_model.dart';
import 'package:recipe_app/components/customTextFeild.dart';

class RegisterModal extends StatelessWidget {
  TextEditingController dhruv = TextEditingController();
  final Color customColor = Color(0xFF0B1520);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 1,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: customColor,
      ),
      child: SingleChildScrollView(
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
              controller: dhruv,
              margin: EdgeInsets.symmetric(vertical: 1),
              obsecureText: true,
              padding: EdgeInsets.all(10),
            ),
            CustomTextField(
              title: 'Full Name',
              hint: 'Your Full Name',
              margin: EdgeInsets.symmetric(vertical: 1),
              controller: dhruv,
              obsecureText: true,
              padding: EdgeInsets.all(10),
            ),
            CustomTextField(
              title: 'Password',
              hint: '**********',
              obsecureText: true,
              margin: EdgeInsets.symmetric(vertical: 1),
              controller: dhruv,
              padding: EdgeInsets.all(10),
            ),
            CustomTextField(
              title: 'Retype Password',
              hint: '**********',
              obsecureText: true,
              margin: EdgeInsets.symmetric(vertical: 1),
              controller: dhruv,
              padding: EdgeInsets.all(10),
            ),
            // Register Button
            Container(
              margin: EdgeInsets.only(top: 16, bottom: 6),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: customColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'inter',
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.white,
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
                  'assets/images/gLogo.svg',  // Use the SVG logo
                  height: 24,
                  width: 24,
                ),
              ),
            ),
            // Login TextButton
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  isScrollControlled: true,
                  builder: (context) {
                    return LoginModal();
                  },
                );
              },
              child: RichText(
                text: TextSpan(
                  text: 'Have an account? ',
                  style: TextStyle(color: Colors.grey),
                  children: [
                    TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'inter',
                      ),
                      text: 'Log in',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
