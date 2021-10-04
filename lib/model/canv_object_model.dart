import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class CanvObjectModel extends Equatable {
  const CanvObjectModel({
    required this.id,
    required this.height,
    required this.name,
    required this.position,
    required this.width,
    required this.objType,
    required this.backgroundColor,
    required this.borderColor,
    required this.cornerRadius,
    this.isLocked = false,
    this.isSelected = false,
  });

  final String id;
  final String name;
  final double width;
  final double height;
  final Offset position;
  final bool isSelected;
  final ObjectType objType;
  final bool isLocked;
  final Color backgroundColor;
  final Color borderColor;
  final double cornerRadius;
  // final Widget? child;

  factory CanvObjectModel.initial() => CanvObjectModel(
        height: 100,
        id: Utils.generateId(),
        position: Offset.zero,
        width: 100,
        name: 'Section',
        // simpleResize: true,
        objType: ObjectType.section,
        backgroundColor: Colors.grey,
        borderColor: Colors.blueGrey,
        cornerRadius: 0,
      );

  factory CanvObjectModel.fromJson(Map<String, dynamic> json) {
    final double dx = json['dx'];
    final double dy = json['dy'];
    final ObjectType objTypeFromString = Utils.stringToObjType(json['objType']);
    final int backgroundColor = json['backgroundColor'];
    final int borderColor = json['borderColor'];

    return CanvObjectModel(
      id: json['id'],
      name: json['name'],
      width: json['width'],
      height: json['height'],
      objType: objTypeFromString,
      cornerRadius: json['cornerRadius'],
      backgroundColor: Color(backgroundColor),
      borderColor: Color(borderColor),
      position: Offset(dx, dy),
    );
  }

  Map<String, dynamic> toJson() {
    final double dx = position.dx;
    final double dy = position.dy;
    final String stringFromObjType = Utils.objTypeToString(objType);
    final int intFromBackgroundColor = backgroundColor.value;
    final int intFromBorderColor = borderColor.value;

    return {
      'id': id,
      'name': name,
      'width': width,
      'height': height,
      'dx': dx,
      'dy': dy,
      'objType': stringFromObjType,
      'cornerRadius': cornerRadius,
      'backgroundColor': intFromBackgroundColor,
      'borderColor': intFromBorderColor,
    };
  }

  CanvObjectModel copyWith({
    String? id,
    Offset? position,
    double? width,
    double? height,
    bool? isLocked,
    bool? isSelected,
    String? name,
    bool? simpleResize,
    Color? backgroundColor,
    Color? borderColor,
    ObjectType? objType,
    double? cornerRadius,
  }) {
    return CanvObjectModel(
      id: id ?? this.id,
      position: position ?? this.position,
      width: width ?? this.width,
      height: height ?? this.height,
      // child: child ?? this.child,
      objType: objType ?? this.objType,
      isSelected: isSelected ?? this.isSelected,
      name: name ?? this.name,
      isLocked: isLocked ?? this.isLocked,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      cornerRadius: cornerRadius ?? this.cornerRadius,
    );
  }

  Size get size => Size(width, height);
  Offset get offset => position;
  Rect get rect => offset & size;

  @override
  List<Object?> get props => [id, position, height, width];
}
