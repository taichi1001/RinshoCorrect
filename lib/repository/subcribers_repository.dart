import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pedantic/pedantic.dart';

final subscribersRepository =
    Provider.autoDispose<SubscribersRepository>((ref) => SubscribersRepositoryImpl(ref.read));

abstract class SubscribersRepository {
  Future incrementSubscribers(String id);
  Future getSubscribers();
}

class SubscribersRepositoryImpl implements SubscribersRepository {
  SubscribersRepositoryImpl(this.read);
  final Reader read;

  @override
  Future incrementSubscribers(String id) async {
    // final user = FirebaseAuth.instance.currentUser;
    final subscriber = await FirebaseFirestore.instance.collection('articles').doc(id).get();
    if (subscriber.data() == null) {
      unawaited(
        FirebaseFirestore.instance.collection('articles').doc(id).set({'count': 1}),
      );
    } else {
      unawaited(
        FirebaseFirestore.instance
            .collection('articles')
            .doc(id)
            .update({'count': FieldValue.increment(1)}),
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
}

class Subscribes {
  String id;
  int count;
  Subscribes({this.id, this.count});
}
