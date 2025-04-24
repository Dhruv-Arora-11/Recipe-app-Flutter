import 'dart:convert';

import 'package:http/http.dart' as http;
class ListCategory{
  Future<List<String>> fetchData() async {
    List rawCategoriesList = [];
    List<String> categories = [];
    try {
      String finalUrl = "https://www.themealdb.com/api/json/v1/1/list.php?c=list" ;
      final response = await http.get(Uri.parse(finalUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        rawCategoriesList = data["meals"];
        for(int i = 0 ; i < rawCategoriesList.length ; i++){
            categories.add(rawCategoriesList[i]["strCategory"]);
            print(categories[i]);
          }
        return categories;
      } else {
        print('Error: ${response.statusCode}');
        return categories;
      }
    } catch (e) {
      print('Error: $e');
      return categories;
    }
  }
}