import 'package:flutter/material.dart';

class Starred extends StatelessWidget {
  const Starred({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50,
        width: 50,
        child: Text("Starred page"),
      ),
    );
  }
}