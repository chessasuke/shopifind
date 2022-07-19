// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'canv_obj.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CanvObj _$CanvObjFromJson(Map<String, dynamic> json) => CanvObj(
      id: json['id'] as String,
      height: (json['height'] as num).toDouble(),
      name: json['name'] as String,
      position: (json['position'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      width: (json['width'] as num).toDouble(),
      objType: $enumDecode(_$ObjectTypeEnumMap, json['objType']),
      fillColor: json['fillColor'] as int,
      borderColor: json['borderColor'] as int,
      cornerRadius: (json['cornerRadius'] as num).toDouble(),
      isLocked: json['isLocked'] as bool? ?? false,
    );

Map<String, dynamic> _$CanvObjToJson(CanvObj instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'width': instance.width,
      'height': instance.height,
      'position': instance.position,
      'objType': _$ObjectTypeEnumMap[instance.objType]!,
      'isLocked': instance.isLocked,
      'fillColor': instance.fillColor,
      'borderColor': instance.borderColor,
      'cornerRadius': instance.cornerRadius,
    };

const _$ObjectTypeEnumMap = {
  ObjectType.entry: 'entry',
  ObjectType.info: 'info',
  ObjectType.checkout: 'checkout',
  ObjectType.restroom: 'restroom',
  ObjectType.section: 'section',
  ObjectType.store: 'store',
};
