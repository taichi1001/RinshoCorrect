import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class ArticleViewModel with ChangeNotifier {
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;
  bool isLoaded = false;

  ArticleViewModel() {
    _fetchAll();
  }

  void _fetchAll() {
    isLoaded = false;
    videoPlayerController = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 16 / 9,
      looping: true,
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.portraitUp,
      ],
      deviceOrientationsOnEnterFullScreen: [
        DeviceOrientation.portraitUp,
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ],
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.blue,
        backgroundColor: Colors.black,
        bufferedColor: Colors.lightGreen,
      ),
      placeholder: Container(
        color: Colors.grey,
      ),
      autoInitialize: true,
    );
    isLoaded = true;
    notifyListeners();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }
}
