// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Store _$StoreFromJson(Map<String, dynamic> json) => Store(
      id: json['id'] as String?,
      description: json['description'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      objects: (json['layout'] as List<dynamic>?)
          ?.map((e) => CanvObj.fromJson(e as Map<String, dynamic>))
          .toList(),
      visible: json['visible'] as bool?,
    );

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'layout': instance.objects?.map((e) => e.toJson()).toList(),
      'items': instance.items?.map((e) => e.toJson()).toList(),
      'visible': instance.visible,
    };
