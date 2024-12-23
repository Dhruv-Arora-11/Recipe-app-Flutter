import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:recipe_app/components/category_chip.dart';
import 'package:recipe_app/components/recipe_template.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final Color customColor = Color(0xFF11151E);

  final List category_name = [
    "🔥 Popular", "🥗 Salad", "🍳 Breakfast", "🍔 Burgers", "🍕 Pizza",
  ];

  final List category_select = [
    true, false, false, false, false
  ];

  int _selectedIndex = 0;

  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
      ),
      bottomNavigationBar: 
      Container(
        color: Colors.grey.shade900,
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
        child: GNav(   
          haptic: true,
          backgroundColor: customColor,
          iconSize: 19,
          color: Colors.white,
          activeColor: Colors.orange,
          tabBackgroundColor: Colors.grey.shade800,
          gap: 1,
          selectedIndex: _selectedIndex,
          onTabChange: _onNavBarTap,
          tabs: [
            GButton(
              icon: Icons.home,
              text: "Home",
            ),
            GButton(
              icon: Icons.search,
              text: "Search",
            ),
            GButton(
              icon: Icons.star_border,
              text: "Starred",
            ),
            GButton(
              icon: Icons.person,
              text: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
