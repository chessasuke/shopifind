import 'package:shopifind/common/constants/display_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/screen_store_editor/controller/objects_controller.dart';
import 'package:shopifind/screen_store_editor/controller/store_controller.dart';
import 'package:shopifind/screen_store_editor/model/canv_obj.dart';
import 'package:shopifind/screen_store_editor/model/canvas_object_type.dart';
import 'package:shopifind/screen_store_editor/widgets/sidebar/object_editor/object_editor_border_radius.dart';
import 'package:shopifind/screen_store_editor/widgets/sidebar/object_editor/object_editor_color_properties.dart';
import 'package:shopifind/screen_store_editor/widgets/sidebar/object_editor/object_editor_name.dart';
import 'package:shopifind/screen_store_editor/widgets/sidebar/object_editor/object_editor_id_fields.dart';
import 'package:shopifind/screen_store_editor/widgets/sidebar/object_editor/object_editor_transformation.dart';

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
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          /// Id
          const SizedBox(
            height: 100,
            child: ObjectEditorIdField(),
          ),

          /// Translation
          Column(
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
                    transformation: TransformationType.horizontalTranslation,
                    label: 'dy',
                    onChange: (value) => _onChangeTranslation(
                      value: value,
                      ref: ref,
                      isDx: false,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              /// Scaling
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ObjectEditorTransformation(
                    transformation: TransformationType.widthScaling,
                    label: 'w',
                    onChange: (value) => _onChangeScaling(
                      value: value,
                      ref: ref,
                      isWidth: true,
                    ),
                  ),
                  ObjectEditorTransformation(
                    transformation: TransformationType.heightScaling,
                    label: 'h',
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

          /// Color properties: fill
          ObjectEditorColorProperties(
            key: const ValueKey(ObjectEditorColorProperty.fillColor),
            colorProperty: ObjectEditorColorProperty.fillColor,
            onColorChanged: (color) => _onFillColorChanged(color, ref),
          ),

          /// Color properties: border
          ObjectEditorColorProperties(
            key: const ValueKey(ObjectEditorColorProperty.borderColor),
            colorProperty: ObjectEditorColorProperty.borderColor,
            onColorChanged: (color) => _onBorderColorChanged(color, ref),
          ),

          /// Name (only for section objects)
          ObjectEditorName(
            onChange: (value) => _onChangeName(
              value: value,
              ref: ref,
            ),
          ),

          /// BorderRadius (only for section/store objects)
          const ObjectEditorBorderRadius(),
        ],
      ),
    );
  }

  void _onChangeName({required String value, required WidgetRef ref}) {
    final selectedCanvObj =
        ref.read(objectsControllerProvider.notifier).selectedObject;

    if (selectedCanvObj != null) {
      if (selectedCanvObj.objType == ObjectType.section) {
        if (value.isNotEmpty || value != '') {
          ref
              .read(objectsControllerProvider.notifier)
              .updateObj(selectedCanvObj.copyWith(name: value));
        }
      } 
      // else if (selectedCanvObj.objType == ObjectType.store) {
      //   final selectedStore =
      //       ref.read(storesControllerProvider.notifier).selectedStore;

      //   print('==== selectedStore: $selectedStore');

      //   if (selectedStore != null) {
      //     ref
      //         .read(storesControllerProvider.notifier)
      //         .editStore(newStore: selectedStore.copyWith(name: value));
      //   }
      // }
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
      final newValue = double.tryParse(value);
      if (newValue != null && newValue > 30) {
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

  void _onChangeTranslation({
    required String value,
    required WidgetRef ref,
    required bool isDx,
  }) {
    final selectedCanvObj =
        ref.read(objectsControllerProvider.notifier).selectedObject;

    final newValue = double.tryParse(value);

    if (newValue != null && selectedCanvObj != null) {
      if (value.isNotEmpty && value != '') {
        ref.read(objectsControllerProvider.notifier).updateObj(
              selectedCanvObj.copyWith(
                  position: isDx
                      ? [newValue, selectedCanvObj.position.last]
                      : [selectedCanvObj.position.first, newValue]),
            );
      }
    }
  }

  void _onBorderColorChanged(Color color, WidgetRef ref) {
    final CanvObj? selectedCanvObj =
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
          .updateObj(selectedCanvObj.copyWith(fillColor: color.value));
    }
  }
}
