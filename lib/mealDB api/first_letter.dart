import 'dart:convert';

import 'package:http/http.dart' as http;


class API_fetch{
  String letter;
  List meals = [];
  List<String> Meals = [];
  API_fetch({required this.letter});

  Future<List<String>> fetchData() async {
    try {
      String finalUrl = "https://www.themealdb.com/api/json/v1/1/search.php?f=$letter";
      final response = await http.get(Uri.parse(finalUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        meals = data['meals'];
        for(int i = 0 ; i<meals.length ; i++){
            Meals.add(meals[i]["strMeal"]);
          }
        return Meals;
      } else {
        print('Error: ${response.statusCode}');
        return Meals;
      }
    } catch (e) {
      print('Error: $e');
      return Meals;
    }
  }
}