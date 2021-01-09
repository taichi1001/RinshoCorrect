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

  Future fetch() async {
    read(globalArticles).state = await read(microCMSRepository).getArticles();
  }
}
