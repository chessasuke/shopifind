import 'package:shopifind/common/constants/app_colors.dart';
import 'package:shopifind/common/constants/display_properties.dart';
import 'package:shopifind/store_editor/controller/objects_controller.dart';
import 'package:shopifind/store_editor/model/canv_obj.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/store_editor/widgets/object_editor/object_editor_color_properties.dart';
import 'package:shopifind/store_editor/widgets/object_editor/object_editor_description.dart';
import 'package:shopifind/store_editor/widgets/object_editor/object_editor_id_fields.dart';
import 'package:shopifind/store_editor/widgets/object_editor/object_editor_transformation.dart';

enum TransformationType {
  verticalTranslation,
  horizontalTranslation,
  heightScaling,
  widthScaling,
}

class ObjectEditor extends ConsumerStatefulWidget {
  const ObjectEditor({Key? key}) : super(key: key);

  @override
  ConsumerState<ObjectEditor> createState() => _ObjectEditorState();
}

class _ObjectEditorState extends ConsumerState<ObjectEditor> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: DisplayProperties.sidebarWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 100,
              child: ObjectEditorIdField(),
            ),
            SizedBox(
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ObjectEditorTransformation(
                        transformation: TransformationType.verticalTranslation,
                        label: 'dx',
                        onChange: (value) => _onChangeTranslation(
                          value: value,
                          ref: ref,
                          isDx: true,
                        ),
                      ),
                      ObjectEditorTransformation(
                        transformation:
                            TransformationType.horizontalTranslation,
                        label: 'dy',
                        onChange: (value) => _onChangeTranslation(
                          value: value,
                          ref: ref,
                          isDx: false,
                        ),
                      ),
                    ],
                  ),

                  /// Scaling
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ObjectEditorTransformation(
                        transformation: TransformationType.widthScaling,
                        label: ' w',
                        onChange: (value) => _onChangeScaling(
                          value: value,
                          ref: ref,
                          isWidth: true,
                        ),
                      ),
                      ObjectEditorTransformation(
                        transformation: TransformationType.heightScaling,
                        label: ' h',
                        onChange: (value) => _onChangeScaling(
                          value: value,
                          ref: ref,
                          isWidth: false,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 70,
              child: ObjectEditorDimension(
                label: 'Description',
                onChange: (value) => _onChangeDescription(
                  value: value,
                  ref: ref,
                ),
              ),
            ),
            ObjectEditorColorProperties(
              key: const ValueKey(ObjectEditorColorProperty.borderColor),
              colorProperty: ObjectEditorColorProperty.borderColor,
              onColorChanged: (color) => _onBorderColorChanged(color, ref),
            ),
            ObjectEditorColorProperties(
              key: const ValueKey(ObjectEditorColorProperty.fillColor),
              colorProperty: ObjectEditorColorProperty.fillColor,
              onColorChanged: (color) => _onFillColorChanged(color, ref),
            ),
            const EditorCorner(),
          ],
        ),
      ),
    );
  }

  void _onChangeDescription({required String value, required WidgetRef ref}) {
    final selectedCanvObj =
        ref.read(objectsControllerProvider.notifier).selectedObject;

    if (selectedCanvObj != null) {
      if (value.isNotEmpty || value != '') {
        ref
            .read(objectsControllerProvider.notifier)
            .updateObj(selectedCanvObj.copyWith(description: value));
      }
    }
  }

  void _onChangeScaling({
    required String value,
    required WidgetRef ref,
    required bool isWidth,
  }) {
    final selectedCanvObj =
        ref.read(objectsControllerProvider.notifier).selectedObject;
    if (selectedCanvObj != null) {
      if (value.isEmpty || value == '') {
        ref
            .read(objectsControllerProvider.notifier)
            .updateObj(selectedCanvObj.copyWith(height: 30, width: 30));
      } else {
        double newValue = double.parse(value);
        if (newValue > 30) {
          isWidth
              ? ref.read(objectsControllerProvider.notifier).updateObj(
                    selectedCanvObj.copyWith(width: newValue),
                  )
              : ref.read(objectsControllerProvider.notifier).updateObj(
                    selectedCanvObj.copyWith(height: newValue),
                  );
        }
      }
    }
  }

  void _onChangeTranslation({
    required String value,
    required WidgetRef ref,
    required bool isDx,
  }) {
    final selectedCanvObj =
        ref.read(objectsControllerProvider.notifier).selectedObject;

    if (selectedCanvObj != null) {
      if (value.isNotEmpty && value != '') {
        ref.read(objectsControllerProvider.notifier).updateObj(
              selectedCanvObj.copyWith(
                position: isDx
                    ? Position(
                        dx: double.parse(value),
                        dy: selectedCanvObj.position.dy,
                      )
                    : Position(
                        dx: selectedCanvObj.position.dy,
                        dy: double.parse(value),
                      ),
              ),
            );
      } else {
        ref.read(objectsControllerProvider.notifier).updateObj(
              selectedCanvObj.copyWith(
                position: Position(
                  dx: 0,
                  dy: 0,
                ),
              ),
            );
      }
    }
  }

  void _onBorderColorChanged(Color color, WidgetRef ref) {
    print('======== _onBorderColorChanged: $color');
    final selectedCanvObj =
        ref.read(objectsControllerProvider.notifier).selectedObject;
    if (selectedCanvObj != null) {
      ref
          .read(objectsControllerProvider.notifier)
          .updateObj(selectedCanvObj.copyWith(borderColor: color.value));
    }
  }

  void _onFillColorChanged(color, WidgetRef ref) {
    final selectedCanvObj =
        ref.read(objectsControllerProvider.notifier).selectedObject;
    if (selectedCanvObj != null) {
      ref
          .read(objectsControllerProvider.notifier)
          .updateObj(selectedCanvObj.copyWith(color: color.value));
    }
  }
}

class EditorCorner extends ConsumerWidget {
  const EditorCorner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final borderRadius = ref.watch(objectsControllerProvider
        .select((value) => value.selectedObject?.cornerRadius));

    return borderRadius != null
        ? Slider(
            activeColor: AppColors.primary100,
            inactiveColor: AppColors.secondary100,
            max: 90,
            value: borderRadius.roundToDouble(),
            onChanged: (value) => _onBorderRadiusChanged(value, ref),
          )
        : const SizedBox(
            height: 40,
          );
  }

  void _onBorderRadiusChanged(double value, WidgetRef ref) {
    print('======== _onBorderRadiusChanged: $value');
    final selectedCanvObj =
        ref.read(objectsControllerProvider.notifier).selectedObject;
    if (selectedCanvObj != null) {
      ref
          .read(objectsControllerProvider.notifier)
          .updateObj(selectedCanvObj.copyWith(cornerRadius: value));
    }
  }
}
