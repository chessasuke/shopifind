import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  const ProductModel({
    required this.id,
    required this.description,
    required this.sectionId,
    required this.price,
  });
  final String id;
  final String description;
  final double price;
  final String sectionId;

  ProductModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        description = json['description'],
        sectionId = json['sectionId'],
        price = json['price'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'sectionId': sectionId,
        'price': price,
      };

  ProductModel copyWith({
    String? id,
    String? description,
    String? sectionId,
    double? price,
    bool? isPublished,
  }) {
    return ProductModel(
      id: id ?? this.id,
      description: description ?? this.description,
      sectionId: sectionId ?? this.sectionId,
      price: price ?? this.price,
    );
  }

  @override
  List<Object?> get props => [id, description, sectionId, price];
}
