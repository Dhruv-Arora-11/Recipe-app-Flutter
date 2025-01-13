import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../mealDB api/fullRecipe.dart';

class FullScreenRecipe extends StatefulWidget {
  final String recipeTitle;

  const FullScreenRecipe({
    super.key,
    required this.recipeTitle,
  });

  @override
  State<FullScreenRecipe> createState() => _FullScreenRecipeState();
}

class _FullScreenRecipeState extends State<FullScreenRecipe> {
  YoutubePlayerController? _controller; // Made nullable
  bool _isDataFetched = false;
  late Map<String, dynamic> meals;
  late List<String> ingredients;
  late String steps;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      // Fetch data
      meals = await RecipeApi().fetchRecipe(widget.recipeTitle, context);
      ingredients = RecipeApi.ingredients;
      steps = meals["strInstructions"] ?? "";

      final videoId = YoutubePlayer.convertUrlToId(meals["strYoutube"]);
      if (videoId != null) {
        _controller = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
          ),
        );
      }

      // Update state
      setState(() {
        _isDataFetched = true;
      });
    } catch (e) {
      // Handle errors if any
      setState(() {
        _isDataFetched = false;
      });
      debugPrint("Error fetching data: $e");
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF11151E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF11151E),
        title: Text(
          widget.recipeTitle,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: _isDataFetched
          ? SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // YouTube Player Section (if videoId exists)
              if (_controller != null)
                YoutubePlayer(
                  controller: _controller!,
                  showVideoProgressIndicator: true,
                  aspectRatio: 16 / 9,
                ),

              if (_controller != null) const SizedBox(height: 20),

              // Ingredients Section
              _buildSectionTitle('Ingredients'),
              const SizedBox(height: 8),
              _buildList(ingredients, 'No ingredients available'),

              const SizedBox(height: 20),

              // Steps Section
              _buildSectionTitle('Steps'),
              const SizedBox(height: 8),
              _buildListWithIndex(steps.split('\n'), 'No steps available'),
            ],
          ),
        ),
      )
          : const Center(
        child: CircularProgressIndicator(
          color: Colors.redAccent,
        ),
      ),
    );
  }

  // Builds a section title
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.redAccent,
        decoration: TextDecoration.underline,
      ),
    );
  }

  // Builds a list of items (e.g., ingredients or steps)
  Widget _buildList(List<String> items, String emptyMessage) {
    return items.isNotEmpty
        ? Card(
      color: const Color(0xFF171D2B),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items
              .map(
                (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                '- $item',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          )
              .toList(),
        ),
      ),
    )
        : Text(
      emptyMessage,
      style: const TextStyle(color: Colors.grey, fontSize: 16),
    );
  }

  // Builds a list of items with an index (for steps)
  Widget _buildListWithIndex(List<String> items, String emptyMessage) {
    return items.isNotEmpty
        ? Card(
      color: const Color(0xFF171D2B),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items.asMap().entries.map((entry) {
            int idx = entry.key + 1;
            String item = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                '$idx. $item',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    )
        : Text(
      emptyMessage,
      style: const TextStyle(color: Colors.grey, fontSize: 16),
    );
  }
}
