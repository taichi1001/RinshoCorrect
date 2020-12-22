import 'package:rinsho_collect/entity/article.dart';
import 'package:rinsho_collect/repository/article_repository.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum SortOrder {
  ASC,
  DESC,
}

final _sortOrder = StateProvider.autoDispose((ref) => SortOrder.ASC);
final _articles = StateProvider.autoDispose<List<Article>>((ref) => null);

final sortedArticles = StateProvider.autoDispose((ref) {
  final List<Article> articles = ref.watch(_articles).state;
  final sortOrder = ref.watch(_sortOrder).state;

  if (sortOrder == SortOrder.ASC) {
    articles?.sort((a, b) => a.publishedAt.compareTo(b.publishedAt));
  } else {
    articles?.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
  }
  return articles;
});

final articleViewController = Provider.autoDispose((ref) => ArticlesViewController(ref.read));

class ArticlesViewController {
  final Reader read;
  ArticlesViewController(this.read);

  void initState() async {
    read(_articles).state = await read(articleRepository).getArticles();
  }

  void changeSortOrder() {
    final SortOrder sortOrder = read(_sortOrder).state;
    read(_sortOrder).state = sortOrder == SortOrder.ASC ? SortOrder.DESC : SortOrder.ASC;
  }
}
