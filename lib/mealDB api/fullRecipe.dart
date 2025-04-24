import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RecipeApi {
  
  late String recipeName;
  static List<String> ingredients = [];
  int i = 0;

  Future<Map<String, dynamic>> fetchRecipe(String recipeName, BuildContext context) async {
    final url = 'https://www.themealdb.com/api/json/v1/1/search.php?s=$recipeName';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Validate data structure
      if (data["meals"] != null && data["meals"].isNotEmpty) {
        final Map<String, dynamic> meals = data["meals"][0];

        // Clear and populate ingredients list
        ingredients.clear();
        for (int i = 1; i <= 20; i++) {
          final ingredient = meals["strIngredient$i"];
          // print('Ingredient $i: $ingredient'); // Debugging
          if (ingredient != null && ingredient.isNotEmpty) {
            ingredients.add(ingredient.toString());
          }
        }
        return meals;
      } else {
        throw Exception("No meals found for the given recipe name.");
      }
    } else {
      throw Exception('Failed to load recipe. Status code: ${response.statusCode}');
    }
  }

}
