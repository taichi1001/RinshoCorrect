import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rinsho_collect/entity/bookmark.dart';
import 'package:rinsho_collect/repository/firebase_repository.dart';
import 'package:rinsho_collect/repository/bookmark_repository.dart';

final bookmarkList = StateProvider<List<Bookmark>>((ref) => null);

final currentBookmark = StateProvider.family<bool, String>((ref, id) {
  final _bookmarkList = ref.watch(bookmarkList).state;
  final result =
      _bookmarkList?.firstWhere((favorite) => favorite.id == id, orElse: () => null)?.isBookmark;
  return result ?? false;
});

final bookmarkController = Provider.autoDispose((ref) => BookmarkController(read: ref.read));

class BookmarkController {
  BookmarkController({
    this.read,
  });

  final Reader read;

  Future fetchBookmarkList() async {
    read(bookmarkList).state = await read(firebaseRepository).getBookmarkList();
    // read(bookmarkList).state = await read(bookmarkRepository).getAll();
  }

  void changeIsBookmark(String id) {
    final _bookmarkList = read(bookmarkList).state;
    final target = _bookmarkList.firstWhere((bookmark) => bookmark.id == id, orElse: () => null);
    if (_bookmarkList.isEmpty || target == null) {
      _newBookmark(id, true, _bookmarkList);
      return;
    }
    final updateBookmark = target.isBookmark
        ? Bookmark(id: id, isBookmark: false)
        : Bookmark(id: id, isBookmark: true);
    final targetIndex = _bookmarkList.indexWhere((bookmark) => bookmark.id == id);
    _bookmarkList[targetIndex] = updateBookmark;
    read(bookmarkList).state = _bookmarkList;
    // read(bookmarkRepository).update(updateBookmark);
    read(firebaseRepository).changeIsBookmark(updateBookmark);
    read(firebaseRepository).incrementBookmark(updateBookmark);
  }

  void _newBookmark(String id, bool isBookmark, List<Bookmark> list) {
    final updateBookmark = Bookmark(id: id, isBookmark: isBookmark);
    list.add(updateBookmark);
    read(bookmarkList).state = list;
    // read(bookmarkRepository).create(updateBookmark);
    read(firebaseRepository).changeIsBookmark(updateBookmark);
    read(firebaseRepository).incrementBookmark(updateBookmark);
  }
}
