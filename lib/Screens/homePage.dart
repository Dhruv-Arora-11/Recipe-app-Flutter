import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/components/category_chip.dart';
import 'package:recipe_app/components/recipe_template.dart';
import 'package:recipe_app/mealDB%20api/category_listing.dart';
import 'package:recipe_app/mealDB%20api/recipeCallForParticularCategory.dart/all_category.dart';
import 'package:recipe_app/mealDB%20api/recipeCallForParticularCategory.dart/any_other_category.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final Color customColor = Color(0xFF11151E);
  ListCategory listCategory = ListCategory();
  AllCategory all_category_call = AllCategory();
  // List<String> Recipe_for_category = [];
  String selected_category = "All";
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


  Future<void> category_call_dishes(selectedCategory)async{
    print(selectedCategory);
    AnyOtherCategory otherCategory = AnyOtherCategory(selected_category: selectedCategory.substring(1));
    if(selectedCategory.toString().trim() == "All"){
      print("I am in the all");
       Dishes = await all_category_call.fetchData();
       try {
        indianDishes_name = Dishes[0];
        indianDishes_img = Dishes[1];
        chickenDishes_img = Dishes[3];
        chickenDishes_name = Dishes[2];
       } catch (e) {
         print(e);
       }
    }else{
      setState(() {
        Fun_for_otherCategory(otherCategory);
        print("I am in the set state");
      });
    }
  }

  void Fun_for_otherCategory(otherCategory)async{
    print("this is the else of this ");
    Dishes = await otherCategory.fetchData();
    print("fetchData is compeleted");
    indianDishes_name = Dishes[0];
    indianDishes_img = Dishes[1];
    setState(() {});
  }

  List<String> category = [];

  void fetch_category() async{
    for(int i = 0 ; i < category_name.length ; i++){
      category_select.add(false);
    }
    await category_call_dishes(selected_category);
    setState(() {});
  }

  @override
  void initState() {
    fetch_category();
    super.initState();
  }

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

    print('Indian Dishes: $indianDishes_name');
  print('Indian Dishes Images: $indianDishes_img');

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
              SizedBox(height: 30),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: indianDishes_name.length,
                itemBuilder: (context, index) {
                  return RecipeTemplate(
                    dishName: indianDishes_name[index],
                    imageUrl: indianDishes_img[index],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
}