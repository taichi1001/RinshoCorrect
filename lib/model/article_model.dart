import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rinsho_collect/entity/article.dart';

class ArticleModel with ChangeNotifier {
  final List<Article> _articleList = [];
  List<Article> get articleList => _articleList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  ArticleModel() {
    _init();
  }

  Future _init() async {
    await fetchAllArticle();
  }

  Future fetchAllArticle() async {
    _isLoaded = false;
    final result = await http.get(
      'https://rinshotest.microcms.io/api/v1/article',
      headers: {'X-API-KEY': '3b36eb63-bfa1-493e-91be-64543308ba3c'},
    );
    final List contents = jsonDecode(result.body)['contents'];
    _articleList.clear();
    _articleList.addAll(contents.map((content) => Article.fromJSON(content)));
    _isLoaded = true;
    notifyListeners();
  }
}
