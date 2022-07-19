import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/common/constants/display_properties.dart';
import 'package:shopifind/screen_store_editor/controller/objects_controller.dart';
import 'package:shopifind/common/widgets/basic_text_field.dart';
import 'package:shopifind/screen_store_editor/model/canvas_object_type.dart';

class ObjectEditorName extends ConsumerWidget {
  const ObjectEditorName({
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
          ? BasicTextField(
              key: const ValueKey('Name'),
              width: DisplayProperties.sidebarTextInputDescriptionWidth,
              initialValue: initialValue,
              onChange: onChange,
              labelText: 'Name',
            )
          : null,
    );
  }

  String? getInitialValue(WidgetRef ref) {
    return ref.watch(objectsControllerProvider.select((value) {
      if (value.selectedObject?.objType == ObjectType.section) {
        // if (value.selectedObject?.objType.isSectionObject == true) {
        return value.selectedObject?.name;
      } else {
        return null;
      }
    }));
  }
}
