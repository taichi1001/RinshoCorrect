import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rinsho_collect/entity/article_mode.dart';
import 'package:rinsho_collect/enum/display_mode.dart';
import 'package:rinsho_collect/model/article_list_screen_controller.dart';
import 'package:rinsho_collect/model/articles_controller.dart';
import 'package:rinsho_collect/model/bookmark_controller.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:rinsho_collect/entity/article.dart';
import 'package:rinsho_collect/enum/joint.dart';
import 'package:rinsho_collect/enum/symptom_disorder.dart';
import 'package:rinsho_collect/model/bookmark_screen_controller.dart';
import 'package:rinsho_collect/model/article_screen_controller.dart';
import 'package:rinsho_collect/ui/article_screen.dart';

class BookmarkScreen extends HookWidget {
  const BookmarkScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read(bookmarkController).fetchBookmarkList();
      return;
    }, []);

    final _displayMode = useProvider(bookmarkListDisplayMode).state;
    return DefaultTabController(
      length: _getTabs(_displayMode).length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('記事'),
          leading: IconButton(
            icon: const Icon(Icons.ac_unit),
            onPressed: () {
              context.read(articleListScreenController).changeSortType();
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.deck),
              onPressed: () {
                context.read(articleListScreenController).changeDisplayMode();
              },
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            indicator: const BubbleTabIndicator(
              indicatorHeight: 25,
              indicatorColor: Colors.blueAccent,
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
            ),
            tabs: _getTabs(_displayMode),
          ),
        ),
        body: TabBarView(
          children: _getTabBatView(_displayMode),
        ),
      ),
    );
  }

  List<Tab> _getTabs(DisplayMode mode) {
    if (mode == DisplayMode.joint) {
      return [for (final value in JointMode.values) Tab(child: Text(value.typeName))];
    } else if (mode == DisplayMode.symptomDisorder) {
      return [for (final value in SymptomDisorder.values) Tab(child: Text(value.typeName))];
    } else {
      return [];
    }
  }

  List<Widget> _getTabBatView(DisplayMode mode) {
    if (mode == DisplayMode.joint) {
      return [
        for (final value in JointMode.values)
          _ArticlesListView(
            key: PageStorageKey(value),
            articleMode: ArticleMode(jointMode: value),
          ),
      ];
    } else if (mode == DisplayMode.symptomDisorder) {
      return [
        for (final value in SymptomDisorder.values)
          _ArticlesListView(
            key: PageStorageKey(value),
            articleMode: ArticleMode(symptomDisorder: value),
          ),
      ];
    } else {
      return [];
    }
  }
}

class _ArticlesListView extends HookWidget {
  const _ArticlesListView({
    this.articleMode,
    Key key,
  }) : super(key: key);

  final ArticleMode articleMode;

  @override
  Widget build(BuildContext context) {
    final _articles = useProvider(sortedBookmarkArticles(articleMode)).state;

    if (_articles == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return AnimationLimiter(
      key: ObjectKey(useProvider(articleListSortType).state),
      child: ListView.builder(
        itemCount: _articles.length,
        itemBuilder: (context, index) => ProviderScope(
          overrides: [currentArticle.overrideWithValue(_articles[index])],
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
    final _isBookmark = useProvider(currentBookmark(_article.id)).state;
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              context.read(articleListScreenController).incrementSubscribers(_article.id);
              return ProviderScope(
                overrides: [id.overrideWithValue(_article.id)],
                child: const ArticleScreen(),
              );
            },
          ),
        );
        await context.read(chewieController).state?.pause();
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(_article.subscriber.toString()),
                      const SizedBox(height: 8),
                      SizedBox(width: 270.w, child: const _Title()),
                      const SizedBox(height: 8),
                      const Text(
                        '#タグ',
                        style: TextStyle(fontSize: 12),
                      ),
                    ]),
                    if (_isBookmark)
                      IconButton(
                        icon: const Icon(Icons.bookmark, color: Colors.red),
                        color: Colors.red,
                        onPressed: () =>
                            context.read(bookmarkController).changeIsBookmark(_article.id),
                      )
                    else
                      IconButton(
                        icon: const Icon(Icons.bookmark, color: Colors.grey),
                        color: Colors.grey,
                        onPressed: () =>
                            context.read(bookmarkController).changeIsBookmark(_article.id),
                      )
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
