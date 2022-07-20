import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/screen_store_editor/model/store.dart';

/// returns the store repository controller
final storesControllerProvider =
    StateNotifierProvider<StoreControllerNotifier, StoresState>((ref) {
  return StoreControllerNotifier();
});

/// Manages list of stores
class StoreControllerNotifier extends StateNotifier<StoresState> {
  StoreControllerNotifier([StoresState? storesState])
      : super(storesState ?? const StoresState());

  List<Store> get stores => state.stores;
  Store? get selectedStore => state.selectedStore;

  void addStore(Store store) {
    state = state.copyWith(stores: [
      ...state.stores,
      store,
    ]);
  }

  void addStores(List<Store> stores) {
    state = state.copyWith(stores: [
      ...state.stores,
      ...stores,
    ]);
  }

  void setStores(List<Store> stores) {
    state = state.copyWith(stores: [...stores]);
  }

  void editStore({
    required Store newStore,
  }) {
    state = state.copyWith(
      stores: [
        for (final Store store in state.stores)
          if (store.id == newStore.id)
            store.copyWith(
              name: newStore.name,
              items: newStore.items,
              objects: newStore.objects,
              isSaved: newStore.isSaved,
            )
          else
            store,
      ],
      selectedStore: newStore,
    );
  }

  void selectStore(String id) {
    late final Store? selectedStore;
    for (final store in state.stores) {
      if (store.id == id) {
        selectedStore = store;
      }
    }
    state = state.copyWith(selectedStore: selectedStore);
  }

    void removeStore(String id) {
    state = state.copyWith(
      stores: state.stores.where((Store store) => store.id != id).toList(),
      selectedStore: null,
    );
  }
}

class StoresState extends Equatable {
  const StoresState({
    this.stores = const [],
    this.selectedStore,
  });

  final List<Store> stores;
  final Store? selectedStore;

  StoresState copyWith({
    List<Store>? stores,
    Store? selectedStore,
  }) {
    return StoresState(
      stores: stores ?? this.stores,
      selectedStore: selectedStore,
    );
  }

  @override
  String toString() {
    return 'selectedStore id: ${selectedStore?.id} | type: ${selectedStore?.id}';
  }

  @override
  List<Object?> get props => [stores, selectedStore];
}
