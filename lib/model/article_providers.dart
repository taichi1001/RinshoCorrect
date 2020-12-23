import 'package:rinsho_collect/enum/sort_type.dart';
import 'package:rinsho_collect/repository/article_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../entity/article.dart';

final _sortType = StateProvider.autoDispose((ref) => SortType.asc);
final _articles = StateProvider.autoDispose<List<Article>>((ref) => null);

final sortedArticles = StateProvider.autoDispose<List<Article>>((ref) {
  final List<Article> articles = ref.watch(_articles).state;
  final sortOrder = ref.watch(_sortType).state;

  if (sortOrder == SortType.asc) {
    articles?.sort((a, b) => a.publishedAt.compareTo(b.publishedAt));
  } else {
    articles?.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
  }
  return articles;
});

final articleViewController =
    Provider.autoDispose((ref) => ArticlesViewController(read: ref.read));

class ArticlesViewController {
  ArticlesViewController({
    this.read,
  });

  final Reader read;

  Future initState() async {
    read(_articles).state = await read(articleRepository).getArticles();
  }

  void changeSortType() {
    final SortType sortType = read(_sortType).state;
    read(_sortType).state =
        sortType == SortType.asc ? SortType.desc : SortType.asc;
  }
}
