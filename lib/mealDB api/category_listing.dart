import 'dart:convert';

import 'package:http/http.dart' as http;
class ListCategory{
  Future<List<String>> fetchData() async {
    List raw_categories_list = [];
    List<String> categories = [];
    try {
      String final_url = "https://www.themealdb.com/api/json/v1/1/list.php?c=list" ;
      final response = await http.get(Uri.parse(final_url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        raw_categories_list = data["meals"];
        for(int i = 0 ; i < raw_categories_list.length ; i++){
            categories.add(raw_categories_list[i]["strCategory"]);
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