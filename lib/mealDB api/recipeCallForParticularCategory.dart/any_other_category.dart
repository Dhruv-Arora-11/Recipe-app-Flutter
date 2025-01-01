import 'dart:convert';
import 'package:http/http.dart' as http;

class AnyOtherCategory {

  String selected_category;
  List<List<String>> dishList = [];
  
  AnyOtherCategory({
    required this.selected_category
  });

  Future<List<List<String>>> fetchData() async {
    List raw_Dish_list = [];
    List<String> Dishes = [];
    List<String> img_url = [];
    try {
      String final_url = "https://www.themealdb.com/api/json/v1/1/filter.php?c=$selected_category" ;
      final response = await http.get(Uri.parse(final_url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        raw_Dish_list = data["meals"];
        for(int i = 0 ; i < raw_Dish_list.length ; i++){
            Dishes.add(raw_Dish_list[i]["strMeal"]);
            img_url.add(raw_Dish_list[i]["strMealThumb"]);
          }
        dishList.add(Dishes);
        dishList.add(img_url);
        print(dishList);
        return dishList;
      } else {
        print('Error: ${response.statusCode}');
        return dishList;
      }
    } catch (e) {
      print('Error: $e');
      return dishList;
    }
}
}