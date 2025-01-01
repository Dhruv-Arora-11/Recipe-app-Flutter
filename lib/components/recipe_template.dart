import 'package:flutter/material.dart';

class RecipeTemplate extends StatelessWidget {
  final String imageUrl;
  final String dishName;

  RecipeTemplate({super.key, required this.imageUrl, required this.dishName});

  final Color tempColor = Color(0xFF171D2B);

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
        child: Row(
          children: [
            // Image Section
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 150,
                height: 150,
                margin: const EdgeInsets.all(10),
                color: Colors.white,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Dish Name Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  dishName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
