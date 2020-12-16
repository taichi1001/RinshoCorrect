import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rinsho_collect/entity/article.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:video_player/video_player.dart';

class ArticleView extends StatelessWidget {
  const ArticleView({
    @required this.article,
    Key key,
  }) : super(key: key);

  final Article article;
  @override
  Widget build(BuildContext context) {
    VideoPlayerController _videoPlayerController;
    ChewieController _chewieController;
    _videoPlayerController = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 3 / 2,
      looping: true,
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.portraitUp,
      ],
      deviceOrientationsOnEnterFullScreen: [
        DeviceOrientation.portraitUp,
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ],
      // Try playing around with some of these other options:

      //showControls: false,
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('詳細'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              article.eyecath.toString(),
            ),
            Text(article.title),
            Html(
              data: article.abstract,
            ),
            Container(
              height: 200,
              child: Chewie(
                controller: _chewieController,
              ),
            ),
            Html(data: article.body),
          ],
        ),
      ),
    );
  }
}
