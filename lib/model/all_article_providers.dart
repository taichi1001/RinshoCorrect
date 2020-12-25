import 'package:rinsho_collect/enum/joint.dart';
import 'package:rinsho_collect/enum/sort_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rinsho_collect/util/filter_articles.dart';
import 'package:rinsho_collect/model/articles_controller.dart';

import '../entity/article.dart';
import '../enum/joint.dart';

final sortType = StateProvider((ref) => SortType.asc);

final sortedArticles =
    StateProvider.autoDispose.family<List<Article>, JointMode>((ref, mode) {
  final articles = ref.watch(globalArticles).state;
  final sort = ref.watch(sortType).state;
  final selectArticles = FilterArticles.getModeArticleList(articles, mode);

  if (sort == SortType.asc) {
    selectArticles?.sort((a, b) => a.publishedAt.compareTo(b.publishedAt));
  } else {
    selectArticles?.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
  }
  return selectArticles;
});

final jointScreenController =
    Provider.autoDispose((ref) => JointScreenController(read: ref.read));

class JointScreenController {
  JointScreenController({
    this.read,
  });

  final Reader read;

  void changeSortType() {
    final SortType sort = read(sortType).state;
    read(sortType).state = sort == SortType.asc ? SortType.desc : SortType.asc;
  }
}
