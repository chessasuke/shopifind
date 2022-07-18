// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'canv_obj.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CanvObj _$CanvObjFromJson(Map<String, dynamic> json) => CanvObj(
      id: json['id'] as String,
      height: (json['height'] as num).toDouble(),
      description: json['description'] as String,
      position: Position.fromJson(json['position'] as Map<String, dynamic>),
      width: (json['width'] as num).toDouble(),
      objType: $enumDecode(_$ObjectTypeEnumMap, json['objType']),
      color: json['color'] as int,
      borderColor: json['borderColor'] as int,
      cornerRadius: (json['cornerRadius'] as num).toDouble(),
      isLocked: json['isLocked'] as bool? ?? false,
    );

Map<String, dynamic> _$CanvObjToJson(CanvObj instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'width': instance.width,
      'height': instance.height,
      'position': instance.position,
      'objType': _$ObjectTypeEnumMap[instance.objType]!,
      'isLocked': instance.isLocked,
      'color': instance.color,
      'borderColor': instance.borderColor,
      'cornerRadius': instance.cornerRadius,
    };

const _$ObjectTypeEnumMap = {
  ObjectType.store: 'store',
  ObjectType.section: 'section',
  ObjectType.info: 'info',
  ObjectType.checkout: 'checkout',
  ObjectType.restroom: 'restroom',
  ObjectType.entry: 'entry',
};

Position _$PositionFromJson(Map<String, dynamic> json) => Position(
      dx: (json['x'] as num).toDouble(),
      dy: (json['y'] as num).toDouble(),
    );

Map<String, dynamic> _$PositionToJson(Position instance) => <String, dynamic>{
      'x': instance.dx,
      'y': instance.dy,
    };
