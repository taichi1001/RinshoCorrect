import 'package:rinsho_collect/enum/display_mode.dart';
import 'package:rinsho_collect/enum/joint.dart';
import 'package:rinsho_collect/enum/sort_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rinsho_collect/entity/article.dart';
import 'package:rinsho_collect/enum/symptom_disorder.dart';
import 'package:rinsho_collect/model/bookmark_controller.dart';
import 'package:rinsho_collect/repository/firebase_repository.dart';
import 'package:rinsho_collect/util/filter_articles.dart';
import 'package:rinsho_collect/model/articles_controller.dart';

final sortType = StateProvider((ref) => SortType.asc);

final displayMode = StateProvider((ref) => DisplayMode.joint);

final sortedBookmarkJointArticles =
    StateProvider.autoDispose.family<List<Article>, JointMode>((ref, mode) {
  var articles = ref.watch(globalArticles).state;
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
  final selectArticles = FilterArticles.getJointModeArticleList(bookmarkArticles, mode);
  final sort = ref.watch(sortType).state;

  if (sort == SortType.asc) {
    selectArticles?.sort((a, b) => a.publishedAt.compareTo(b.publishedAt));
  } else {
    selectArticles?.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
  }
  return selectArticles;
});

final sortedBookmarkSymptomDisorderArticles =
    StateProvider.autoDispose.family<List<Article>, SymptomDisorder>((ref, mode) {
  var articles = ref.watch(globalArticles).state;
  articles = articles?.where((article) => article.symptomDisorder.isNotEmpty)?.toList();
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
  final selectArticles = FilterArticles.getSymptomDisorderArticleList(bookmarkArticles, mode);
  final sort = ref.watch(sortType).state;

  if (sort == SortType.asc) {
    selectArticles?.sort((a, b) => a.publishedAt.compareTo(b.publishedAt));
  } else {
    selectArticles?.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
  }
  return selectArticles;
});

final _test = StateProvider<List<Subscribes>>((ref) => null);

final currentTest = StateProvider.family<int, String>((ref, id) {
  final test = ref.watch(_test).state;
  final result = test?.firstWhere((element) => element.id == id, orElse: () => null)?.count;
  return result ?? 0;
});

final bookmarkScreenController =
    Provider.autoDispose((ref) => BookmarkScreenController(read: ref.read));

class BookmarkScreenController {
  BookmarkScreenController({
    this.read,
  });

  final Reader read;

  void changeSortType() {
    final sort = read(sortType).state;
    read(sortType).state = sort == SortType.asc ? SortType.desc : SortType.asc;
  }

  void changeDisplayMode() {
    final mode = read(displayMode).state;
    read(displayMode).state =
        mode == DisplayMode.joint ? DisplayMode.symptomDisorder : DisplayMode.joint;
  }

  Future incrementSubscribers(String id) async {
    await read(firebaseRepository).incrementSubscribers(id);
  }

  Future fetchSubscribers() async {
    read(_test).state = await read(firebaseRepository).getSubscribers();
  }
}
