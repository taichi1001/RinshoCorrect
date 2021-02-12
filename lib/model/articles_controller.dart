import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rinsho_collect/model/article_list_screen_controller.dart';
import 'package:rinsho_collect/model/bookmark_screen_controller.dart';
import 'package:rinsho_collect/repository/micro_cms_repository.dart';
import 'package:rinsho_collect/enum/sort_type.dart';
import 'package:rinsho_collect/entity/article.dart';
import 'package:rinsho_collect/entity/article_mode.dart';
import 'package:rinsho_collect/model/bookmark_controller.dart';
import 'package:rinsho_collect/repository/firebase_repository.dart';
import 'package:rinsho_collect/util/filter_articles.dart';

final allArticles = StateProvider<List<Article>>((ref) => null);

final sortedArticles = StateProvider.family<List<Article>, ArticleMode>((ref, mode) {
  var articles = ref.watch(allArticles).state;
  articles = articles?.where((article) => article.tags.isNotEmpty)?.toList();

  List<Article> selectArticles;
  if (mode.jointMode != null) {
    selectArticles = FilterArticles.getJointModeArticleList(articles, mode.jointMode);
  } else if (mode.symptomDisorder != null) {
    selectArticles = FilterArticles.getSymptomDisorderArticleList(articles, mode.symptomDisorder);
  }

  final sort = ref.watch(articleListSortType).state;
  if (sort == SortType.asc) {
    selectArticles?.sort((a, b) => a.publishedAt.compareTo(b.publishedAt));
  } else {
    selectArticles?.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
  }
  return selectArticles;
});

final sortedBookmarkArticles =
    StateProvider.autoDispose.family<List<Article>, ArticleMode>((ref, mode) {
  var articles = ref.watch(allArticles).state;
  articles = articles?.where((article) => article.tags.isNotEmpty)?.toList();
  final _bookmarkList = ref.watch(bookmarkList).state;
  final List<Article> bookmarkArticles = [];
  if (_bookmarkList != null) {
    for (final bookmark in _bookmarkList) {
      for (final article in articles) {
        if (bookmark.id == article.id && bookmark.isBookmark == true) {
          bookmarkArticles.add(article);
        }
      }
    }
  }
  List<Article> selectArticles;
  if (mode.jointMode != null) {
    selectArticles = FilterArticles.getJointModeArticleList(bookmarkArticles, mode.jointMode);
  } else if (mode.symptomDisorder != null) {
    selectArticles =
        FilterArticles.getSymptomDisorderArticleList(bookmarkArticles, mode.symptomDisorder);
  }

  final sort = ref.watch(bookmarkListSortType).state;
  if (sort == SortType.asc) {
    selectArticles?.sort((a, b) => a.publishedAt.compareTo(b.publishedAt));
  } else {
    selectArticles?.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
  }
  return selectArticles;
});

final _subscribes = StateProvider<List<Subscribes>>((ref) => null);

final currentSubscriber = StateProvider.family<int, String>((ref, id) {
  final test = ref.watch(_subscribes).state;
  final result = test?.firstWhere((element) => element.id == id, orElse: () => null)?.count;
  return result ?? 0;
});

final articlesController = Provider((ref) => ArticlesController(read: ref.read));

class ArticlesController {
  ArticlesController({
    this.read,
  });

  final Reader read;
  List<Article> cache;

  Future fetch() async {
    final articles = await read(microCMSRepository).getArticleListContents();
    read(allArticles).state = articles;
    cache = articles;
  }

  void restoreFromeCache() {
    read(allArticles).state = cache;
  }

  Future incrementSubscribers(String id) async {
    await read(firebaseRepository).incrementSubscribers(id);
  }

  Future fetchSubscribers() async {
    read(_subscribes).state = await read(firebaseRepository).getSubscribers();
  }
}
