import 'package:flutter/material.dart';
import 'package:recipe_app/components/category_chip.dart';
import 'package:recipe_app/components/recipe_template.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color customColor = Color(0xFF11151E);

  final List category_name = [
    "🔥 Popular", "🥗 Salad", "🍳 Breakfast", "🍔 Burgers", "🍕 Pizza",
  ];

  final List category_select = [
    true, false, false, false, false
  ];

    void categoryTap(int index) {
    setState(() {
      for (int i = 0; i < category_select.length; i++) {
        category_select[i] = false;
      }
      category_select[index] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello,',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontFamily: 'Roboto',
                            ),
                          ),
                          Text(
                            'Kristin 👋',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("assets/images/obito.jpg"),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: category_name.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          categoryTap(index);
                        },
                        child: CategoryChip(
                          label: category_name[index],
                          isSelected: category_select[index],
                        ),
                      );
                    },
                  ),
                ),
        
                SizedBox(height: 30,),
        
        
                RecipeTemplate(),
                RecipeTemplate(),
                RecipeTemplate(),
              ],
            ),
          ),
        ),
      ),);
  }
}