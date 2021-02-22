import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rinsho_collect/entity/article.dart';
import 'package:rinsho_collect/entity/article_mode.dart';
import 'package:rinsho_collect/enum/joint.dart';
import 'package:rinsho_collect/model/articles_controller.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('臨床コレクト'),
      ),
      body: Container(
        child: ListView(
          children: const [
            Text('今週の閲覧数ランキング'),
            Text('全て'),
            SizedBox(height: 16),
            _ArticleList(),
            SizedBox(height: 32),
            Text('関節別'),
            SizedBox(height: 16),
            _ArticleList(),
            SizedBox(height: 32),
            Text('症状・障害別'),
            SizedBox(height: 16),
            _ArticleList(),
          ],
        ),
      ),
    );
  }
}

final _currentArticle = ScopedProvider<Article>(null);

class _ArticleList extends HookWidget {
  const _ArticleList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _articles = useProvider(sortedArticles(ArticleMode(jointMode: JointMode.all))).state;

    if (_articles == null) {
      return Text('ロード中');
    }
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _articles.length,
        itemBuilder: (context, index) => ProviderScope(
          overrides: [_currentArticle.overrideWithValue(_articles[index])],
          child: const Padding(
            padding: EdgeInsets.only(right: 8, left: 8),
            child: _EyeCatch(),
          ),
        ),
      ),
    );
    // return Expanded(
    //   child: ScrollSnapList(
    //     reverse: true,
    //     onItemFocus: null,
    //     itemSize: 100,
    //     itemCount: _articles.length,
    //     itemBuilder: (context, index) => ProviderScope(
    //       overrides: [_currentArticle.overrideWithValue(_articles[index])],
    //       child: const _EyeCatch(),
    //     ),
    //   ),
    // );
  }
}

class _EyeCatch extends HookWidget {
  const _EyeCatch({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image: useProvider(_currentArticle).eyecatch.toString(),
    );
  }
}
