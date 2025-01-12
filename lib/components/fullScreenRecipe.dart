import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FullScreenRecipe extends StatelessWidget {
  final String recipeTitle;
  final String videoURL; // YouTube video URL
  final List<String> ingredients;
  final List<String> steps;
  final Color customColor = const Color(0xFF11151E);
  final Color tempColor = const Color(0xFF171D2B);

  FullScreenRecipe({
    super.key,
    required this.recipeTitle,
    required this.ingredients,
    required this.steps,
    required this.videoURL,
  });

  @override
  Widget build(BuildContext context) {
    // Extract the video ID from the URL
    final videoId = YoutubePlayer.convertUrlToId(videoURL);

    if (videoId == null) {
      throw ArgumentError("Invalid YouTube URL: $videoURL");
    }

    // Create the YouTube player controller
    final YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    return Scaffold(
      backgroundColor: customColor,
      appBar: AppBar(
        backgroundColor: customColor,
        title: Text(
          recipeTitle,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // YouTube Player
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                aspectRatio: 16 / 9,
              ),
              const SizedBox(height: 16),

              // Ingredients List
              Text(
                'Ingredients',
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              if (ingredients.isNotEmpty)
                ...ingredients.map(
                      (ingredient) => Text(
                    '- $ingredient',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
              else
                const Text("No ingredients available"),

              const SizedBox(height: 16),

              // Steps List
              Text(
                'Steps :',
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              if (steps.isNotEmpty)
                ...steps.asMap().entries.map((entry) {
                  int idx = entry.key + 1;
                  String step = entry.value;
                  return Text(
                    '$idx. $step',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                }).toList()
              else
                const Text("No steps available"),
            ],
          ),
        ),
      ),
    );
  }
}
