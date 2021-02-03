import 'package:rinsho_collect/enum/display_mode.dart';
import 'package:rinsho_collect/enum/joint.dart';
import 'package:rinsho_collect/enum/sort_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rinsho_collect/entity/article.dart';
import 'package:rinsho_collect/entity/bookmark.dart';
import 'package:rinsho_collect/enum/symptom_disorder.dart';
import 'package:rinsho_collect/repository/firebase_repository.dart';
import 'package:rinsho_collect/util/filter_articles.dart';
import 'package:rinsho_collect/model/articles_controller.dart';

final sortType = StateProvider((ref) => SortType.asc);

final displayMode = StateProvider((ref) => DisplayMode.joint);

final sortedBookmarkJointArticles =
    StateProvider.autoDispose.family<List<Article>, JointMode>((ref, mode) {
  var articles = ref.watch(globalArticles).state;
  articles = articles?.where((article) => article.tags.isNotEmpty)?.toList();
  final bookmarkList = ref.watch(_bookmarkList).state;
  final List<Article> bookmarkArticles = [];
  if (bookmarkList != null) {
    for (final bookmark in bookmarkList) {
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
  final bookmarkList = ref.watch(_bookmarkList).state;
  final List<Article> bookmarkArticles = [];
  if (bookmarkList != null) {
    for (final bookmark in bookmarkList) {
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

final _bookmarkList = StateProvider<List<Bookmark>>((ref) => null);

final currentBookmark = StateProvider.family<bool, String>((ref, id) {
  final bookmarkList = ref.watch(_bookmarkList).state;
  final result =
      bookmarkList?.firstWhere((bookmark) => bookmark.id == id, orElse: () => null)?.isBookmark;
  return result ?? false;
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

  Future fetchBookmarkList() async {
    read(_bookmarkList).state = await read(firebaseRepository).getBookmarkList();
  }

  void changeIsBookmark(String id) {
    final bookmarkList = read(_bookmarkList).state;
    final target = bookmarkList.firstWhere((bookmark) => bookmark.id == id, orElse: () => null);
    if (bookmarkList.isEmpty || target == null) {
      _addNewBookmark(id, true, bookmarkList);
      return;
    }
    final updateBookmark = target.isBookmark
        ? Bookmark(id: id, isBookmark: false)
        : Bookmark(id: id, isBookmark: true);
    final targetIndex = bookmarkList.indexWhere((bookmark) => bookmark.id == id);
    bookmarkList[targetIndex] = updateBookmark;
    read(_bookmarkList).state = bookmarkList;
    read(firebaseRepository).changeIsBookmark(updateBookmark);
  }

  void _addNewBookmark(String id, bool isBookmark, List<Bookmark> list) {
    final updateBookmark = Bookmark(id: id, isBookmark: isBookmark);
    list.add(updateBookmark);
    read(_bookmarkList).state = list;
    read(firebaseRepository).changeIsBookmark(updateBookmark);
  }
}
