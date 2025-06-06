import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:recipe_app/animations/leftTransition.dart';
import 'package:recipe_app/animations/transition_to_anyDirection.dart';
import 'package:rive/rive.dart';
import 'first_page.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _backgroundLoading();
  }

  void _navigateToFirstPage() {
    Navigator.pushReplacement(
      context,
      VerticalPageRoute(page: FirstPage(),direction: SlideDirection.fromBottom)
    );
  }
    void _backgroundLoading() async {
    Timer(const Duration(seconds: 2), _navigateToFirstPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: RiveAnimation.asset(
          'assets/rive/latest_loading.riv',
          fit: BoxFit.cover, // Ensures the animation covers the screen.
        ),
      ),
    );
  }
}
