import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rinsho_collect/entity/article.dart';
import 'package:rinsho_collect/model/article_model.dart';
import 'package:rinsho_collect/model/joint_screen_model.dart';
import 'package:rinsho_collect/ui/article_view.dart';
import 'package:transparent_image/transparent_image.dart';

class JointScreen extends StatelessWidget {
  const JointScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<JointScreenModel>(
      create: (context) => JointScreenModel(),
      builder: (context, _) {
        final _articleList = context.select((JointScreenModel model) => model.showArticleList);
        final _isLoaded = context.select((ArticleModel model) => model.isLoaded);
        return Scaffold(
          appBar: AppBar(
            title: const Text('設定'),
          ),
          body: _isLoaded
              ? ListView.builder(
                  itemCount: _articleList.length,
                  itemBuilder: (BuildContext context, int index) => Provider.value(
                    value: _articleList[index],
                    child: const ArticleListCard(),
                  ),
                )
              : const Center(
                  child: Text('Load中'),
                ),
        );
      },
    );
  }
}

class ArticleListCard extends StatelessWidget {
  const ArticleListCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _article = context.watch<Article>();
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return ArticleView(article: _article);
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
                    image: _article.eyecath.toString(),
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
                            _article.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: 200.w,
                            child: Text(
                              _article.subTitle,
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
