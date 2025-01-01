import 'dart:convert';
import 'package:http/http.dart' as http;

class AllCategory {
  Future<List<List<String>>> fetchData() async {

    List<List<String>> dishList = [];
    
    List raw_indianDish_list = [];
    List raw_chickenDish_list = [];

    List<String> indianDishes_img = [];
    List<String> chickenDishes_img = [];

    List<String> indianDishes_name = [];
    List<String> chickenDishes_name = [];
    
    try {
      
      String final_url = "https://www.themealdb.com/api/json/v1/1/filter.php?a=Indian" ;
      String final_url2 = "https://www.themealdb.com/api/json/v1/1/filter.php?c=chicken";
      
      
      final response = await http.get(Uri.parse(final_url));
      final response2 = await http.get(Uri.parse(final_url2));
      
      
      if (response.statusCode == 200) {

        final data = json.decode(response.body);
        final data2 = json.decode(response2.body);



        raw_indianDish_list = data["meals"];
        for(int i = 0 ; i < raw_indianDish_list.length ; i++){
            indianDishes_name.add(raw_indianDish_list[i]["strMeal"]);
          }
        for(int i = 0 ; i < raw_indianDish_list.length ; i++){
            indianDishes_img.add(raw_indianDish_list[i]["strMealThumb"]);
          }

        raw_chickenDish_list = data2["meals"];
        for(int i = 0 ; i < raw_chickenDish_list.length ; i++){
            chickenDishes_name.add(raw_chickenDish_list[i]["strMeal"]);
          }
        for(int i = 0 ; i < raw_chickenDish_list.length ; i++){
            chickenDishes_img.add(raw_chickenDish_list[i]["strMealThumb"]);
          }

        dishList.add(indianDishes_name);
        dishList.add(indianDishes_img);
        dishList.add(chickenDishes_name);
        dishList.add(chickenDishes_img);

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