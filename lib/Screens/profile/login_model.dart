import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_app/Screens/loadingScreen.dart';
import 'package:recipe_app/Screens/profile/notLoginUI.dart';
import 'package:recipe_app/animations/leftTransition.dart';
import 'package:recipe_app/components/customTextFeild.dart';

class LoginModal extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Color customColor = Color(0xFF0B1520);
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  LoginModal({super.key});

  Future<void> _handleGoogleSignIn(BuildContext context) async {
  try {
    final GoogleSignInAccount? account = await _googleSignIn.signIn();
    if (account != null) {
      final GoogleSignInAuthentication googleAuth = await account.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      print('Google Sign-In Successful: ${account.email}');
      
      // ✅ Navigate after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoadingScreen()), // Replace with your screen
      );
    }
  } catch (error) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoadingScreen()), // Replace with your screen
      );
    print("the error is there");
    print('Google Sign-In Failed: $error');
  }
}


  Future<void> _handleEmailLogin(BuildContext context) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      print('Login Successful: ${userCredential.user?.email}');
      // Navigate to another screen after successful login
    } catch (error) {
      print('Login Failed: $error');
    }
  }

@override
Widget build(BuildContext context) {
  return SafeArea(
    child: Scaffold(
      body: Stack(
        children: [
          Container(
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
                    hint: 'Enter Password',
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
                        _handleEmailLogin(context); // Call Firebase login
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
                  // Register Text Button
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Notloginui()));
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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
