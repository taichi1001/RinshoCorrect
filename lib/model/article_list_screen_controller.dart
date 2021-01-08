import 'package:rinsho_collect/enum/display_mode.dart';
import 'package:rinsho_collect/enum/joint.dart';
import 'package:rinsho_collect/enum/sort_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rinsho_collect/entity/article.dart';
import 'package:rinsho_collect/enum/symptom_disorder.dart';
import 'package:rinsho_collect/repository/subcribers_repository.dart';
import 'package:rinsho_collect/util/filter_articles.dart';
import 'package:rinsho_collect/model/articles_controller.dart';

final sortType = StateProvider((ref) => SortType.asc);

final displayMode = StateProvider((ref) => DisplayMode.joint);

final sortedJointArticles = StateProvider.autoDispose.family<List<Article>, JointMode>((ref, mode) {
  var articles = ref.watch(globalArticles).state;
  articles = articles?.where((article) => article.tags.isNotEmpty)?.toList();
  final selectArticles = FilterArticles.getJointModeArticleList(articles, mode);
  final sort = ref.watch(sortType).state;

  if (sort == SortType.asc) {
    selectArticles?.sort((a, b) => a.publishedAt.compareTo(b.publishedAt));
  } else {
    selectArticles?.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
  }
  return selectArticles;
});

final sortedSymptomDisorderArticles =
    StateProvider.autoDispose.family<List<Article>, SymptomDisorder>((ref, mode) {
  var articles = ref.watch(globalArticles).state;
  articles = articles?.where((article) => article.symptomDisorder.isNotEmpty)?.toList();
  final selectArticles = FilterArticles.getSymptomDisorderArticleList(articles, mode);
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

final articleListScreenController =
    Provider.autoDispose((ref) => ArticleListScreenController(read: ref.read));

class ArticleListScreenController {
  ArticleListScreenController({
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
    await read(subscribersRepository).incrementSubscribers(id);
  }

  Future fetchSubscribers() async {
    read(_test).state = await read(subscribersRepository).getSubscribers();
  }

  Future fetchFavoriteList() async {
    read(_favoriteList).state = await read(subscribersRepository).getFavoriteList();
  }

  void changeIsFavorite(String id) {
    Favorite updateFavorite;
    print('a');
    read(_favoriteList).state = read(_favoriteList).state.map((favorite) {
      if (favorite.id == id) {
        if (favorite.isFavorite) {
          return updateFavorite = Favorite(id: id, isFavorite: false);
        } else {
          return updateFavorite = Favorite(id: id, isFavorite: true);
        }
      } else {
        return updateFavorite = Favorite(id: id, isFavorite: true);
      }
    }).toList();
    read(subscribersRepository).changeIsFavorite(updateFavorite);
  }
}
