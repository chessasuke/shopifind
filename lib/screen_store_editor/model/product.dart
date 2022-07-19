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

    factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

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

  // Product.fromJson(Map<String, dynamic> json)
  //     : id = json['id'] as String,
  //       description = json['description'] as String,
  //       sectionId = json['sectionId'] as String,
  //       price = json['price'] as double;

  // Map<String, dynamic> toJson() => {
  //       'id': id,
  //       'description': description,
  //       'sectionId': sectionId,
  //       'price': price,
  //     };


  @override
  List<Object?> get props => [id, description, sectionId, price];
}
