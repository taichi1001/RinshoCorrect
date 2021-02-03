import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rinsho_collect/service/database.dart';
import 'package:rinsho_collect/entity/bookmark.dart';

final bookmarkRepository =
    Provider.autoDispose<BookmarkRepository>((ref) => BookmarkRepositoryImpl(ref.read));

abstract class BookmarkRepository {
  Future<int> create(Bookmark bookmark);
  Future<List<Bookmark>> getAll();
  Future<int> update(Bookmark bookmark);
  Future<int> delete(Bookmark bookmark);
  Future deleteAll();
}

class BookmarkRepositoryImpl implements BookmarkRepository {
  BookmarkRepositoryImpl(this.read);

  final Reader read;
  final dbProvider = DatabaseService.dbProvider;
  final tableName = DatabaseService.bookmarkTableName;

  @override
  Future<int> create(Bookmark bookmark) async {
    final db = await dbProvider.database;
    final result = db.insert(tableName, bookmark.toJson());
    return result;
  }

  @override
  Future<List<Bookmark>> getAll() async {
    final db = await dbProvider.database;
    final result = await db.query(tableName);
    final List<Bookmark> bookmarks =
        result.isNotEmpty ? result.map((item) => Bookmark.fromJson(item)).toList() : [];
    return bookmarks;
  }

  @override
  Future<int> update(Bookmark bookmark) async {
    final db = await dbProvider.database;
    final result =
        await db.update(tableName, bookmark.toJson(), where: 'id = ?', whereArgs: [bookmark.id]);
    return result;
  }

  @override
  Future<int> delete(Bookmark bookmark) async {
    final db = await dbProvider.database;
    final result = await db.delete(tableName, where: 'id = ?', whereArgs: [bookmark.id]);
    return result;
  }

  //not use this
  @override
  Future deleteAll() async {
    final db = await dbProvider.database;
    final result = await db.delete(
      tableName,
    );
    return result;
  }
}
