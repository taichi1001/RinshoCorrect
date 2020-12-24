import 'package:rinsho_collect/enum/joint.dart';
import 'package:rinsho_collect/enum/sort_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rinsho_collect/util/filter_articles.dart';
import 'package:rinsho_collect/model/articlestest.dart';

import '../entity/article.dart';

final _sortType = StateProvider((ref) => SortType.asc);
final _jointMode = StateProvider((ref) => JointMode.all);

final sortedArticles = StateProvider.autoDispose<List<Article>>((ref) {
  final articles = ref.watch(globalArticles).state;
  final sortType = ref.watch(_sortType).state;
  final jointMode = ref.watch(_jointMode).state;

  final selectArticles = FilterArticles.getModeArticleList(articles, jointMode);

  if (sortType == SortType.asc) {
    selectArticles?.sort((a, b) => a.publishedAt.compareTo(b.publishedAt));
  } else {
    selectArticles?.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
  }
  return selectArticles;
});

final articleViewController =
    Provider((ref) => ArticlesViewController(read: ref.read));

class ArticlesViewController {
  ArticlesViewController({
    this.read,
  });

  final Reader read;

  void changeSortType() {
    final SortType sortType = read(_sortType).state;
    read(_sortType).state =
        sortType == SortType.asc ? SortType.desc : SortType.asc;
  }

  void changeJointMode(JointMode mode) {
    read(_jointMode).state = mode;
  }
}
