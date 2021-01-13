import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pedantic/pedantic.dart';

final firebaseRepository =
    Provider.autoDispose<FirebaseRepository>((ref) => FirebaseRepositoryImpl(ref.read));

abstract class FirebaseRepository {
  Future incrementSubscribers(String id);
  Future incrementFavorite(Favorite favorite);
  Future<List<Subscribes>> getSubscribers();
  Future<List<Favorite>> getFavoriteList();
  void changeIsFavorite(Favorite favorite);
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
          .update({'count': FieldValue.increment(1)}),
    );
  }

  @override
  Future incrementFavorite(Favorite favorite) async {
    await specifiedArticleUnregistered(favorite.id);
    if (favorite.isFavorite) {
      unawaited(
        FirebaseFirestore.instance
            .collection('articles')
            .doc(favorite.id)
            .update({'favorite': FieldValue.increment(1)}),
      );
    } else {
      unawaited(
        FirebaseFirestore.instance
            .collection('articles')
            .doc(favorite.id)
            .update({'favorite': FieldValue.increment(-1)}),
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
  Future<List<Favorite>> getFavoriteList() async {
    final user = FirebaseAuth.instance.currentUser;
    final ref = await FirebaseFirestore.instance
        .collection('user')
        .doc(user.uid)
        .collection('favorite')
        .get();
    return ref.docs
        .map((doc) => doc.data())
        .map((doc) => Favorite(id: doc['id'], isFavorite: doc['isFavorite']))
        .toList();
  }

  @override
  void changeIsFavorite(Favorite favorite) {
    final user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('user')
        .doc(user.uid)
        .collection('favorite')
        .doc(favorite.id)
        .set({'id': favorite.id, 'isFavorite': favorite.isFavorite});
    incrementFavorite(favorite);
  }

  Future specifiedArticleUnregistered(String id) async {
    final subscriber = await FirebaseFirestore.instance.collection('articles').doc(id).get();
    if (subscriber.data() == null) {
      await FirebaseFirestore.instance
          .collection('articles')
          .doc(id)
          .set({'id': id, 'count': 0, 'favorite': 0});
    }
  }
}

class Subscribes {
  String id;
  int count;
  Subscribes({this.id, this.count});
}

class Favorite {
  Favorite({this.id, this.isFavorite});
  String id;
  bool isFavorite;
}
