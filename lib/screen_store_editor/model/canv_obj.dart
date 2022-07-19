import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shopifind/common/constants/app_colors.dart';
import 'package:shopifind/common/constants/display_properties.dart';
import 'package:shopifind/screen_store_editor/model/canvas_object_type.dart';
import 'package:uuid/uuid.dart';

part 'canv_obj.g.dart';

@JsonSerializable()
class CanvObj extends Equatable {
  const CanvObj({
    required this.id,
    required this.height,
    required this.description,
    required this.position,
    required this.width,
    required this.objType,
    required this.fillColor,
    required this.borderColor,
    required this.cornerRadius,
    this.isLocked = false,
  });

  final String id;
  final String description;
  final double width;
  final double height;
  final List<double> position;
  final ObjectType objType;
  final bool isLocked;
  final int fillColor;
  final int borderColor;
  final double cornerRadius;

  factory CanvObj.fromJson(Map<String, dynamic> json) =>
      _$CanvObjFromJson(json);

  Map<String, dynamic> toJson() => _$CanvObjToJson(this);

  CanvObj copyWith({
    String? id,
    List<double>? position,
    double? width,
    double? height,
    bool? isLocked,
    String? description,
    int? fillColor,
    int? borderColor,
    ObjectType? objType,
    double? cornerRadius,
  }) {
    return CanvObj(
      id: id ?? this.id,
      position: position ?? this.position,
      width: width ?? this.width,
      height: height ?? this.height,
      description: description ?? this.description,
      isLocked: isLocked ?? this.isLocked,
      fillColor: fillColor ?? this.fillColor,
      borderColor: borderColor ?? this.borderColor,
      objType: objType ?? this.objType,
      cornerRadius: cornerRadius ?? this.cornerRadius,
    );
  }

  factory CanvObj.initial(ObjectType objectType) => CanvObj(
        id: const Uuid().v4(),
        height: 60,
        position: const [0, DisplayProperties.topbarHeight],
        width: 60,
        description: objectType.getTooltipMsg(),
        isLocked: false,
        fillColor: AppColors.primary100.value,
        borderColor: AppColors.primary100.value,
        objType: objectType,
        cornerRadius: 0,
      );

  // factory CanvasObject.fromJson(Map<String, dynamic> json) {
  //   // print(
  //   //     "id: ${json['id']} |types: json['dx']: ${json['dx'].runtimeType} | json['dy']: ${json['dy'].runtimeType} | json['backgroundColor']: ${json['backgroundColor'].runtimeType} | json['borderColor']: ${json['borderColor'].runtimeType}  |  json['objType']: ${json['objType'].runtimeType}");

  //   final double dx = json['dx'] as double;
  //   final double dy = json['dy'] as double;
  //   final ObjectType objTypeFromString =
  //       Utils.stringToObjType(json['objType'] as String);
  //   final int backgroundColor = json['backgroundColor'] as int;
  //   final int borderColor = json['borderColor'] as int;

  //   return CanvasObject(
  //       id: json['id'] as String,
  //       description: json['name'] as String,
  //       width: json['width'] as double,
  //       height: json['height'] as double,
  //       objType: objTypeFromString,
  //       cornerRadius: json['cornerRadius'] as double,
  //       backgroundColor: Color(backgroundColor),
  //       borderColor: Color(borderColor),
  //       position: Offset(dx, dy));
  // }

  // Map<String, dynamic> toJson() {
  //   final double dx = position.dx;
  //   final double dy = position.dy;
  //   final String stringFromObjType = objType.name;
  //   final int intFromBackgroundColor = backgroundColor.value;
  //   final int intFromBorderColor = borderColor.value;

  //   return {
  //     'id': id,
  //     'name': description,
  //     'width': width,
  //     'height': height,
  //     'dx': dx,
  //     'dy': dy,
  //     'objType': stringFromObjType,
  //     'cornerRadius': cornerRadius,
  //     'backgroundColor': intFromBackgroundColor,
  //     'borderColor': intFromBorderColor,
  //   };
  // }

  // Size get size => Size(width, height);
  // Offset get offset => position;
  // Rect get rect => offset & size;

  @override
  List<Object?> get props => [id, position, height, width];
}

// @JsonSerializable()
// class Position {
//   Position({
//     required this.dx,
//     required this.dy,
//   });

//   double dx;
//   double dy;

//   factory Position.fromJson(Map<String, dynamic> json) =>
//       _$PositionFromJson(json);

//   Map<String, dynamic> toJson() => _$PositionToJson(this);

//   factory Position.initial() =>
//       Position(dx: 0, dy: DisplayProperties.topbarHeight + 20);
// }
