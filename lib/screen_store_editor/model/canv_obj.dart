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
    required this.name,
    required this.position,
    required this.width,
    required this.objType,
    required this.fillColor,
    required this.borderColor,
    required this.cornerRadius,
    this.isLocked = false,
  });

  final String id;
  final String name;
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
    String? name,
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
      name: name ?? this.name,
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
        name: objectType.getTooltipMsg(),
        isLocked: false,
        fillColor: AppColors.primary100.value,
        borderColor: AppColors.primary100.value,
        objType: objectType,
        cornerRadius: 0,
      );

  @override
  List<Object?> get props => [id, position, height, width];
}