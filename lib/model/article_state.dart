import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rinsho_collect/entity/article.dart';
import 'package:rinsho_collect/enum/sort_type.dart';

part 'article_state.freezed.dart';

@freezed
abstract class ArticleState implements _$ArticleState {
  factory ArticleState({
    @Default(null) List<Article> articles,
    @Default(SortType.asc) SortType sort,
  }) = _ArticleState;

  ArticleState._();

  @late
  List<Article> get sortedArticles => _sort();

  List<Article> _sort() {
    final sortedArticles = articles;
    if (sort == SortType.asc) {
      sortedArticles?.sort((a, b) => a.publishedAt.compareTo(b.publishedAt));
    } else {
      sortedArticles?.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
    }
    return sortedArticles;
  }
}
