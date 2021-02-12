import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rinsho_collect/repository/micro_cms_repository.dart';
import '../entity/article.dart';

final globalArticles = StateProvider<List<Article>>((ref) => null);

final articlesController = Provider((ref) => ArticlesController(read: ref.read));

class ArticlesController {
  ArticlesController({
    this.read,
  });

  final Reader read;
  List<Article> cache;

  Future fetch() async {
    final articles = await read(microCMSRepository).getArticleListContents();
    read(globalArticles).state = articles;
    cache = articles;
  }

  void restoreFromeCache() {
    read(globalArticles).state = cache;
  }
}
