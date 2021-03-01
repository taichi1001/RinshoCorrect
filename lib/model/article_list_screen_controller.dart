import 'package:flutter/cupertino.dart';
import 'package:rinsho_collect/enum/display_mode.dart';
import 'package:rinsho_collect/enum/sort_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rinsho_collect/repository/firebase_repository.dart';
import 'package:rinsho_collect/repository/micro_cms_repository.dart';
import 'package:rinsho_collect/model/articles_controller.dart';

final articleListSortType = StateProvider((ref) => SortType.asc);

final articleListDisplayMode = StateProvider((ref) => DisplayMode.joint);

final textEditingController =
    StateProvider.autoDispose<TextEditingController>((ref) => TextEditingController());

final articleListScreenController =
    Provider.autoDispose((ref) => ArticleListScreenController(read: ref.read));

class ArticleListScreenController {
  ArticleListScreenController({
    this.read,
  });

  final Reader read;

  void textClear() {
    read(textEditingController).state.clear();
  }

  void changeSortType() {
    final sort = read(articleListSortType).state;
    read(articleListSortType).state = sort == SortType.asc ? SortType.desc : SortType.asc;
  }

  void changeDisplayMode() {
    final mode = read(articleListDisplayMode).state;
    read(articleListDisplayMode).state =
        mode == DisplayMode.joint ? DisplayMode.symptomDisorder : DisplayMode.joint;
  }

  Future incrementSubscribers(String id) async {
    await read(firebaseRepository).incrementSubscribers(id);
    await read(firebaseRepository).incrementByDaySubscribers(id);
  }

  Future searchArticle(String word) async {
    if (word.isEmpty || word == '') {
      read(articlesController).restoreFromeCache();
      return;
    }
    read(allArticles).state = null;
    final articles = await read(microCMSRepository).searchArticleListContents(word);
    read(allArticles).state = articles;
  }
}
