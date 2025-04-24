import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_app/components/fullScreenRecipe.dart';
import 'package:recipe_app/components/recipe_template.dart';
import 'package:recipe_app/components/searchBar/apiForSearch.dart';
import 'dart:convert';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final SearchAPI _mealApi = SearchAPI();
  List<Map<String, dynamic>> _meals = []; // Store full meal data
  bool _hasSearched = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _handleSearch(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _meals = [];
        _hasSearched = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _hasSearched = true;
    });

    try {
      List<Map<String, dynamic>> fetchedMeals;
      if (query.length == 1) {
        fetchedMeals = await _mealApi.fetchMealsByFirstLetter(query.trim());
      } else {
        fetchedMeals = await _mealApi.fetchMealsByName(query.trim());
      }

      setState(() {
        _meals = fetchedMeals;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      setState(() {
        _meals = [];
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF11151E),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                padding: const EdgeInsets.only(left: 0.0, top: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF171D2B),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _handleSearch,
                    decoration: InputDecoration(
                      hintText: "Type something...",
                      hintStyle: const TextStyle(color: Colors.white54),
                      prefixIcon: const Icon(Icons.search,
                          color: Colors.white, size: 30),
                      border: InputBorder.none,
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 15),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: _buildSearchResults(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (!_hasSearched) {
      return const Center(
        child: Text(
          "Start typing to search for meals...",
          style: TextStyle(color: Colors.white54, fontSize: 16),
        ),
      );
    } else if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    } else if (_meals.isEmpty) {
      return const Center(
        child: Text(
          "No results found.",
          style: TextStyle(color: Colors.white54, fontSize: 16),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: _meals.length,
        itemBuilder: (context, index) {
          final meal = _meals[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullScreenRecipe(recipeTitle: meal['strMeal'] ?? ''),
                ),
              );
            },
            child: RecipeTemplate(
              imageUrl: meal['strMealThumb'] ??
                  '', // Provide a default value if null
              dishName: meal['strMeal'] ?? '',
            ),
          );
        },
      );
    }
  }
}

