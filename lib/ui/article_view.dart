import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rinsho_collect/entity/article.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:chewie/chewie.dart';
import 'package:rinsho_collect/model/article_view_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatelessWidget {
  const ArticleView({
    @required this.article,
    Key key,
  }) : super(key: key);

  final Article article;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('詳細'),
      ),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider<ArticleViewModel>(
            create: (context) => ArticleViewModel(),
            builder: (context, baz) {
              final _chewieController =
                  context.select((ArticleViewModel model) => model.chewieController);
              final _isLoaded = context.select((ArticleViewModel model) => model.isLoaded);
              return SingleChildScrollView(
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
              );
            },
          ),
        ],
      ),
    );
  }
}
