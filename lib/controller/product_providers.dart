import 'package:shopifind/controller/store_providers.dart';
import 'package:shopifind/model/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsBySectionProvider =
    StateProvider.family<List<ProductModel>, String>((ref, String? section) {
  final List<ProductModel> allProducts =
      ref.watch(productsControllerProvider) as List<ProductModel>;

  if (section != '') {
    print('filter products by section: $section');
    final filteredProducts =
        allProducts.where((element) => element.sectionId == section).toList();
    return filteredProducts;
  } else {
    return allProducts;
  }
});

final productsControllerProvider = StateNotifierProvider((ref) {
  final currentStore = ref.watch(selectedStoreProvider).state;
  if (currentStore != null) {
    print(
        'products length in ${currentStore.id} store: ${currentStore.products.length}');
    return ProductsController(currentStore.products);
  } else {
    return ProductsController();
  }
});

class ProductsController extends StateNotifier<List<ProductModel>> {
  ProductsController([List<ProductModel>? products]) : super(products ?? []);

  void add(ProductModel newProduct) {
    state = [
      ...state,
      newProduct,
    ];
  }

  void addList(List<ProductModel> newProducts) {
    state = [
      ...state,
      ...newProducts,
    ];
  }

  void editSection({required String id, required String section}) {
    state = [
      for (final product in state)
        if (product.id == id) product.copyWith(sectionId: section) else product,
    ];
  }

  void editDescription({required String id, required String description}) {
    state = [
      for (final product in state)
        if (product.id == id)
          product.copyWith(description: description)
        else
          product,
    ];
  }

  void editPrice({required String id, required double price}) {
    state = [
      for (final product in state)
        if (product.id == id) product.copyWith(price: price) else product,
    ];
  }

  void remove(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }

  void clear() {
    state = [];
  }
}
