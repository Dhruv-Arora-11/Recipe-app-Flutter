import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipe_app/animations/transition_to_anyDirection.dart';
import 'package:recipe_app/components/category_chip.dart';
import 'package:recipe_app/components/recipe_template.dart';
import 'package:recipe_app/mealDB%20api/category_listing.dart';
import 'package:recipe_app/mealDB%20api/fullRecipe.dart';
import 'package:recipe_app/mealDB%20api/recipeCallForParticularCategory.dart/all_category.dart';
import 'package:recipe_app/mealDB%20api/recipeCallForParticularCategory.dart/any_other_category.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  RecipeApi fetchRecipe = RecipeApi();
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

  final List category_select = [];
  List<String> category = [];

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickAndSaveImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        final Directory directory = await getApplicationDocumentsDirectory();
        final String path = directory.path;

        final File newImage =
            await File(image.path).copy('$path/profile_image.png');

        // Reload fresh bytes to avoid image cache issues
        final File savedImage = File('$path/profile_image.png');

        if (await savedImage.exists()) {
          setState(() {
            _profileImage = savedImage;
          });
        }
      }
    } catch (e) {
      print('Error picking/saving image: $e');
    }
  }

  Future<void> _loadSavedProfileImage() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final path = directory.path;
      final File file = File('$path/profile_image.png');

      if (await file.exists()) {
        setState(() {
          _profileImage = file;
        });
      }
    } catch (e) {
      print('Error loading saved image: $e');
    }
  }

  Future<void> category_call_dishes(selectedCategory) async {
    AnyOtherCategory otherCategory =
        AnyOtherCategory(selected_category: selectedCategory.substring(1));
    if (selectedCategory.trim() == "All") {
      Dishes = await all_category_call.fetchData();
      try {
        indianDishes_name = Dishes[0];
        indianDishes_img = Dishes[1];
        chickenDishes_img = Dishes[3];
        chickenDishes_name = Dishes[2];
        setState(() {
          enable_loading = false;
        });
      } catch (e) {
        print(e);
      }
    } else {
      setState(() {
        Fun_for_otherCategory(otherCategory);
        enable_loading = false;
      });
    }
  }

  void recipeTap(String dishName, BuildContext context) async {
    if (isNavigating) return;

    setState(() {
      isNavigating = true;
    });

    try {
      await Navigator.push(
        context,
        VerticalPageRoute(
          direction: SlideDirection.fromBottom,
          page: FullScreenRecipe(recipeTitle: dishName),
        ),
      );
    } catch (e) {
      print('Error fetching recipe: $e');
    } finally {
      setState(() {
        isNavigating = false;
      });
    }
  }

  void Fun_for_otherCategory(otherCategory) async {
    Dishes = await otherCategory.fetchData();
    indianDishes_name = Dishes[0];
    indianDishes_img = Dishes[1];
    setState(() {});
  }

  void fetch_category() async {
    for (int i = 0; i < category_name.length; i++) {
      category_select.add(false);
    }
    await category_call_dishes(selected_category);
  }

  void categoryTap(int index) async {
    setState(() {
      for (int i = 0; i < category_select.length; i++) {
        category_select[i] = false;
      }
      category_select[index] = true;
    });

    selected_category = category_name[index];
    selected_category = selected_category.substring(2);

    setState(() {
      indianDishes_name = [];
      indianDishes_img = [];
    });

    await category_call_dishes(selected_category);
    setState(() {});
  }


  Future<void> setLoggedInTrue() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('hasLoggedIn', true);
}


  @override
  void initState() {
    super.initState();
    fetch_category();
    _loadSavedProfileImage();
    setLoggedInTrue();
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
                                letterSpacing: 2),
                          ),
                          Text(
                            'Kristin 👋',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                letterSpacing: 2),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: _pickAndSaveImage,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white24,
                          image: _profileImage != null
                              ? DecorationImage(
                                  image: MemoryImage(_profileImage!
                                      .readAsBytesSync()),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: _profileImage == null
                            ? Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.white70,
                              )
                            : null,
                      ),
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
                        onTap: () => categoryTap(index),
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
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.orangeAccent),
                            strokeWidth: 6.0,
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: indianDishes_name.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () =>
                                  recipeTap(indianDishes_name[index], context),
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
