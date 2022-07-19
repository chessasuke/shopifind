import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/common/constants/display_properties.dart';
import 'package:shopifind/screen_store_editor/controller/objects_controller.dart';
import 'package:shopifind/screen_store_editor/model/canvas_object_type.dart';
import 'package:shopifind/screen_store_editor/widgets/sidebar/object_editor/object_editor_text_input.dart';


class ObjectEditorDimension extends ConsumerWidget {
  const ObjectEditorDimension({
    required this.onChange,
    Key? key,
  }) : super(key: key);

  final Function(String) onChange;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialValue = getInitialValue(ref);

    return SizedBox(
      height: DisplayProperties.sidebarToolsSizedBoxHeight,
      child: initialValue != null
          ? EditorTextInput(
              key: const ValueKey('Description'),
              width: DisplayProperties.sidebarTextInputDescriptionWidth,
              initialValue: initialValue,
              onChange: onChange,
              labelText: 'Description',
            )
          : null,
    );
  }

  String? getInitialValue(WidgetRef ref) {
    return ref.watch(objectsControllerProvider.select((value) {
      if (value.selectedObject?.objType == ObjectType.section) {
        return value.selectedObject?.description;
      }
    }));
  }
}
