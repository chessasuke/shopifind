import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/common/text/text_style.dart';
import 'package:shopifind/store_editor/controller/objects_controller.dart';
import 'package:shopifind/store_editor/widgets/object_editor/object_editor.dart';
import 'package:shopifind/store_editor/widgets/object_editor/object_editor_text_input.dart';

class ObjectEditorTransformation extends ConsumerWidget {
  const ObjectEditorTransformation({
    required this.label,
    required this.onChange,
    required this.transformation,
    this.height = 35,
    this.width = 38,
    Key? key,
  }) : super(key: key);

  final String label;
  final Function(String) onChange;
  final TransformationType transformation;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Text(label,
            style: TextStyles.body01.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(width: 2),
        EditorTextInput(
          key: ValueKey(transformation),
          height: height,
          width: width,
          initialValue: getInitialValue(ref),
          onChange: onChange,
        ),
      ],
    );
  }

  String getInitialValue(WidgetRef ref) {
    switch (transformation) {
      case TransformationType.verticalTranslation:
        return ref.watch(objectsControllerProvider.select((value) =>
            value.selectedObject?.position.dx.toStringAsFixed(0) ?? ''));

      case TransformationType.horizontalTranslation:
        return ref.watch(objectsControllerProvider.select((value) =>
            value.selectedObject?.position.dy.toStringAsFixed(0) ?? ''));

      case TransformationType.heightScaling:
        return ref.watch(objectsControllerProvider.select(
            (value) => value.selectedObject?.height.toStringAsFixed(0) ?? ''));

      case TransformationType.widthScaling:
        return ref.watch(objectsControllerProvider.select(
            (value) => value.selectedObject?.width.toStringAsFixed(0) ?? ''));
      default:
        return ref.watch(objectsControllerProvider
            .select((value) => value.selectedObject?.description ?? ''));
    }
  }
}
