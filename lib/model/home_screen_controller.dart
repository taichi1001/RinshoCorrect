import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rinsho_collect/repository/micro_cms_repository.dart';
import 'package:rinsho_collect/entity/article.dart';
import 'package:rinsho_collect/model/articles_controller.dart';

final allViewsRankingArticles = StateProvider<List<Article>>((ref) {
  final articles = ref.watch(allArticles).state;
  if (articles != null) {
    articles.sort((b, a) => a.subscriber.compareTo(b.subscriber));
    if (articles.length > 10) {
      articles.removeRange(10, articles.length);
    }
    return articles;
  }
  return [];
});

final recommendedArticles = StateProvider<List<Article>>((ref) {
  final articles = ref.watch(allArticles).state;
  final recommendedArticles = articles?.where((article) => article.recommended)?.toList();
  return recommendedArticles;
});

final noticeArticles = StateProvider<List<Article>>((ref) {
  final articles = ref.watch(allArticles).state;
  return articles?.where((article) => article.notice)?.toList();
});

final newArticles = StateProvider<List<Article>>((ref) {
  final articles = ref.watch(allArticles).state;
  final today = DateTime.now();
  final newScope = DateTime(today.year, today.month - 1, today.day);
  final newArticles =
      articles?.where((article) => article.publishedAt.compareTo(newScope) != -1)?.toList();
  if (newArticles.length > 10) {
    newArticles.removeRange(10, newArticles.length);
  }
  return newArticles;
});

final popularArticles = StateProvider<List<Article>>((ref) {
  final articles = ref.watch(allArticles).state;
  if (articles != null) {
    final today = DateTime.now();
    articles.sort((b, a) {
      final aElapsedDays = today.difference(a.publishedAt).inDays + 1;
      final bElapsedDays = today.difference(b.publishedAt).inDays + 1;
      return (a.subscriber / aElapsedDays).compareTo(b.subscriber / bElapsedDays);
    });
    if (articles.length > 10) {
      articles.removeRange(10, articles.length);
    }
    return articles;
  }
  return [];
});

final homeScreenController = Provider((ref) => HomeScreenController(read: ref.read));

class HomeScreenController {
  HomeScreenController({
    this.read,
  });

  final Reader read;
  List<Article> cache;

  Future fetch() async {
    final articles = await read(microCMSRepository).getArticleListContents();
    read(allArticles).state = articles;
    cache = articles;
  }
}
