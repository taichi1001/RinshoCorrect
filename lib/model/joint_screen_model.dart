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

  final List<Article> _articleList = global.article.getArticleList(JointMode.all);

  List<Article> _showArticleList;

  SortType sortType = SortType.asc;

  List<Article> get showArticleList => _showArticleList;

  void fetch() => global.article.fetchAllArticle();

  void makeShowArticleList({
    // SortType sort = SortType.fromNewest,
    FilterType filter = FilterType.all,
    List<String> words,
  }) {
    if (sortType == SortType.asc) {
      sortType = SortType.asc;
    } else if (sortType == SortType.desc) {
      sortType = SortType.desc;
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
      case SortType.asc:
        _showArticleList = SortArticles.fromNewest(_showArticleList);
        break;
      case SortType.desc:
        _showArticleList = SortArticles.fromOldest(_showArticleList);
        break;
      default:
        break;
    }
  }
}
