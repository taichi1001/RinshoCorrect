import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pedantic/pedantic.dart';
import 'package:rinsho_collect/entity/bookmark.dart';

final firebaseRepository =
    Provider.autoDispose<FirebaseRepository>((ref) => FirebaseRepositoryImpl(ref.read));

abstract class FirebaseRepository {
  Future incrementSubscribers(String id);
  Future incrementByDaySubscribers(String id);
  Future incrementBookmark(Bookmark bookmark);
  Future<List<Subscribes>> getSubscribers();
  Future<List<Bookmark>> getBookmarkList();
  void changeIsBookmark(Bookmark bookmark);
}

class FirebaseRepositoryImpl implements FirebaseRepository {
  FirebaseRepositoryImpl(this.read);
  final Reader read;

  @override
  Future incrementSubscribers(String id) async {
    await specifiedArticleUnregistered(id);
    unawaited(
      FirebaseFirestore.instance
          .collection('articles')
          .doc(id)
          .collection('count')
          .doc('all')
          .update({'count': FieldValue.increment(1)}),
    );
  }

  @override
  Future incrementByDaySubscribers(String id) async {
    await specifiedArticleUnregisteredByDay(id);
    final today = '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
    unawaited(
      FirebaseFirestore.instance
          .collection('articles')
          .doc(id)
          .collection('count')
          .doc(today)
          .update({'count': FieldValue.increment(1)}),
    );
  }

  @override
  Future incrementBookmark(Bookmark bookmark) async {
    await specifiedArticleUnregistered(bookmark.id);
    if (bookmark.isBookmark) {
      unawaited(
        FirebaseFirestore.instance
            .collection('articles')
            .doc(bookmark.id)
            .update({'bookmark': FieldValue.increment(1)}),
      );
    } else {
      unawaited(
        FirebaseFirestore.instance
            .collection('articles')
            .doc(bookmark.id)
            .update({'bookmark': FieldValue.increment(-1)}),
      );
    }
  }

  @override
  Future<List<Subscribes>> getSubscribers() async {
    final ref = await FirebaseFirestore.instance.collection('articles').get();
    return ref.docs
        .map((doc) => doc.data())
        .map((data) => Subscribes(id: data['id'], count: data['count']))
        .toList();
  }

  @override
  Future<List<Bookmark>> getBookmarkList() async {
    final user = FirebaseAuth.instance.currentUser;
    final ref = await FirebaseFirestore.instance
        .collection('user')
        .doc(user.uid)
        .collection('bookmark')
        .get();
    return ref.docs
        .map((doc) => doc.data())
        .map((doc) => Bookmark(id: doc['id'], isBookmark: doc['isBookmark']))
        .toList();
  }

  @override
  void changeIsBookmark(Bookmark bookmark) {
    final user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('user')
        .doc(user.uid)
        .collection('bookmark')
        .doc(bookmark.id)
        .set({'id': bookmark.id, 'isBookmark': bookmark.isBookmark});
    incrementBookmark(bookmark);
  }

  Future specifiedArticleUnregistered(String id) async {
    final subscriber = await FirebaseFirestore.instance.collection('articles').doc(id).get();
    if (subscriber.data() == null) {
      await FirebaseFirestore.instance
          .collection('articles')
          .doc(id)
          .set({'id': id, 'bookmark': 0});

      await FirebaseFirestore.instance
          .collection('articles')
          .doc(id)
          .collection('count')
          .doc('all')
          .set({'count': 0});
    }
  }

  Future specifiedArticleUnregisteredByDay(String id) async {
    final today = '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
    final byDay = await FirebaseFirestore.instance
        .collection('articles')
        .doc(id)
        .collection('count')
        .doc(today)
        .get();
    if (byDay.data() == null) {
      await FirebaseFirestore.instance
          .collection('articles')
          .doc(id)
          .collection('count')
          .doc(today)
          .set({'count': 0});
    }
  }
}

class Subscribes {
  String id;
  List<Map<String, int>> count;
  Subscribes({this.id, this.count});
}
