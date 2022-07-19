import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product extends Equatable {
  const Product({
    required this.id,
    required this.description,
    required this.sectionId,
    required this.price,
  });
  final String id;
  final String description;
  final double price;
  final String sectionId;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  Product copyWith({
    String? id,
    String? description,
    String? sectionId,
    double? price,
    bool? isPublished,
  }) {
    return Product(
      id: id ?? this.id,
      description: description ?? this.description,
      sectionId: sectionId ?? this.sectionId,
      price: price ?? this.price,
    );
  }

  @override
  List<Object?> get props => [id, description, sectionId, price];
}
