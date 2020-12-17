import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class ArticleViewModel with ChangeNotifier {
  ChewieController _chewieController;
  ChewieController get chewieController => _chewieController;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  ArticleViewModel() {
    _fetchAll();
  }

  void _fetchAll() {
    _isLoaded = false;
    final _videoPlayerController = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
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
    _isLoaded = true;
    notifyListeners();
  }

  @override
  void dispose() {
    chewieController.dispose();
    super.dispose();
  }
}
