import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/store_editor/model/store.dart';

// final currentStoreIdProvider = StateProvider((ref) => '');

/// returns the store repository controller
final storesControllerProvider =
    StateNotifierProvider<StoreControllerNotifier, List<Store>>(
        (ref) => StoreControllerNotifier());

/// Manages list of stores
class StoreControllerNotifier extends StateNotifier<List<Store>> {
  StoreControllerNotifier([List<Store>? stores]) : super(stores ?? []);

  Store? _selectedStore;
  Store? get selectedStore => _selectedStore;

  List<Store> get stores => state;

  void addStore(Store store) {
    state = [
      ...state,
      store,
    ];
  }

  void addStores(List<Store> stores) {
    state = [
      ...state,
      ...stores,
    ];
  }

  void editStore({
    required String id,
    required Store store,
  }) {
    state = [
      for (final Store store in state)
        if (store.id == id)
          store.copyWith(
            id: store.id,
            description: store.description,
            items: store.items,
            objects: store.objects,
            visible: store.visible,
          )
        else
          store,
    ];
  }

  void selectStore(String id) {
    for (final store in state) {
      if (store.id == id) {
        _selectedStore = store;
        return;
      }
    }
    _selectedStore = null;
  }

  // Store? selectStoreById(String id) {
  //   final index = state.indexWhere((element) => element.id == id);
  //   if (index != -1) {
  //     return state.elementAt(index);
  //   } else {
  //     return null;
  //   }
  // }

  void removeStore(String id) {
    state = state.where((store) => store.id != id).toList();
  }

  // void editLayout({
  //   required String id,
  //   required List<CanvObj> layout,
  // }) {
  //   state = [
  //     for (final Store store in state)
  //       if (store.id == id) store.copyWith(layout: layout) else store,
  //   ];
  // }

  // void editStoreDescription({required String id, required String description}) {
  //   state = [
  //     for (final store in state)
  //       if (store.id == id) store.copyWith(description: description) else store,
  //   ];
  // }

  // void editStoreProducts({
  //   required String id,
  //   required List<Product> products,
  // }) {
  //   state = [
  //     for (final store in state)
  //       if (store.id == id) store.copyWith(items: products) else store,
  //   ];
  // }

  /// returns the selected store, provided its id
// final selectedStoreProvider = StateProvider.family((ref, String id) {
//   if (id.isNotEmpty) {
//     final String selectedStoreId =
//         ref.watch(selectedStoreIdProvider.notifier).state;

//     final Store? selectedStore = ref
//         .watch(storesControllerProvider.notifier)
//         .selectStoreById(selectedStoreId);
//   }

//   return selectedStore;
// });

  /// fetch stores from firestore (only the new docs unless is the first fetching)
// final storeFetcherProvider = FutureProvider.autoDispose((ref) async {
//   final query = await AppService.fetchStores();
//   final List<Store> stores = [];
//   for (final QueryDocumentSnapshot<Map<String, dynamic>> storeFetched
//       in query.docs) {
//     final store = Store.fromJson(storeFetched.data());
//     stores.add(store);
//   }

//   // print('stores length: ${stores.length}');

//   /// add all stores to the repository controller
//   ref.watch(storesControllerProvider.notifier).addAll(stores);
//   return stores;
// });

// /// returns all store (state of store controller)
// final storeRepositoryProvider =
//     StateProvider((ref) => ref.watch(storesControllerProvider));

}
