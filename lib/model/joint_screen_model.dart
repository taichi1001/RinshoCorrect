import 'package:flutter/material.dart';
import 'package:rinsho_collect/entity/article.dart';
import 'package:rinsho_collect/enum/filter_type.dart';
import 'package:rinsho_collect/enum/sort_type.dart';
import 'package:rinsho_collect/enum/joint.dart';
import 'package:rinsho_collect/global.dart' as global;
import 'package:rinsho_collect/model/sort_articles.dart';

class JointScreenModel with ChangeNotifier {
  JointScreenModel() {
    makeShowArticleList();
  }

  final List<Article> _articleList =
      global.article.getArticleList(JointMode.all);

  List<Article> _showArticleList;

  SortType sortType = SortType.fromNewest;

  List<Article> get showArticleList => _showArticleList;

  void fetch() => global.article.fetchAllArticle();

  void makeShowArticleList({
    // SortType sort = SortType.fromNewest,
    FilterType filter = FilterType.all,
    List<String> words,
  }) {
    if (sortType == SortType.fromNewest) {
      sortType = SortType.fromOldest;
    } else if (sortType == SortType.fromOldest) {
      sortType = SortType.fromNewest;
    }
    final sort = sortType;
    _showArticleList = [..._articleList];
    _filterArticleList(filter, words);
    _sortArticleList(sort);
    notifyListeners();
  }

  void _filterArticleList(FilterType filter, List<String> words) {
    switch (filter) {
      case FilterType.all:
        break;
      case FilterType.tag:
        break;
      case FilterType.word:
        break;
      default:
        break;
    }
  }

  void _sortArticleList(SortType sort) {
    switch (sort) {
      case SortType.fromNewest:
        _showArticleList = SortArticles.fromNewest(_showArticleList);
        break;
      case SortType.fromOldest:
        _showArticleList = SortArticles.fromOldest(_showArticleList);
        break;
      default:
        break;
    }
  }
}
