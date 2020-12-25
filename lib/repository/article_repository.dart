import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:rinsho_collect/client/micro_cms.dart';
import 'package:rinsho_collect/entity/article.dart';

final articleRepository = Provider.autoDispose<ArticleRepository>(
    (ref) => ArticleRepositoryImpl(ref.read));

abstract class ArticleRepository {
  Future<List<Article>> getArticles();
  Future<void> saveTodos(List<Article> articles);
}

class ArticleRepositoryImpl implements ArticleRepository {
  final Reader read;
  ArticleRepositoryImpl(this.read);

  @override
  Future<List<Article>> getArticles() async {
    final MicroCMSClient prefs = read(microCMSClient);
    final Response result = await prefs.getJsonList() ?? [];
    final List contents = jsonDecode(result.body)['contents'];
    return contents.map((json) => Article.fromJson(json)).toList();
  }

  @override
  Future<void> saveTodos(List<Article> todos) async {}
}
