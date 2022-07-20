import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/screen_store_editor/controller/store_controller.dart';
import 'package:shopifind/screen_store_editor/model/store.dart';
import 'package:shopifind/screen_store_editor/services/store_service.dart';

final storeServiceAdapter = FutureProvider.autoDispose(
  (ref) async {
    // Cancel the page request if the UI no longer needs it before the request
    // is finished. This typically happen if the user scrolls very fast
    // final cancelToken = CancelToken();
    // ref.onDispose(cancelToken.cancel);

    // Debouncing the request. By having this delay, it leaves the opportunity
    // for consumers to subscribe to a different `meta` parameters. In which
    // case, this request will be aborted.
    // await Future<void>.delayed(const Duration(milliseconds: 250));
    // if (cancelToken.isCancelled) throw AbortedException();

    final repository = ref.watch(storeServiceProvider);
    final data = await repository.fetchStores();
    // Test
    // await Future.delayed(const Duration(seconds: 200));
    final List<Store> stores = [];
    for (final item in data.docs) {
      final store = Store.fromFirestore(snapshot: item);
      stores.add(store);
    }
    ref.read(storesControllerProvider.notifier).setStores(stores);
    return stores;
  },
);

// final storeServiceAdapter =
//     StateNotifierProvider<StoreServiceAdapter, AsyncValue<List<Store>>>((ref) {
//   StoreFirestoreService service = ref.read(storeServiceProvider);
//   return StoreServiceAdapter(service: service);
// });

// class StoreServiceAdapter extends StateNotifier<AsyncValue<List<Store>>> {
//   StoreServiceAdapter({required this.service}) : super(const AsyncLoading()) {
//     _fetchStores();
//   }

//   final StoreFirestoreService service;

//   Future<void> _fetchStores() async {
//     state = const AsyncValue.loading();
//     /// Riverpod syntax for try/catch
//     state = await AsyncValue.guard(() async {
//       final List<Store> stores = [];
//       final data = await service.fetchStores();
//       for (final item in data.docs) {
//         final store = Store.fromFirestore(snapshot: item);
//         stores.add(store);
//       }
//       return stores;
//     });
//   }
// }
