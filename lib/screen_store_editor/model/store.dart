import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shopifind/screen_store_editor/model/canv_obj.dart';
import 'package:shopifind/screen_store_editor/model/product.dart';
import 'package:uuid/uuid.dart';

part 'store.g.dart';

@JsonSerializable(explicitToJson: true)
class Store extends Equatable {
  const Store({
    required this.id,
    required this.name,
    required this.items,
    required this.objects,
    required this.visible,
  });
  final String? id;
  final String? name;
  final List<CanvObj>? objects;
  final List<Product>? items;
  final bool? visible;

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);

  Map<String, dynamic> toJson() => _$StoreToJson(this);

  factory Store.initial() => Store(
        id: const Uuid().v4(),
        name: 'Store Name',
        items: const <Product>[],
        objects: const <CanvObj>[],
        visible: false,
      );

  factory Store.fromFirestore({
    required DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  }) {
    final data = snapshot.data();

    late final List<CanvObj>? objs;
    late final List<Product>? products;

    if (data?['objects'] != null) {
      objs = (data?['objects'] is Iterable)
          ? List.from(data?['objects']).map((item) {
              return CanvObj.fromJson((item as Map<String, dynamic>));
            }).toList()
          : null;
    } else {
      objs = [];
    }

    if (data?['items'] != null) {
      products = (data?['items'] is Iterable)
          ? List.from(data?['items']).map((product) {
              return Product.fromJson((product as Map<String, dynamic>));
            }).toList()
          : null;
    } else {
      products = [];
    }

    return Store(
      id: data?['id'],
      name: data?['name'],
      objects: objs,
      items: products,
      visible: data?['visible'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    final objs = objects?.map((obj) => obj.toJson()).toList() ?? [];
    final products = items?.map((product) => product.toJson()).toList() ?? [];
    final data = {
      if (id != null) "id": id,
      if (name != null) "name": name,
      if (objects != null) "objects": objs,
      if (items != null) "items": products,
      if (visible != null) "visible": visible,
    };
    return data;
  }

  Store copyWith({
    String? id,
    String? name,
    List<Product>? items,
    List<CanvObj>? objects,
    bool? visible,
  }) {
    return Store(
      id: id ?? this.id,
      name: name ?? this.name,
      items: items ?? this.items,
      objects: objects ?? this.objects,
      visible: visible ?? this.visible,
    );
  }

  @override
  String toString() {
    return 'Store id: $id - name: $name - objects: ${objects?.length} - items: ${items?.length} - visible: $visible';
  }

  @override
  List<Object?> get props => [id, name, items, objects, visible];
}
