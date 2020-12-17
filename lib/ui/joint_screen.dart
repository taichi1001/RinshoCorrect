import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rinsho_collect/entity/article.dart';
import 'package:rinsho_collect/ui/article_view.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:rinsho_collect/model/article_model.dart';

class JointScreen extends StatelessWidget {
  const JointScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _list = context.select((ArticleModel model) => model.articleList);
    final _isLoaded = context.select((ArticleModel model) => model.isLoaded);
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: _isLoaded
          ? ListView.builder(
              itemCount: _list.length,
              itemBuilder: (BuildContext context, int index) => ArticleListCard(
                article: _list[index],
              ),
            )
          : const Text('load中'),
    );
  }
}

class ArticleListCard extends StatelessWidget {
  const ArticleListCard({
    @required this.article,
    Key key,
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return ArticleView(article: article);
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Card(
          color: Theme.of(context).cardColor,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  height: 125.h,
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: article.eyecath.toString(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: 200.w,
                            child: Text(
                              article.subTitle,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '#タグ',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.favorite,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
