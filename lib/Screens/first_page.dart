import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {

  Color customColor = Color(0xFF11151E);
  FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColor,
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Text(
                  'Hello,',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontFamily: 'Roboto', 
                  ),
                                ),
                ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  'Kristin 👋',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              ],
            )
              ],
            )
          ],
        ),
      ),
    );
  }
}