import 'package:http/http.dart' as http;
import 'package:hooks_riverpod/hooks_riverpod.dart';

final microCMSClient = Provider.autoDispose((ref) => MicroCMSClient());

class MicroCMSClient {
  /// 記事全ての要素を取得
  Future getArticleList() => http.get(
        'https://rinshotest.microcms.io/api/v1/article',
        headers: {'X-API-KEY': '3b36eb63-bfa1-493e-91be-64543308ba3c'},
      );

  ///　記事リストに必要な要素だけを取得
  Future getArticlesListContents() => http.get(
        'https://rinshotest.microcms.io/api/v1/article?limit=200&fields=id,publishedAt,eyecatch,tag,symptom_disorder,title,author',
        headers: {'X-API-KEY': '3b36eb63-bfa1-493e-91be-64543308ba3c'},
      );

  /// 検索ワードを含む要素取得
  Future searchArticlesListContents(String word) => http.get(
        'https://rinshotest.microcms.io/api/v1/article?limit=200&fields=id,publishedAt,eyecatch,tag,symptom_disorder,title&q=$word',
        headers: {'X-API-KEY': '3b36eb63-bfa1-493e-91be-64543308ba3c'},
      );

  /// IDで指定された記事の要素をすべて取得
  Future getArticleContents(String id) => http.get(
        'https://rinshotest.microcms.io/api/v1/article/$id',
        headers: {'X-API-KEY': '3b36eb63-bfa1-493e-91be-64543308ba3c'},
      );

  Future getGlossary() => http.get(
        'https://rinshotest.microcms.io/api/v1/glossary',
        headers: {'X-API-KEY': '3b36eb63-bfa1-493e-91be-64543308ba3c'},
      );
}
