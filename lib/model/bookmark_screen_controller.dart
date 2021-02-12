import 'package:rinsho_collect/enum/display_mode.dart';
import 'package:rinsho_collect/enum/sort_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rinsho_collect/repository/firebase_repository.dart';

final bookmarkListSortType = StateProvider((ref) => SortType.asc);

final bookmarkListDisplayMode = StateProvider((ref) => DisplayMode.joint);

final bookmarkScreenController =
    Provider.autoDispose((ref) => BookmarkScreenController(read: ref.read));

class BookmarkScreenController {
  BookmarkScreenController({
    this.read,
  });

  final Reader read;

  void changeSortType() {
    final sort = read(bookmarkListSortType).state;
    read(bookmarkListSortType).state = sort == SortType.asc ? SortType.desc : SortType.asc;
  }

  void changeDisplayMode() {
    final mode = read(bookmarkListDisplayMode).state;
    read(bookmarkListDisplayMode).state =
        mode == DisplayMode.joint ? DisplayMode.symptomDisorder : DisplayMode.joint;
  }

  Future incrementSubscribers(String id) async {
    await read(firebaseRepository).incrementSubscribers(id);
  }
}
