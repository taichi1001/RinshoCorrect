import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:chewie/chewie.dart';
import 'package:rinsho_collect/repository/micro_cms_repository.dart';
import 'package:video_player/video_player.dart';
import 'package:rinsho_collect/entity/article.dart';

final _videoPlayerController = StateProvider<VideoPlayerController>((ref) => null);
final isLoading = StateProvider((ref) => false);

final currentArticle = StateProvider.autoDispose<Article>((ref) => null);

final chewieController = StateProvider<ChewieController>((ref) => null);

final articleScreenController = Provider((ref) => ArticleScreenController(read: ref.read));

class ArticleScreenController {
  ArticleScreenController({
    this.read,
  });

  final Reader read;

  Future init(String id) async {
    await getArticleContents(id);
    await Future.delayed(Duration.zero, () => read(isLoading).state = false);
    await initVideoPlayerController(read(currentArticle).state.videoURL);
    await initChewieController();
    await Future.delayed(Duration.zero, () => read(isLoading).state = true);
  }

  Future initVideoPlayerController(String source) async {
    read(_videoPlayerController).state = await Future.delayed(
      Duration.zero,
      () => VideoPlayerController.network(source),
    );
    await read(_videoPlayerController).state.initialize();
  }

  Future initChewieController() async {
    read(chewieController).state = await Future.delayed(
      Duration.zero,
      () => ChewieController(
        videoPlayerController: read(_videoPlayerController).state,
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
          color: Colors.black,
        ),
        autoInitialize: true,
      ),
    );
  }

  Future getArticleContents(String id) async {
    final result = await read(microCMSRepository).getArticleContents(id);
    read(currentArticle).state = result;
  }
}
