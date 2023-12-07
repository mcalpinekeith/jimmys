import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jimmys/core/extensions/string.dart';
import 'package:jimmys/core/global.dart';
import 'package:jimmys/data/modules/services/user_service.dart';
import 'package:jimmys/domain/models/base_model.dart';

/*
DO NOT use async / await

https://www.youtube.com/watch?v=oDvdAFP6OhQ&t=673s&ab_channel=Firebase
Reference: Firebase Video - How Do I Enable Offline Support 11:13

Your callback won't be called and your promise won't complete until the document write has been successful on the server.
This is why if your UI waits until the write completes to do something, it appears to freeze in "offline mode" even if
the write was actually made to the local cache.
It is OK to not use async / await, .then() or callbacks. Firestore will always "act" as if the data change was applied
immediately, so you don't need to wait to be working with fresh data.
You only need to use callbacks and promises when you need to be sure that a server write has happened, and you want
to block other things from happening until you get that confirmation.
*/

class StoreService {
  final FirebaseFirestore store;

  StoreService({required this.store}) {
    if (!Global.isTest) {
      /*
      Cloud Firestore supports offline data persistence. This feature caches a copy of the Cloud Firestore data that your app is actively using,
      so your app can access the data when the device is offline. You can write, read, listen to, and query the cached data. When the device
      comes back online, Cloud Firestore synchronizes any local changes made by your app to the Cloud Firestore backend.
      */

      store.settings = const Settings(persistenceEnabled: true, cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
    }
  }

  Future<List<T>> _where<T extends BaseModel>(BaseModel data, {(String, String)? criteria, bool isShared = false}) async {
    final result = <T>[];
    final query = isShared
        ? _sharedCollection('shared_${data.path}')
        : _userCollection(data.path);

    final List<QueryDocumentSnapshot<T>> snapshots;

    if (criteria != null) {
      snapshots = await query
        .where(criteria.$1, isEqualTo: criteria.$2)
        .withConverter<T>(
          fromFirestore: (_, __) => data.fromMap(_.data()!),
          toFirestore: (_, __) => _.toMap(),
        )
        .get()
        .then((_) => _.docs);
    }
    else {
      snapshots = await query
        .withConverter<T>(
          fromFirestore: (_, __) => data.fromMap(_.data()!),
          toFirestore: (_, __) => _.toMap(),
        )
        .get()
        .then((_) => _.docs);
    }

    for (final snapshot in snapshots) {
      result.add(snapshot.data());
    }

    return result;
  }

  CollectionReference<Map<String, dynamic>> _sharedCollection(String path) {
    return store.collection(path);
  }

  CollectionReference<Map<String, dynamic>> _userCollection(String path) {
    final userId = getIt<UserService>().userId;

    if (userId.isNullOrEmpty) throw Exception('User cannot be null.');

    return store
      .collection('users')
      .doc(userId)
      .collection(path);
  }

  void delete(BaseModel data) {
    _userCollection(data.path).doc(data.id).delete();
  }

  void set(BaseModel data) {
    _userCollection(data.path).withConverter<BaseModel>(
      fromFirestore: (_, __) => data.fromMap(_.data()!),
      toFirestore: (_, __) => _.toMap(),
    )
    .doc(data.id)
    .set(data);
  }

  Future<List<T>> sharedWhere<T extends BaseModel>(BaseModel data, {(String, String)? criteria}) => _where(data, criteria: criteria, isShared: true);

  Future<List<T>> where<T extends BaseModel>(BaseModel data, {(String, String)? criteria}) => _where(data, criteria: criteria);
}