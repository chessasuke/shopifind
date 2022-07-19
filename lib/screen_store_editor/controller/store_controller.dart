import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/screen_store_editor/model/store.dart';

/// returns the store repository controller
final storesControllerProvider =
    StateNotifierProvider<StoreControllerNotifier, List<Store>>((ref) {
  return StoreControllerNotifier();
});

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
    required Store newStore,
  }) {
    state = [
      for (final Store store in state)
        if (store.id == newStore.id)
          store.copyWith(
            name: newStore.name,
            items: newStore.items,
            objects: newStore.objects,
            isSaved: newStore.isSaved,
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

  void removeStore(String id) {
    state = state.where((store) => store.id != id).toList();
    _selectedStore = null;
  }
}
