import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:recipe_app/Screens/first_page.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final Color backgroundColor = Color(0xFF11151E); 
 // Background color
  final Color searchBarColor =Color(0xFF171D2B); 
  final Color customColor = Color(0xFF11151E);

 // Matches the tile color
  int _selectedIndex = 1;

  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
      switch(_selectedIndex){
        case 0:
          Navigator.push(context, MaterialPageRoute(builder: (context) => FirstPage()));
          break;
        case 1:
          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
          break;
        case 2:
          break;
        case 3:
          break;
      }
    });
  }

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
                   child: Text(
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Type something...",
                        hintStyle: TextStyle(color: Colors.white54),
                        prefixIcon: Icon(Icons.search, color: Colors.white),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      style: TextStyle(color: Colors.white),
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
