import 'package:rinsho_collect/enum/joint.dart';
import 'package:rinsho_collect/enum/sort_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rinsho_collect/entity/article.dart';
import 'package:rinsho_collect/enum/symptom_disorder.dart';
import 'package:rinsho_collect/util/filter_articles.dart';
import 'package:rinsho_collect/model/articles_controller.dart';

final sortType = StateProvider((ref) => SortType.asc);

final displayMode = StateProvider((ref) => true);

final sortedJointArticles = StateProvider.autoDispose.family<List<Article>, JointMode>((ref, mode) {
  final articles = ref.watch(globalArticles).state;
  final sort = ref.watch(sortType).state;
  final selectArticles = FilterArticles.getJointModeArticleList(articles, mode);

  if (sort == SortType.asc) {
    selectArticles?.sort((a, b) => a.publishedAt.compareTo(b.publishedAt));
  } else {
    selectArticles?.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
  }
  return selectArticles;
});

final sortedSymptomDisorderArticles =
    StateProvider.autoDispose.family<List<Article>, SymptomDisorder>((ref, mode) {
  final articles = ref.watch(globalArticles).state;
  final sort = ref.watch(sortType).state;
  final selectArticles = FilterArticles.getSymptomDisorderArticleList(articles, mode);

  if (sort == SortType.asc) {
    selectArticles?.sort((a, b) => a.publishedAt.compareTo(b.publishedAt));
  } else {
    selectArticles?.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
  }
  return selectArticles;
});

final jointScreenController = Provider.autoDispose((ref) => JointScreenController(read: ref.read));

class Test2 {
  bool displayMode = true;
  SortType sortType = SortType.asc;
}

final testProvider = StateNotifierProvider((ref) => Test());

class Test extends StateNotifier<Test2> {
  Test() : super(Test2());

  void changeSortType() {
    state.sortType = state.sortType == SortType.asc ? SortType.desc : SortType.asc;
  }

  void changeDisplayMode() {
    state.displayMode = state.displayMode == true ? false : true;
  }
}

class JointScreenController {
  JointScreenController({
    this.read,
  });

  final Reader read;

  void changeSortType() {
    final sort = read(sortType).state;
    read(sortType).state = sort == SortType.asc ? SortType.desc : SortType.asc;
  }

  void changeDisplayMode() {
    final mode = read(displayMode).state;
    read(displayMode).state = mode == true ? false : true;
  }
}
