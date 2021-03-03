import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rinsho_collect/entity/article_mode.dart';
import 'package:rinsho_collect/enum/display_mode.dart';
import 'package:rinsho_collect/model/articles_controller.dart';
import 'package:rinsho_collect/model/bookmark_controller.dart';
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

class TerminologyListScreen extends HookWidget {
  const TerminologyListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read(bookmarkController).fetchBookmarkList();
      return;
    }, []);

    final _displayMode = useProvider(articleListDisplayMode).state;
    final _textEditingController = useProvider(textEditingController).state;
    return GestureDetector(
      onTap: () {
        final currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus.unfocus();
        }
      },
      child: DefaultTabController(
        length: _getTabs(_displayMode).length,
        child: Scaffold(
          appBar: AppBar(
            // backgroundColor: const Color(0xFFf4f9f7),
            title: Container(
              height: 40,
              child: TextField(
                textInputAction: TextInputAction.search,
                onSubmitted: context.read(articleListScreenController).searchArticle,
                controller: _textEditingController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _textEditingController.text.isEmpty
                      ? null
                      : InkWell(
                          onTap: context.read(articleListScreenController).textClear,
                          child: const Icon(Icons.clear),
                        ),
                  contentPadding: const EdgeInsets.all(10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: const OutlineInputBorder(),
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.sort),
              onPressed: () {
                context.read(articleListScreenController).changeSortType();
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.model_training),
                onPressed: () {
                  context.read(articleListScreenController).changeDisplayMode();
                },
              ),
              // IconButton(
              //   icon: const Icon(Icons.rotate_90_degrees_ccw_sharp),
              //   onPressed: () {
              //     FirebaseAuth.instance.signOut();
              //   },
              // ),
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
            refreshController: RefreshController(),
            articleMode: ArticleMode(jointMode: value),
          ),
      ];
    } else if (mode == DisplayMode.symptomDisorder) {
      return [
        for (final value in SymptomDisorder.values)
          _ArticlesListView(
            key: PageStorageKey(value),
            refreshController: RefreshController(),
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
    @required this.articleMode,
    @required this.refreshController,
    Key key,
  }) : super(key: key);

  final ArticleMode articleMode;
  final RefreshController refreshController;

  Future _onRefresh(BuildContext context) async {
    await context.read(articlesController).fetch();
    await context.read(bookmarkController).fetchBookmarkList();
    refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final _articles = useProvider(sortedArticles(articleMode)).state;
    if (_articles == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return AnimationLimiter(
      key: ObjectKey(useProvider(articleListSortType).state),
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
      child: const Padding(
        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Card(
          margin: EdgeInsets.zero,
          // color: Color(0xFFf4f9f7),
          child: _Tes(),
        ),
      ),
    );
  }
}

class _Tes extends HookWidget {
  const _Tes({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 220.w,
            child: const _Info(),
          ),
          const SizedBox(width: 8),
          Container(
            width: 99.w,
            child: const _EyeCatch(),
          ),
        ],
      ),
    );
  }
}

class _Info extends HookWidget {
  const _Info({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _article = useProvider(currentArticle);
    final _date = _article.publishedAt;
    final _isFavorite = useProvider(currentBookmark(_article.id)).state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Title(),
        Row(
          children: [
            Text(_article.author),
            const SizedBox(width: 8),
            Text('${_date.year}/${_date.month}/${_date.day}'),
            const SizedBox(width: 8),
            if (_isFavorite)
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                color: Colors.red,
                onPressed: () => context.read(bookmarkController).changeIsBookmark(_article.id),
              )
            else
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.favorite, color: Colors.grey),
                color: Colors.grey,
                onPressed: () => context.read(bookmarkController).changeIsBookmark(_article.id),
              ),
          ],
        ),
        const Text(
          '#タグ',
          style: TextStyle(fontSize: 12),
        ),
        // if (_count != null)
        Text(
          '閲覧数：${_article.subscriber.toString()}',
          style: const TextStyle(fontSize: 12),
        )
      ],
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
      maxLines: 3,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
