import 'package:rinsho_collect/entity/article.dart';
import 'package:rinsho_collect/enum/joint.dart';
import 'package:rinsho_collect/enum/symptom_disorder.dart';

class FilterArticles {
  static List<Article> fromNewest(List<Article> articles) {
    articles.sort((a, b) => a.publishedAt.compareTo(b.publishedAt));
    return articles;
  }

  static List<Article> fromOldest(List<Article> articles) {
    articles.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
    return articles;
  }

  static List<Article> getJointModeArticleList(List<Article> articles, JointMode mode) {
    if (articles == null) {
      return null;
    } else if (mode == JointMode.all) {
      return articles;
    } else {
      final List<Article> result = [];
      for (final article in articles) {
        for (final tag in article.tags) {
          if (tag == mode.typeName) {
            result.add(article);
          }
        }
      }
      return result;
    }
  }

  static List<Article> getSymptomDisorderArticleList(List<Article> articles, SymptomDisorder mode) {
    if (articles == null) {
      return null;
    } else if (mode == SymptomDisorder.all) {
      return articles;
    } else {
      final List<Article> result = [];
      for (final article in articles) {
        for (final symptomDisorder in article.symptomDisorder) {
          if (symptomDisorder == mode.typeName) {
            result.add(article);
          }
        }
      }
      return result;
    }
  }
}
