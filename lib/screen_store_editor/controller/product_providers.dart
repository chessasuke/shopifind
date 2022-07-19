import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/screen_store_editor/controller/store_controller.dart';
import 'package:shopifind/screen_store_editor/model/product.dart';
import 'package:shopifind/screen_store_editor/model/store.dart';

final productsBySectionProvider =
    StateProvider.family<List<Product>, String>((ref, String? section) {
  final List<Product> allProducts = ref.watch(productsControllerProvider);

  if (section != null && section.isNotEmpty) {
    final filteredProducts = allProducts.where((product) {
      return product.sectionId.toLowerCase() == section.toLowerCase();
    }).toList();
    return filteredProducts;
  } else {
    return allProducts;
  }
});

final productsControllerProvider =
    StateNotifierProvider<ProductsControllerNotifier, List<Product>>((ref) {
  final Store? currentStore =
      ref.watch(storesControllerProvider.notifier).selectedStore;
  if (currentStore != null) {
    return ProductsControllerNotifier(currentStore.items);
  } else {
    return ProductsControllerNotifier();
  }
});

class ProductsControllerNotifier extends StateNotifier<List<Product>> {
  ProductsControllerNotifier([List<Product>? products]) : super(products ?? []);

  void add(Product newProduct) {
    state = [
      ...state,
      newProduct,
    ];
  }

  void addList(List<Product> newProducts) {
    state = [
      ...state,
      ...newProducts,
    ];
  }

  void editProduct({required String id, required Product product}) {
    state = [
      for (final product in state)
        if (product.id == id)
          product.copyWith(
            id: product.id,
            description: product.description,
            sectionId: product.sectionId,
            price: product.price,
          )
        else
          product,
    ];
  }

  void remove(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }

  void clear() {
    state = [];
  }
}
