import 'package:shopifind/model/product_model.dart';

class MockShoppingList {
  MockShoppingList({required this.name, required this.products});

  final String name;
  final List<ProductModel> products;

  MockShoppingList copyWith({
    String? name,
    List<ProductModel>? products,
  }) {
    return MockShoppingList(
      name: name ?? this.name,
      products: products ?? this.products,
    );
  }
}
