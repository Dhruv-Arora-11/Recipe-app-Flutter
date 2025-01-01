import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_svg/flutter_svg.dart';  // Import this
import 'package:recipe_app/components/customTextFeild.dart';
import 'package:recipe_app/Screens/profile/notLogin.dart';

class LoginModal extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Color customColor = Color(0xFF0B1520);
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        // Handle successful sign-in (e.g., navigate to another screen)
        print('Google Sign-In Successful: ${account.email}');
      }
    } catch (error) {
      print('Google Sign-In Failed: $error');
    }
  }

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
                'Welcome Back',
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
              margin: EdgeInsets.symmetric(vertical: 4),
              obsecureText: false,
              padding: EdgeInsets.all(12),
            ),
            CustomTextField(
              title: 'Password',
              hint: '**********',
              controller: passwordController,
              obsecureText: true,
              margin: EdgeInsets.symmetric(vertical: 4),
              padding: EdgeInsets.all(12),
            ),
            // Login Button
            Container(
              margin: EdgeInsets.only(top: 16, bottom: 6),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.white,
                ),
                child: Text(
                  'Log In',
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
                onPressed: () => _handleGoogleSignIn(context),
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
            // Register TextButton
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
                    // Replace with your RegisterModal
                    return RegisterModal();
                  },
                );
              },
              child: RichText(
                text: TextSpan(
                  text: 'Don’t have an account? ',
                  style: TextStyle(color: Colors.grey),
                  children: [
                    TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'inter',
                      ),
                      text: 'Sign Up',
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
