import 'package:rinsho_collect/enum/sort_type.dart';
import 'package:rinsho_collect/model/article_state.dart';
import 'package:rinsho_collect/repository/article_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// enum SortOrder {
//   ASC,
//   DESC,
// }

// final _sortOrder = StateProvider.autoDispose((ref) => SortOrder.ASC);
// final _articles = StateProvider.autoDispose<List<Article>>((ref) => null);

// final sortedArticles = StateProvider.autoDispose((ref) {
//   final List<Article> articles = ref.watch(_articles).state;
//   final sortOrder = ref.watch(_sortOrder).state;

//   if (sortOrder == SortOrder.ASC) {
//     articles?.sort((a, b) => a.publishedAt.compareTo(b.publishedAt));
//   } else {
//     articles?.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
//   }
//   return articles;
// });

final articleViewController =
    StateNotifierProvider.autoDispose((ref) => ArticlesViewController(read: ref.read));

class ArticlesViewController extends StateNotifier<ArticleState> {
  ArticlesViewController({
    this.read,
  }) : super(ArticleState());

  final Reader read;

  Future initState() async {
    state.copyWith(articles: await read(articleRepository).getArticles());
  }

  void changeSortOrder() {
    final sort = state.sort == SortType.asc ? SortType.desc : SortType.asc;
    state.copyWith(sort: sort);
  }
}
