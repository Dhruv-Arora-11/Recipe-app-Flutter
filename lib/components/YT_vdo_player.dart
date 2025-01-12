import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutuberPlayer extends StatefulWidget {
  final String videoURL;
  const YoutuberPlayer({super.key, required this.videoURL});

  @override
  State<YoutuberPlayer> createState() => _YoutuberPlayerState();
}

class _YoutuberPlayerState extends State<YoutuberPlayer> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoURL)!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        isLive: false,
        enableCaption: true,
      ),
    )..addListener(() {
      if (_controller.value.isReady && !_isPlayerReady) {
        setState(() {
          _isPlayerReady = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressColors: const ProgressBarColors(
          playedColor: Colors.red,
          handleColor: Colors.redAccent,
        ),
        onReady: () {
          _isPlayerReady = true;
        },
        bottomActions: [
          CurrentPosition(),
          ProgressBar(isExpanded: true),
          RemainingDuration(),
          FullScreenButton(),
        ],
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("YouTube Player"),
            backgroundColor: Colors.red,
          ),
          body: Column(
            children: [
              // YouTube player widget
              player,
              // Additional controls below the player
              if (_isPlayerReady)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Now Playing",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _controller.metadata.title,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Channel: ${_controller.metadata.author}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.replay_10),
                              onPressed: () {
                                _controller.seekTo(
                                    _controller.value.position -
                                        const Duration(seconds: 10));
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                _controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (_controller.value.isPlaying) {
                                    _controller.pause();
                                  } else {
                                    _controller.play();
                                  }
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.forward_10),
                              onPressed: () {
                                _controller.seekTo(
                                    _controller.value.position +
                                        const Duration(seconds: 10));
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                )
              else
                const Center(child: CircularProgressIndicator()),
            ],
          ),
        );
      },
    );
  }
}
