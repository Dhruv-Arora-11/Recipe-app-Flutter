import 'package:flutter/material.dart';

class RecipeTemplate extends StatelessWidget {
  RecipeTemplate({super.key});
  Color tempColor = Color(0xFF171D2B);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Container(
        height: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: tempColor,
        ),
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: 20, 
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10), 
                child: Container(
                  width: 150, 
                  height: 150, 
                  color: Colors.white,
                  //add the image here
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
