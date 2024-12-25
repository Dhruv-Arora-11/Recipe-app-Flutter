import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:recipe_app/Screens/homepage.dart';
import 'package:recipe_app/Screens/profile.dart';
import 'package:recipe_app/Screens/search_page.dart';
import 'package:recipe_app/Screens/starred.dart';
import 'package:recipe_app/components/category_chip.dart';
import 'package:recipe_app/components/recipe_template.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final Color customColor = Color(0xFF11151E);

  int _selectedIndex = 0;

  void _onNavBarTap(int index) {
    _selectedIndex = index;
    setState((){
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      

      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomePage(),
          SearchPage(),
          Starred(),
          profile()
        ],
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
          tabActiveBorder: Border.all(color: Colors.orange),
          tabBackgroundColor: Colors.grey.shade900,
          gap: 12,
          padding: EdgeInsets.all(15),
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
