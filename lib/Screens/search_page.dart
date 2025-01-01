import 'package:flutter/material.dart';
import 'package:recipe_app/mealDB%20api/first_letter.dart';

class SearchPage extends StatefulWidget {
  static var user_message;

  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final Color backgroundColor = Color(0xFF11151E); 
  // ignore:  unused_field, non_constant_identifier_names
  static final TextEditingController user_message = TextEditingController();
  final Color searchBarColor =Color(0xFF171D2B); 
  final Color customColor = Color(0xFF11151E);
  bool hasLetter = false;
  List<String> Meals = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0,left: 10),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Padding(
                   padding: const EdgeInsets.only(left: 8.0),
                   child: 
                   Text(
                    "What are you looking for ?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                 ),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0,top:10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: searchBarColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: GestureDetector(
                      child: TextField(
                        onChanged: (value) async{
                          if(value.trim().isEmpty){
                            Meals = [];
                          }else{
                            if(!hasLetter){
                              String letter = value.trim()[0];
                              await Future.delayed(Duration(seconds: 2));
                              List<String> Meals = await API_fetch(letter: letter).fetchData();
                              for(int i = 0 ;i<Meals.length ; i++){
                                print(Meals[i]);
                              }
                              hasLetter = true;
                            }
                            else{
                              print("The API fetching is already completed");
                            }
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Type something...",
                          hintStyle: TextStyle(color: Colors.white54),
                          prefixIcon: Icon(Icons.search, color: Colors.white,size: 30),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Placeholder for search results
                Expanded(
                  child: Center(
                    child: Text(
                      "No results",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
