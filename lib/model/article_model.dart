import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rinsho_collect/entity/article.dart';

class ArticleModel with ChangeNotifier {
  List<Article> articleList = [];
  bool isLoaded = false;

  ArticleModel() {
    _fetchAll();
  }

  Future _fetchAll() async {
    isLoaded = false;
    final result = await http.get(
      'https://rinshotest.microcms.io/api/v1/article',
      headers: {'X-API-KEY': '3b36eb63-bfa1-493e-91be-64543308ba3c'},
    );
    final List contents = jsonDecode(result.body)['contents'];
    articleList.clear();
    articleList.addAll(contents.map((content) => Article.fromJSON(content)));
    isLoaded = true;
    notifyListeners();
  }
}
