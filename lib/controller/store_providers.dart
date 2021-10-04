// import 'package:shopifind/model/canv_object_model.dart';
// import 'package:shopifind/model/product_model.dart';
// import 'package:shopifind/model/store_model.dart';
// import 'package:shopifind/service/service.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shopifind/service/service.dart';

// /// provides id of the selected store
// final selectedStoreIdProvider = StateProvider((ref) {
//   String storeId = '';
//   print('storeId: $storeId');
//   return storeId;
// });

// /// returns the selected store, provided its id
// final selectedStoreProvider = StateProvider((ref) {
//   // final List<StoreModel> allStores =
//   //     ref.watch(storesControllerProvider) as List<StoreModel>;

//   // final selectedStoreId = ref.watch(selectedStoreIdProvider).state;

//   //     final selectedStore =
//   //     allStores.firstWhere((element) => element.id == selectedStoreId);
//   // return selectedStore;
//   return StoreModel.initial();
// });

// /// fetch stores from firestore (only the new docs unless is the first fetch)
// final storeFetcherProvider = FutureProvider((ref) async {
//   final query = await AppService.fetchStores();
//   final List<StoreModel> stores = [];
//   for (final storeFetched in query.docChanges) {
//     if (storeFetched.doc.data() != null) {
//       final store = StoreModel.fromJson(storeFetched.doc.data()!);
//       stores.add(store);
//     }
//   }

//   /// add all stores to the repository controller
//   ref.watch(storesControllerProvider.notifier).addAll(stores);
//   return stores;
// });

// /// returns all store
// final storeRepositoryProvider = StateProvider(
//     (ref) => ref.watch(storesControllerProvider) as List<StoreModel>);

// /// returns the store repository controller
// final storesControllerProvider =
//     StateNotifierProvider((ref) => StoreController());

// /// the repository controller
// class StoreController extends StateNotifier<List<StoreModel>> {
//   StoreController([List<StoreModel>? stores]) : super(stores ?? []);

//   void add(StoreModel store) {
//     state = [
//       ...state,
//       store,
//     ];
//   }

//   void addAll(List<StoreModel> stores) {
//     state = [
//       ...state,
//       ...stores,
//     ];
//   }

//   void addList(List<StoreModel> stores) {
//     state = [
//       ...state,
//       ...stores,
//     ];
//   }

//   void editStoreObjects(
//       {required String id, required List<CanvObjectModel> objects}) {
//     state = [
//       for (final store in state)
//         if (store.id == id) store.copyWith(objects: objects) else store,
//     ];
//   }

//   void editStoreDescription({required String id, required String description}) {
//     state = [
//       for (final store in state)
//         if (store.id == id) store.copyWith(description: description) else store,
//     ];
//   }

//   void editStoreProducts(
//       {required String id, required List<ProductModel> products}) {
//     state = [
//       for (final store in state)
//         if (store.id == id) store.copyWith(products: products) else store,
//     ];
//   }

//   StoreModel? getStoreById(String id) {
//     final index = state.indexWhere((element) => element.id == id);
//     if (index != -1) {
//       return state.elementAt(index);
//     } else {
//       return null;
//     }
//   }

//   void remove(String id) {
//     state = state.where((todo) => todo.id != id).toList();
//   }
// }
