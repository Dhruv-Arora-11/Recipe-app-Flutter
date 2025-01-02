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
  late Future<void> _loadResources;

  static bool loaded = false;

  @override
  void initState() {
    super.initState();
    _loadResources = _startBackgroundLoading();
  }

  Future<void> _startBackgroundLoading() async {
    ReceivePort receivePort = ReceivePort();

    // Start an isolate to load resources.
    await Isolate.spawn(_loadFirstPage, receivePort.sendPort);

    // Wait for the isolate to signal readiness.
    await receivePort.first;
  }

  static void _loadFirstPage(SendPort sendPort) async {
    // Simulate loading resources.
    // await Future.delayed(const Duration(seconds: 4));
    while(!loaded){
      continue;
    }
    sendPort.send(true); // Notify that loading is complete.
  }

  void _navigateToFirstPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const FirstPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadResources,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // After loading completes, navigate to the FirstPage.
          _navigateToFirstPage();
        }

        // Show the Rive loading screen until the resources are loaded.
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
      },
    );
  }
}
