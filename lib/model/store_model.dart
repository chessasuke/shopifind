import 'package:shopifind/model/canv_object_model.dart';
import 'package:shopifind/model/product_model.dart';
import 'package:equatable/equatable.dart';
import '../utils.dart';

class StoreModel extends Equatable {
  const StoreModel({
    required this.id,
    required this.description,
    required this.products,
    required this.objects,
    required this.isPublished,
  });
  final String id;
  final String description;
  final List<CanvObjectModel> objects;
  final List<ProductModel> products;
  final bool isPublished;

  factory StoreModel.initial() => StoreModel(
        id: Utils.generateId(),
        description: 'Store Description',
        products: const <ProductModel>[],
        objects: const <CanvObjectModel>[],
        isPublished: false,
      );

  factory StoreModel.initialWithId({required String id}) => StoreModel(
        id: id,
        description: 'Store Description',
        products: const <ProductModel>[],
        objects: const <CanvObjectModel>[],
        isPublished: false,
      );

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    final objectsFetched = json['objects'];
    final List<CanvObjectModel> objects = [];

    final productsFetched = json['products'];
    final List<ProductModel> products = [];

    for (final obj in objectsFetched) {
      final CanvObjectModel newObj = CanvObjectModel.fromJson(obj);
      objects.add(newObj);
    }

    for (final product in productsFetched) {
      // print('product: $product | ${product.runtimeType}');
      products.add(ProductModel.fromJson(product));
    }

    return StoreModel(
      id: json['id'] as String,
      description: json['description'] as String,
      products: products,
      objects: objects,
      isPublished: json['isPublished'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    final List<Map<String, dynamic>> productsToJson =
        products.map((e) => e.toJson()).toList();
    final List<Map<String, dynamic>> objectsToJson =
        objects.map((e) => e.toJson()).toList();
    return {
      'id': id,
      'description': description,
      'products': productsToJson,
      'objects': objectsToJson,
      'isPublished': false,
    };
  }

  StoreModel copyWith({
    String? id,
    String? description,
    List<CanvObjectModel>? objects,
    List<ProductModel>? products,
    bool? isPublished,
  }) {
    return StoreModel(
      id: id ?? this.id,
      description: description ?? this.description,
      products: products ?? this.products,
      objects: objects ?? this.objects,
      isPublished: isPublished ?? this.isPublished,
    );
  }

  @override
  List<Object?> get props => [id, description, products, objects, isPublished];
}
