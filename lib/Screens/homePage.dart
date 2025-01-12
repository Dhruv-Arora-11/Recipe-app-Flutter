import 'package:flutter/material.dart';
import 'package:recipe_app/animations/leftTransition.dart';
import 'package:recipe_app/components/category_chip.dart';
import 'package:recipe_app/components/recipe_template.dart';
import 'package:recipe_app/mealDB%20api/category_listing.dart';
import 'package:recipe_app/mealDB%20api/fullRecipe.dart';
import 'package:recipe_app/mealDB%20api/recipeCallForParticularCategory.dart/all_category.dart';
import 'package:recipe_app/mealDB%20api/recipeCallForParticularCategory.dart/any_other_category.dart';

import '../components/fullScreenRecipe.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color customColor = Color(0xFF11151E);
  ListCategory listCategory = ListCategory();
  AllCategory all_category_call = AllCategory();
  RecipeApi fetchRecipe = new RecipeApi();
  String selected_category = "All";
  bool isNavigating = false;
  bool enable_loading = true;
  final List category_name = [
    "🌐 All",
    "🥦 Vegetarian",
    "🍗 Chicken",
    "🌱 Vegan",
    "🍰 Dessert",
    "🍳 Breakfast",
    "🐐 Goat",
    "🥩 Lamb",
    "🧩 Miscellaneous",
    "🍝 Pasta",
    "🐖 Pork",
    "🐟 Seafood",
    "🍟 Side",
    "🥗 Starter",
  ];

  List<List<String>> Dishes = [];

  List<String> indianDishes_img = [];
  List<String> chickenDishes_img = [];

  List<String> indianDishes_name = [];
  List<String> chickenDishes_name = [];

  Future<void> category_call_dishes(selectedCategory) async {
    AnyOtherCategory otherCategory = AnyOtherCategory(selected_category: selectedCategory.substring(1));
    if (selectedCategory.toString().trim() == "All") {

      Dishes = await all_category_call.fetchData();
      try {
        indianDishes_name = Dishes[0];
        indianDishes_img = Dishes[1];
        chickenDishes_img = Dishes[3];
        chickenDishes_name = Dishes[2];
        print("I am outside of the set state of category call dishes");
        setState(() {
          enable_loading = false;
        });
      } catch (e) {
        print(e);
      }
    } else {
      print("Now I am outside of the set state of category call dishes else part");
      setState(() {
        Fun_for_otherCategory(otherCategory);
        enable_loading = false;
      });
    }
  }

  void recipeTap(String dishName, BuildContext context) async {
    if (isNavigating) return;  // Prevent multiple taps

    setState(() {
      isNavigating = true; // Block further taps
    });

    try {
      // Fetch the recipe data
      final meals = await RecipeApi().fetchRecipe(dishName, context);
      final ingredients = RecipeApi.ingredients;

      // Push the new screen
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FullScreenRecipe(
            recipeTitle: meals["strMeal"],
            ingredients: ingredients,
            steps: meals["strInstructions"].split('\n'),
            videoURL: meals["strYoutube"],
          ),
        ),
      );

      // After returning from the new screen, reset navigation state
      setState(() {
        isNavigating = false;
      });
    } catch (e) {
      // Handle any errors
      print('Error fetching recipe: $e');
      setState(() {
        isNavigating = false; // Ensure flag is reset on error
      });
    }
  }


  // ignore: non_constant_identifier_names
  void Fun_for_otherCategory(otherCategory) async {
    print("this is the else of this ");
    Dishes = await otherCategory.fetchData();
    print("fetchData is compeleted");
    indianDishes_name = Dishes[0];
    indianDishes_img = Dishes[1];
    setState(() {});
  }

  List<String> category = [];

  // ignore: non_constant_identifier_names
  void fetch_category() async {
    for (int i = 0; i < category_name.length; i++) {
      category_select.add(false);
    }
    await category_call_dishes(selected_category);
  }

  @override
  void initState() {
    fetch_category();
    super.initState();
  }

  // ignore: non_constant_identifier_names
  final List category_select = [];

  void categoryTap(int index) async {
    setState(() {
      for (int i = 0; i < category_select.length; i++) {
        category_select[i] = false;
      }
      category_select[index] = true;
    });

    selected_category = category_name[index];
    selected_category = selected_category.substring(2);

    // Clear existing data
    setState(() {
      indianDishes_name = [];
      indianDishes_img = [];
    });

    // Fetch data for the selected category
    await category_call_dishes(selected_category);

    // Update the UI with the new data
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: customColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
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
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                letterSpacing: 2
                              ),
                            ),
                            Text(
                              'Kristin 👋',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                  letterSpacing: 2

                              ),
                            ),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage("assets/images/obito.jpg"),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
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
                  SizedBox(height: 20),
                  AbsorbPointer(
                    absorbing: isNavigating,
                    child: enable_loading
                        ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                        strokeWidth: 6.0,
                      ),
                    )
                        : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: indianDishes_name.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            recipeTap(indianDishes_name[index], context);
                          },
                          child: RecipeTemplate(
                            dishName: indianDishes_name[index],
                            imageUrl: indianDishes_img[index],
                          ),
                        );
                      },
                    ),
                  )




                ],
              ),
            ),
          ),
        ),
      );
    }
  }
