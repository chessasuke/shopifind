import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/common/constants/display_properties.dart';
import 'package:shopifind/common/text/text_style.dart';
import 'package:shopifind/store_editor/controller/objects_controller.dart';
import 'package:shopifind/store_editor/widgets/object_editor/object_editor_text_input.dart';

class ObjectEditorDimension extends ConsumerWidget {
  const ObjectEditorDimension({
    required this.label,
    required this.onChange,
    this.height = 35,
    Key? key,
  }) : super(key: key);

  final String label;
  final Function(String) onChange;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text(label,
            style: TextStyles.body01.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        EditorTextInput(
          key: ValueKey(label),
          height: height,
          width: DisplayProperties.sidebarWidth * 0.8 - 8,
          initialValue: getInitialValue(ref),
          onChange: onChange,
        ),
      ],
    );
  }

  String getInitialValue(WidgetRef ref) {
    return ref.watch(objectsControllerProvider
        .select((value) => value.selectedObject?.description ?? ''));
  }
}
