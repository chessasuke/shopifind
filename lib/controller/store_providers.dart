import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopifind/model/canv_object_model.dart';
import 'package:shopifind/model/product_model.dart';
import 'package:shopifind/model/store_model.dart';
import 'package:shopifind/service/service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// provides id of the selected store
final selectedStoreIdProvider = StateProvider((ref) {
  String storeId = '';
  return storeId;
});

/// returns the selected store, provided its id
final selectedStoreProvider = StateProvider((ref) {
  final String selectedStoreId = ref.watch(selectedStoreIdProvider).state;

  final StoreModel? selectedStore = ref
      .watch(storesControllerProvider.notifier)
      .selectStoreById(selectedStoreId);

  return selectedStore;
});

/// fetch stores from firestore (only the new docs unless is the first fetching)
final storeFetcherProvider = FutureProvider.autoDispose((ref) async {
  final query = await AppService.fetchStores();
  final List<StoreModel> stores = [];
  for (final QueryDocumentSnapshot<Map<String, dynamic>> storeFetched
      in query.docs) {
      final store = StoreModel.fromJson(storeFetched.data());
      stores.add(store);
  }

  // print('stores length: ${stores.length}');

  /// add all stores to the repository controller
  ref.watch(storesControllerProvider.notifier).addAll(stores);
  return stores;
});

/// returns all store (state of store controller)
final storeRepositoryProvider =
    StateProvider((ref) => ref.watch(storesControllerProvider));

/// returns the store repository controller
final storesControllerProvider =
    StateNotifierProvider((ref) => StoreController());

/// the repository controller
class StoreController extends StateNotifier<List<StoreModel>> {
  StoreController([List<StoreModel>? stores]) : super(stores ?? []);

  void add(StoreModel store) {
    state = [
      ...state,
      store,
    ];
  }

  void addAll(List<StoreModel> stores) {
    state = [
      ...state,
      ...stores,
    ];
  }

  void addList(List<StoreModel> stores) {
    state = [
      ...state,
      ...stores,
    ];
  }

  void editStoreObjects(
      {required String id, required List<CanvObjectModel> objects}) {
    state = [
      for (final store in state)
        if (store.id == id) store.copyWith(objects: objects) else store,
    ];
  }

  void editStoreDescription({required String id, required String description}) {
    state = [
      for (final store in state)
        if (store.id == id) store.copyWith(description: description) else store,
    ];
  }

  void editStoreProducts(
      {required String id, required List<ProductModel> products}) {
    state = [
      for (final store in state)
        if (store.id == id) store.copyWith(products: products) else store,
    ];
  }

  StoreModel? selectStoreById(String id) {
    final index = state.indexWhere((element) => element.id == id);
    if (index != -1) {
      return state.elementAt(index);
    } else {
      return null;
    }
  }

  void removeStore(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }

}
