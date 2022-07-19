import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/common/constants/display_properties.dart';
import 'package:shopifind/screen_store_editor/controller/objects_controller.dart';
import 'package:shopifind/screen_store_editor/widgets/sidebar/object_editor/object_editor.dart';
import 'package:shopifind/common/widgets/basic_text_field.dart';

class ObjectEditorTransformation extends ConsumerWidget {
  const ObjectEditorTransformation({
    required this.label,
    required this.onChange,
    required this.transformation,
    Key? key,
  }) : super(key: key);

  final String label;
  final Function(String) onChange;
  final TransformationType transformation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialValue = getInitialValue(ref);

    return SizedBox(
      height: DisplayProperties.sidebarToolsSizedBoxHeight,
      child: initialValue != null
          ? BasicTextField(
              key: ValueKey(transformation),
              width: 60,
              initialValue: initialValue,
              labelText: label,
              onChange: onChange,
            )
          : null,
    );
  }

  String? getInitialValue(WidgetRef ref) {
    switch (transformation) {
      case TransformationType.verticalTranslation:
        return ref.watch(
          objectsControllerProvider.select(
            (value) => value.selectedObject?.position.first.toStringAsFixed(0),
          ),
        );

      case TransformationType.horizontalTranslation:
        return ref.watch(
          objectsControllerProvider.select(
            (value) => value.selectedObject?.position.last.toStringAsFixed(0),
          ),
        );

      case TransformationType.heightScaling:
        return ref.watch(
          objectsControllerProvider.select(
            (value) => value.selectedObject?.height.toStringAsFixed(0),
          ),
        );

      case TransformationType.widthScaling:
        return ref.watch(
          objectsControllerProvider.select(
            (value) => value.selectedObject?.width.toStringAsFixed(0),
          ),
        );
    }
  }
}
