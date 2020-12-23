import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rinsho_collect/entity/article.dart';
import 'package:rinsho_collect/enum/sort_type.dart';

part 'article_state.freezed.dart';

@freezed
abstract class ArticleState implements _$ArticleState {
  factory ArticleState({
    @Default(<Article>[]) List<Article> articles,
    @Default(<Article>[]) List<Article> sorted,
    @Default(SortType.asc) SortType sort,
  }) = _ArticleState;

  ArticleState._();

  @late
  List<Article> get sortedArticles => articles;
}
