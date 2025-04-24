import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Screens/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'GetStartedPage.dart';
import 'loadingScreen.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  Future<bool> hasLoggedInBefore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('hasLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: hasLoggedInBefore(),
      builder: (context, loginSnapshot) {
        if (loginSnapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
              strokeWidth: 6.0,
            ),
          );
        }

        return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                  strokeWidth: 6.0,
                ),
              );
            } else if (snapshot.hasData) {
              // User is logged in via Firebase
              return const LoadingScreen(); // You may want to check session or loading
            } else {
              // User not logged in via Firebase
              if (loginSnapshot.data == true) {
                return const LoadingScreen(); // Skips intro if already been here
              } else {
                return const GetStartedPage();
              }
            }
          },
        );
      },
    );
  }
}
