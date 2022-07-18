import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/common/constants/app_colors.dart';
import 'package:shopifind/store_editor/controller/objects_controller.dart';
import 'package:shopifind/store_editor/model/canvas_object_type.dart';

class ObjectEditorBorderRadius extends ConsumerWidget {
  const ObjectEditorBorderRadius({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final borderRadius = getBorderRadius(ref);

    return SizedBox(
      height: 40,
      child: borderRadius != null
          ? Slider(
              activeColor: AppColors.primary100,
              inactiveColor: AppColors.secondary100,
              max: 90,
              value: borderRadius.roundToDouble(),
              onChanged: (value) => _onBorderRadiusChanged(value, ref),
            )
          : null,
    );
  }

  double? getBorderRadius(WidgetRef ref) {
    return ref.watch(objectsControllerProvider.select((value) {
      if (value.selectedObject?.objType == ObjectType.section) {
        return value.selectedObject?.cornerRadius;
      }
    }));
  }

  void _onBorderRadiusChanged(double value, WidgetRef ref) {
    final selectedCanvObj =
        ref.read(objectsControllerProvider.notifier).selectedObject;
    if (selectedCanvObj != null) {
      ref
          .read(objectsControllerProvider.notifier)
          .updateObj(selectedCanvObj.copyWith(cornerRadius: value));
    }
  }
}
