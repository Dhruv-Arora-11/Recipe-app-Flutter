import 'dart:convert';
import 'package:http/http.dart' as http;

class AnyOtherCategory {

  String selected_category;
  List<List<String>> dishList = [];
  
  AnyOtherCategory({
    required this.selected_category
  });

  Future<List<List<String>>> fetchData() async {
  List<String> Dishes = [];
  List<String> imgUrl = [];
  try {
    print("I got in try block");
    String finalUrl = "https://www.themealdb.com/api/json/v1/1/filter.php?c=$selected_category";
    final response = await http.get(Uri.parse(finalUrl));
    print("this is teh respoonse");
    print(response);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("I am printing the data");
      print(data);
      print("raw dish list is about to fetch ");
      final rawDishList = data["meals"];
      print("I have fetched the raw dish list and this is below");
      print(rawDishList);
      if (rawDishList == null) {
        print("No dishes found for category: $selected_category");
        return [];
      }
      for (var dish in rawDishList) {
        Dishes.add(dish["strMeal"]);
        imgUrl.add(dish["strMealThumb"]);
      }
      return [Dishes, imgUrl];
    } else {
      print('Error: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('Error: $e');
    return [];
  }
}


}