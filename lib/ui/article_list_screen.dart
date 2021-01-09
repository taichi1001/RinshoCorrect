import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rinsho_collect/enum/display_mode.dart';
import 'package:rinsho_collect/model/articles_controller.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rinsho_collect/entity/article.dart';
import 'package:rinsho_collect/enum/joint.dart';
import 'package:rinsho_collect/enum/symptom_disorder.dart';
import 'package:rinsho_collect/model/article_list_screen_controller.dart';
import 'package:rinsho_collect/model/article_screen_controller.dart';
import 'package:rinsho_collect/ui/article_screen.dart';

class ArticleListScreen extends HookWidget {
  const ArticleListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read(articleListScreenController).fetchSubscribers();
      context.read(articleListScreenController).fetchFavoriteList();
      return;
    }, []);

    final _displayMode = useProvider(displayMode).state;
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: DefaultTabController(
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
            jointMode: value,
            refreshController: RefreshController(),
          ),
      ];
    } else if (mode == DisplayMode.symptomDisorder) {
      return [
        for (final value in SymptomDisorder.values)
          _ArticlesListView(
            key: PageStorageKey(value),
            symptomDisorder: value,
            refreshController: RefreshController(),
          ),
      ];
    } else {
      return [];
    }
  }
}

class _ArticlesListView extends HookWidget {
  const _ArticlesListView({
    @required this.refreshController,
    this.jointMode,
    this.symptomDisorder,
    Key key,
  }) : super(key: key);

  final JointMode jointMode;
  final SymptomDisorder symptomDisorder;
  final RefreshController refreshController;

  Future _onRefresh(BuildContext context) async {
    await context.read(articlesController).fetch();
    await context.read(articleListScreenController).fetchSubscribers();
    await context.read(articleListScreenController).fetchFavoriteList();
    refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    List<Article> _articles;
    if (jointMode != null) {
      _articles = useProvider(sortedJointArticles(jointMode)).state;
    } else {
      _articles = useProvider(sortedSymptomDisorderArticles(symptomDisorder)).state;
    }

    if (_articles == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return AnimationLimiter(
      key: ObjectKey(useProvider(sortType).state),
      child: SmartRefresher(
        header: const ClassicHeader(),
        controller: refreshController,
        onRefresh: () => _onRefresh(context),
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
    final _count = useProvider(currentTest(_article.id)).state;
    final _isFavorite = useProvider(currentFavorite(_article.id)).state;
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              context.read(articleListScreenController).incrementSubscribers(_article.id);
              return ProviderScope(
                overrides: [article.overrideWithValue(_article)],
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
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      if (_count != null) Text(_count.toString()) else const Text(''),
                      const SizedBox(height: 8),
                      SizedBox(width: 270.w, child: const _Title()),
                      const SizedBox(height: 8),
                      SizedBox(width: 270.w, child: const _SubTitle()),
                      const SizedBox(height: 8),
                      const Text(
                        '#タグ',
                        style: TextStyle(fontSize: 12),
                      ),
                    ]),
                    if (_isFavorite)
                      IconButton(
                        icon: const Icon(Icons.favorite, color: Colors.red),
                        color: Colors.red,
                        onPressed: () =>
                            context.read(articleListScreenController).changeIsFavorite(_article.id),
                      )
                    else
                      IconButton(
                        icon: const Icon(Icons.favorite, color: Colors.grey),
                        color: Colors.grey,
                        onPressed: () =>
                            context.read(articleListScreenController).changeIsFavorite(_article.id),
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
