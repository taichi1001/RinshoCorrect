import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rinsho_collect/entity/article.dart';
import 'package:rinsho_collect/model/article_providers.dart';
import 'package:rinsho_collect/ui/article_view.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class JointScreen extends StatelessWidget {
  const JointScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read(articleViewController).initState();
      return;
    }, []);
    final _articles =
        useProvider(articleViewController.state.select((value) => value.sortedArticles));

    if (_articles == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
        leading: IconButton(
          icon: const Icon(Icons.ac_unit_outlined),
          onPressed: () {
            context.read(articleViewController).changeSortOrder();
          },
        ),
      ),
      body: ListView.builder(
        itemCount: _articles.length,
        itemBuilder: (context, index) => ProviderScope(
          overrides: [
            _currentArticle.overrideWithValue(_articles[index]),
          ],
          child: null,
        ),
      ),
    );
  }
}

final _currentArticle = ScopedProvider<Article>(null);

class ArticleListCard extends StatelessWidget {
  const ArticleListCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _article = useProvider(_currentArticle);
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
