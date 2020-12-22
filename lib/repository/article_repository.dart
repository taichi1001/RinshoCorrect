import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rinsho_collect/client/micro_cms.dart';
import 'package:rinsho_collect/entity/article.dart';

final articleRepository =
    Provider.autoDispose<ArticleRepository>((ref) => ArticleRepositoryImpl(ref.read));

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
    final List<Map<String, dynamic>> todosJsons = await prefs.getJsonList() ?? [];

    return todosJsons.map((json) => Article.fromJson(json)).toList();
  }

  @override
  Future<void> saveTodos(List<Article> todos) async {}
}
