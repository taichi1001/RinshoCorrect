import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pedantic/pedantic.dart';
import 'package:rinsho_collect/enum/display_mode.dart';
import 'package:rinsho_collect/enum/joint.dart';
import 'package:rinsho_collect/enum/sort_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rinsho_collect/entity/article.dart';
import 'package:rinsho_collect/enum/symptom_disorder.dart';
import 'package:rinsho_collect/util/filter_articles.dart';
import 'package:rinsho_collect/model/articles_controller.dart';

final sortType = StateProvider((ref) => SortType.asc);

final displayMode = StateProvider((ref) => DisplayMode.joint);

final sortedJointArticles = StateProvider.autoDispose.family<List<Article>, JointMode>((ref, mode) {
  var articles = ref.watch(globalArticles).state;
  articles = articles?.where((article) => article.tags.isNotEmpty)?.toList();
  final selectArticles = FilterArticles.getJointModeArticleList(articles, mode);
  final sort = ref.watch(sortType).state;

  if (sort == SortType.asc) {
    selectArticles?.sort((a, b) => a.publishedAt.compareTo(b.publishedAt));
  } else {
    selectArticles?.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
  }
  return selectArticles;
});

final sortedSymptomDisorderArticles =
    StateProvider.autoDispose.family<List<Article>, SymptomDisorder>((ref, mode) {
  var articles = ref.watch(globalArticles).state;
  articles = articles?.where((article) => article.symptomDisorder.isNotEmpty)?.toList();
  final selectArticles = FilterArticles.getSymptomDisorderArticleList(articles, mode);
  final sort = ref.watch(sortType).state;

  if (sort == SortType.asc) {
    selectArticles?.sort((a, b) => a.publishedAt.compareTo(b.publishedAt));
  } else {
    selectArticles?.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
  }
  return selectArticles;
});

final articleListScreenController =
    Provider.autoDispose((ref) => ArticleListScreenController(read: ref.read));

class ArticleListScreenController {
  ArticleListScreenController({
    this.read,
  });

  final Reader read;

  void changeSortType() {
    final sort = read(sortType).state;
    read(sortType).state = sort == SortType.asc ? SortType.desc : SortType.asc;
  }

  void changeDisplayMode() {
    final mode = read(displayMode).state;
    read(displayMode).state =
        mode == DisplayMode.joint ? DisplayMode.symptomDisorder : DisplayMode.joint;
  }

  Future incrementSubscribers(String id) async {
    // final user = FirebaseAuth.instance.currentUser;
    final subscriber = await FirebaseFirestore.instance.collection('articles').doc(id).get();
    if (subscriber.data() == null) {
      unawaited(
        FirebaseFirestore.instance.collection('articles').doc(id).set({'subscriber': 1}),
      );
    } else {
      unawaited(
        FirebaseFirestore.instance
            .collection('articles')
            .doc(id)
            .update({'subscriber': FieldValue.increment(1)}),
      );
    }
  }
}
