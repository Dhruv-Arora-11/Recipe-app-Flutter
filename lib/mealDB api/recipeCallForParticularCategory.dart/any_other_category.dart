import 'dart:convert';
import 'package:http/http.dart' as http;

class AnyOtherCategory {

  String selected_category;
  List<List<String>> dishList = [];
  
  AnyOtherCategory({
    required this.selected_category
  });

  Future<List<List<String>>> fetchData() async {
    List rawDishList = [];
    List<String> Dishes = [];
    List<String> imgUrl = [];
    try {
      String finalUrl = "https://www.themealdb.com/api/json/v1/1/filter.php?c=$selected_category" ;
      final response = await http.get(Uri.parse(finalUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        rawDishList = data["meals"];
        for(int i = 0 ; i < rawDishList.length ; i++){
            Dishes.add(rawDishList[i]["strMeal"]);
            imgUrl.add(rawDishList[i]["strMealThumb"]);
          }
        dishList.add(Dishes);
        dishList.add(imgUrl);
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