import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product extends Equatable {
  const Product({
    required this.id,
    required this.name,
    required this.sectionId,
    required this.price,
  });
  final String id;
  final String name;
  final double price;
  final String sectionId;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  Product copyWith({
    String? id,
    String? name,
    String? sectionId,
    double? price,
    bool? isPublished,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      sectionId: sectionId ?? this.sectionId,
      price: price ?? this.price,
    );
  }

  @override
  List<Object?> get props => [id, name, sectionId, price];
}
