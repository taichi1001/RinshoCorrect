import 'package:rinsho_collect/entity/article.dart';

class SortArticles {
  static List<Article> fromNewest(List<Article> articles) {
    articles.sort((a, b) => a.publishedAt.compareTo(b.publishedAt));
    return articles;
  }

  static List<Article> fromOldest(List<Article> articles) {
    articles.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
    return articles;
  }
}
