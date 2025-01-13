import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'GetStartedPage.dart';
import 'loadingScreen.dart';

class AuthCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // If the stream has data, it means a user is logged in
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while the stream is checking
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
              strokeWidth: 6.0,
            ),
          );
        } else if (snapshot.hasData) {
          // Redirect to LoadingScreen if user is logged in
          return const LoadingScreen();
        } else {
          // Redirect to GetStartedPage if no user is logged in
          return const GetStartedPage();
        }
      },
    );
  }
}