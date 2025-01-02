import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';
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
    _startBackgroundLoading();
  }

  void _startBackgroundLoading() {
    final receivePort = ReceivePort();
    Isolate.spawn(_backgroundLoading, receivePort.sendPort);

    // Listen for the completion signal from the isolate
    receivePort.listen((message) {
      if (message == true) {
        _navigateToFirstPage();
      }
    });
  }

  static void _backgroundLoading(SendPort sendPort) async {
    // Simulate resource loading
    await Future.delayed(const Duration(seconds: 5));
    sendPort.send(true); // Notify completion
  }

  void _navigateToFirstPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const FirstPage()),
    );
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
