import 'dart:convert';
import 'package:http/http.dart' as http;

class AllCategory {
  Future<List<List<String>>> fetchData() async {

    List<List<String>> dishList = [];
    
    List rawIndiandishList = [];
    List rawChickendishList = [];

    List<String> indiandishesImg = [];
    List<String> chickendishesImg = [];

    List<String> indiandishesName = [];
    List<String> chickendishesName = [];
    
    try {
      
      String finalUrl = "https://www.themealdb.com/api/json/v1/1/filter.php?a=Indian" ;
      String finalUrl2 = "https://www.themealdb.com/api/json/v1/1/filter.php?c=chicken";
      
      
      final response = await http.get(Uri.parse(finalUrl));
      final response2 = await http.get(Uri.parse(finalUrl2));
      
      
      if (response.statusCode == 200) {

        final data = json.decode(response.body);
        final data2 = json.decode(response2.body);



        rawIndiandishList = data["meals"];
        for(int i = 0 ; i < rawIndiandishList.length ; i++){
            indiandishesName.add(rawIndiandishList[i]["strMeal"]);
          }
        for(int i = 0 ; i < rawIndiandishList.length ; i++){
            indiandishesImg.add(rawIndiandishList[i]["strMealThumb"]);
          }

        rawChickendishList = data2["meals"];
        for(int i = 0 ; i < rawChickendishList.length ; i++){
            chickendishesName.add(rawChickendishList[i]["strMeal"]);
          }
        for(int i = 0 ; i < rawChickendishList.length ; i++){
            chickendishesImg.add(rawChickendishList[i]["strMealThumb"]);
          }

        dishList.add(indiandishesName);
        dishList.add(indiandishesImg);
        dishList.add(chickendishesName);
        dishList.add(chickendishesImg);

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