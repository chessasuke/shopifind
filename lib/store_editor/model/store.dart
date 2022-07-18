import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shopifind/store_editor/model/canv_obj.dart';
import 'package:shopifind/store_editor/model/product.dart';
import 'package:uuid/uuid.dart';

part 'store.g.dart';

@JsonSerializable(explicitToJson: true)
class Store extends Equatable {
  const Store({
    required this.id,
    required this.description,
    required this.items,
    required this.objects,
    required this.visible,
  });
  final String? id;
  final String? description;
  final List<CanvObj>? objects;
  final List<Product>? items;
  final bool? visible;

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);

  Map<String, dynamic> toJson() => _$StoreToJson(this);

  factory Store.fromFirestore({
    required DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  }) {
    final data = snapshot.data();
    return Store(
      id: data?['id'],
      description: data?['description'],
      items: data?['items'] ?? [],
      visible: data?['visible'],
      objects: data?['objects'],
    );
  }

    factory Store.initial() => Store(
        id: const Uuid().v4(),
        description: 'Store Description',
        items: const <Product>[],
        objects: const <CanvObj>[],
        visible: false,
      );

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (description != null) "description": description,
      if (items != null) "items": items,
      if (visible != null) "visible": visible,
      if (objects != null) "objects": objects,
    };
  }

  Store copyWith({
    String? id,
    String? description,
    List<Product>? items,
    List<CanvObj>? objects,
    bool? visible,
  }) {
    return Store(
      id: id ?? this.id,
      description: description ?? this.description,
      items: items ?? this.items,
      objects: objects ?? this.objects,
      visible: visible ?? this.visible,
    );
  }

  // factory Store.initialWithId({required String id}) => Store(
  //       id: id,
  //       description: 'Store Description',
  //       products: const <Product>[],
  //       canvasObjects: const <CanvasObject>[],
  //       isPublished: false,
  //     );

  // factory Store.fromJson(Map<String, dynamic> json) {
  //   final objectsFetched = json['objects'];
  //   final List<CanvasObject> objects = [];

  //   final productsFetched = json['products'];
  //   final List<Product> products = [];

  //   for (final obj in objectsFetched) {
  //     final CanvasObject newObj = CanvasObject.fromJson(obj);
  //     objects.add(newObj);
  //   }

  //   for (final product in productsFetched) {
  //     // print('product: $product | ${product.runtimeType}');
  //     products.add(Product.fromJson(product));
  //   }

  //   return Store(
  //     id: json['id'] as String,
  //     description: json['description'] as String,
  //     products: products,
  //     canvasObjects: objects,
  //     isPublished: json['isPublished'] as bool,
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   final List<Map<String, dynamic>> productsToJson =
  //       products.map((e) => e.toJson()).toList();
  //   final List<Map<String, dynamic>> objectsToJson =
  //       canvasObjects.map((e) => e.toJson()).toList();
  //   return {
  //     'id': id,
  //     'description': description,
  //     'products': productsToJson,
  //     'objects': objectsToJson,
  //     'isPublished': false,
  //   };
  // }

  @override
  List<Object?> get props => [id, description, items, objects, visible];
}
