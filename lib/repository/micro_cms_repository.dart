import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:rinsho_collect/client/micro_cms.dart';
import 'package:rinsho_collect/entity/article.dart';
import 'package:rinsho_collect/entity/term.dart';

final microCMSRepository =
    Provider.autoDispose<MicroCMSRepository>((ref) => MicroCMSRepositoryImpl(ref.read));

abstract class MicroCMSRepository {
  Future<List<Article>> getArticleListContents();
  Future<Article> getArticleContents(String id);
  Future<List<Term>> getGlossary();
}

class MicroCMSRepositoryImpl implements MicroCMSRepository {
  final Reader read;
  MicroCMSRepositoryImpl(this.read);

  @override
  Future<List<Article>> getArticleListContents() async {
    final MicroCMSClient prefs = read(microCMSClient);
    final Response result = await prefs.getArticlesListContents() ?? [];
    final List contents = jsonDecode(result.body)['contents'];
    return contents.map((json) => Article.fromJson(json)).toList();
  }

  @override
  Future<Article> getArticleContents(String id) async {
    final MicroCMSClient prefs = read(microCMSClient);
    final Response result = await prefs.getArticleContents(id);
    final contents = jsonDecode(result.body);
    return Article.fromJson(contents);
  }

  @override
  Future<List<Term>> getGlossary() async {
    final MicroCMSClient prefs = read(microCMSClient);
    final Response result = await prefs.getGlossary() ?? [];
    final List contents = jsonDecode(result.body)['contents'];
    return contents.map((json) => Term.fromJson(json)).toList();
  }
}
