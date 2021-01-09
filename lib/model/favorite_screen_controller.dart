import 'package:rinsho_collect/enum/display_mode.dart';
import 'package:rinsho_collect/enum/joint.dart';
import 'package:rinsho_collect/enum/sort_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rinsho_collect/entity/article.dart';
import 'package:rinsho_collect/enum/symptom_disorder.dart';
import 'package:rinsho_collect/repository/firebase_repository.dart';
import 'package:rinsho_collect/util/filter_articles.dart';
import 'package:rinsho_collect/model/articles_controller.dart';

final sortType = StateProvider((ref) => SortType.asc);

final displayMode = StateProvider((ref) => DisplayMode.joint);

final sortedFavoriteJointArticles =
    StateProvider.autoDispose.family<List<Article>, JointMode>((ref, mode) {
  var articles = ref.watch(globalArticles).state;
  articles = articles?.where((article) => article.tags.isNotEmpty)?.toList();
  final favoriteList = ref.watch(_favoriteList).state;
  final List<Article> favoriteArticles = [];
  if (favoriteList != null) {
    for (final favorite in favoriteList) {
      for (final article in articles) {
        if (favorite.id == article.id && favorite.isFavorite == true) {
          favoriteArticles.add(article);
        }
      }
    }
  }
  final selectArticles = FilterArticles.getJointModeArticleList(favoriteArticles, mode);
  final sort = ref.watch(sortType).state;

  if (sort == SortType.asc) {
    selectArticles?.sort((a, b) => a.publishedAt.compareTo(b.publishedAt));
  } else {
    selectArticles?.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
  }
  return selectArticles;
});

final sortedFavoriteSymptomDisorderArticles =
    StateProvider.autoDispose.family<List<Article>, SymptomDisorder>((ref, mode) {
  var articles = ref.watch(globalArticles).state;
  articles = articles?.where((article) => article.symptomDisorder.isNotEmpty)?.toList();
  final favoriteList = ref.watch(_favoriteList).state;
  final List<Article> favoriteArticles = [];
  if (favoriteList != null) {
    for (final favorite in favoriteList) {
      for (final article in articles) {
        if (favorite.id == article.id && favorite.isFavorite == true) {
          favoriteArticles.add(article);
        }
      }
    }
  }
  final selectArticles = FilterArticles.getSymptomDisorderArticleList(favoriteArticles, mode);
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

final _favoriteList = StateProvider<List<Favorite>>((ref) => null);

final currentFavorite = StateProvider.family<bool, String>((ref, id) {
  final favoriteList = ref.watch(_favoriteList).state;
  final result =
      favoriteList?.firstWhere((favorite) => favorite.id == id, orElse: () => null)?.isFavorite;
  return result ?? false;
});

final favoriteScreenController =
    Provider.autoDispose((ref) => FavoriteScreenController(read: ref.read));

class FavoriteScreenController {
  FavoriteScreenController({
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

  Future fetchFavoriteList() async {
    read(_favoriteList).state = await read(firebaseRepository).getFavoriteList();
  }

  void changeIsFavorite(String id) {
    final favoriteList = read(_favoriteList).state;
    final target = favoriteList.firstWhere((favorite) => favorite.id == id, orElse: () => null);
    if (favoriteList.isEmpty || target == null) {
      _addNewFavorite(id, true, favoriteList);
      return;
    }
    final updateFavorite = target.isFavorite
        ? Favorite(id: id, isFavorite: false)
        : Favorite(id: id, isFavorite: true);
    final targetIndex = favoriteList.indexWhere((favorite) => favorite.id == id);
    favoriteList[targetIndex] = updateFavorite;
    read(_favoriteList).state = favoriteList;
    read(firebaseRepository).changeIsFavorite(updateFavorite);
  }

  void _addNewFavorite(String id, bool isFavorite, List<Favorite> list) {
    final updateFavorite = Favorite(id: id, isFavorite: isFavorite);
    list.add(updateFavorite);
    read(_favoriteList).state = list;
    read(firebaseRepository).changeIsFavorite(updateFavorite);
  }
}
