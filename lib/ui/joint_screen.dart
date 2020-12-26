import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rinsho_collect/entity/article.dart';
import 'package:rinsho_collect/enum/joint.dart';
import 'package:rinsho_collect/model/joint_screen_controller.dart';
import 'package:rinsho_collect/model/articles_controller.dart';
import 'package:rinsho_collect/ui/article_view.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

class JointScreen extends HookWidget {
  const JointScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read(articlesController).fetch();
      return;
    }, []);

    return DefaultTabController(
      length: JointMode.values.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('設定'),
          leading: IconButton(
            icon: const Icon(Icons.ac_unit_outlined),
            onPressed: () {
              context.read(jointScreenController).changeSortType();
            },
          ),
          bottom: TabBar(
            isScrollable: true,
            indicator: BubbleTabIndicator(
              indicatorHeight: 25.0,
              indicatorColor: Colors.blueAccent,
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
            ),
            tabs: [
              for (final value in JointMode.values)
                Tab(child: Text(value.typeName)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            for (final value in JointMode.values)
              _ArticlesListView(mode: value),
          ],
        ),
      ),
    );
  }
}

class _ArticlesListView extends HookWidget {
  const _ArticlesListView({
    @required this.mode,
    Key key,
  }) : super(key: key);

  final JointMode mode;

  @override
  Widget build(BuildContext context) {
    final _articles = useProvider(sortedArticles(mode)).state;

    if (_articles == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return AnimationLimiter(
      key: ObjectKey(useProvider(sortType).state),
      child: ListView.builder(
        itemCount: _articles.length,
        itemBuilder: (context, index) => ProviderScope(
          overrides: [
            currentArticle.overrideWithValue(_articles[index]),
          ],
          child: const AnimationConfiguration.synchronized(
            duration: Duration(milliseconds: 600),
            child: FadeInAnimation(
              child: _ArticleCard(),
            ),
          ),
        ),
      ),
    );
  }
}

final currentArticle = ScopedProvider<Article>(null);

class _ArticleCard extends HookWidget {
  const _ArticleCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _article = useProvider(currentArticle);
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
                SizedBox(height: 125.h, child: const _EyeCatch()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          SizedBox(width: 290.w, child: const _Title()),
                          const SizedBox(height: 8),
                          SizedBox(width: 290.w, child: const _SubTitle()),
                          const SizedBox(height: 8),
                          const Text(
                            '#タグ',
                            style: TextStyle(fontSize: 12),
                          ),
                        ]),
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

class _EyeCatch extends HookWidget {
  const _EyeCatch({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image: useProvider(currentArticle).eyecatch.toString(),
    );
  }
}

class _Title extends HookWidget {
  const _Title({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      useProvider(currentArticle).title,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _SubTitle extends HookWidget {
  const _SubTitle({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      useProvider(currentArticle).subTitle,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      softWrap: false,
      style: const TextStyle(fontSize: 14),
    );
  }
}
