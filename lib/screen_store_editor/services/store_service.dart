import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/firestore/collections/firestore_collection_keys.dart';

class AbortedException implements Exception {}

// final storeDataProvider = FutureProvider.autoDispose(
//   (ref) async {
//     // Cancel the page request if the UI no longer needs it before the request
//     // is finished. This typically happen if the user scrolls very fast
//     // final cancelToken = CancelToken();
//     // ref.onDispose(cancelToken.cancel);

//     // Debouncing the request. By having this delay, it leaves the opportunity
//     // for consumers to subscribe to a different `meta` parameters. In which
//     // case, this request will be aborted.
//     // await Future<void>.delayed(const Duration(milliseconds: 250));
//     // if (cancelToken.isCancelled) throw AbortedException();

//     final repository = ref.watch(storeServiceProvider);
//     final rawStores = await repository.fetchStores();
//     return rawStores;
//   },
// );

final storeServiceProvider = Provider((ref) => StoreFirestoreService());

class StoreFirestoreService {
  // Future<void> uploadToSever({
  //   required Store store,
  //   required List<Product> products,
  //   required List<CanvObj> objects,
  // }) async {
  //   WriteBatch batch = FirebaseFirestore.instance.batch();
  //   store = store.copyWith(items: products, objects: objects);
  //   try {
  //     batch.set(
  //         FirebaseFirestore.instance
  //             .collection(FirestoreCollectionKeys.stores)
  //             .doc(store.id),
  //         store.toJson(),
  //         SetOptions(merge: true));

  //     await batch.commit();
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchStores() async {
    final query = await FirebaseFirestore.instance
        .collection(FirestoreCollectionKeys.stores)
        .get();
    // throw Exception();
    return query;
  }

  // Future<void> updateStoreDescription(String id, String newDescription) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection(FirestoreCollectionKeys.stores)
  //         .doc(id)
  //         .update({'description': newDescription});
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  // Future<void> deleteStore(String id) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection(FirestoreCollectionKeys.stores)
  //         .doc(id)
  //         .delete();
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }
}
