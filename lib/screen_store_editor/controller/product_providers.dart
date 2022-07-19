// import 'package:shopifind/store_editor/providers/store_providers.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shopifind/store_editor/model/product.dart';
// import 'package:shopifind/store_editor/model/store.dart';

// final productsBySectionProvider =
//     StateProvider.family<List<Product>, String>((ref, String? section) {
//   final List<Product> allProducts =
//       ref.watch(productsControllerProvider) as List<Product>;

//   if (section != '') {
//     print('filter products by section: $section');
//     final filteredProducts =
//         allProducts.where((element) => element.sectionId == section).toList();
//     return filteredProducts;
//   } else {
//     return allProducts;
//   }
// });

// final productsControllerProvider = StateNotifierProvider((ref) {
//   final Store currentStore = ref.watch(selectedStoreProvider.notifier).state!;
//   if (currentStore != null) {
//     print(
//         'products length in ${currentStore.id} store: ${currentStore.items.length}');
//     return ProductsController(currentStore.items);
//   } else {
//     return ProductsController();
//   }
// });

// class ProductsController extends StateNotifier<List<Product>> {
//   ProductsController([List<Product>? products]) : super(products ?? []);

//   void add(Product newProduct) {
//     state = [
//       ...state,
//       newProduct,
//     ];
//   }

//   void addList(List<Product> newProducts) {
//     state = [
//       ...state,
//       ...newProducts,
//     ];
//   }

//   void editSection({required String id, required String section}) {
//     state = [
//       for (final product in state)
//         if (product.id == id) product.copyWith(sectionId: section) else product,
//     ];
//   }

//   void editDescription({required String id, required String description}) {
//     state = [
//       for (final product in state)
//         if (product.id == id)
//           product.copyWith(description: description)
//         else
//           product,
//     ];
//   }

//   void editPrice({required String id, required double price}) {
//     state = [
//       for (final product in state)
//         if (product.id == id) product.copyWith(price: price) else product,
//     ];
//   }

//   void remove(String id) {
//     state = state.where((todo) => todo.id != id).toList();
//   }

//   void clear() {
//     state = [];
//   }
// }
