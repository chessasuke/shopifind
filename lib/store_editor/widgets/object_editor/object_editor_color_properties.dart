import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/common/text/text_style.dart';
import 'package:shopifind/store_editor/controller/objects_controller.dart';

enum ObjectEditorColorProperty {
  borderColor,
  fillColor;

  String getLabel() {
    switch (this) {
      case ObjectEditorColorProperty.borderColor:
        return 'Border Color';
      case ObjectEditorColorProperty.fillColor:
        return 'Fill Color';
    }
  }
}

class ObjectEditorColorProperties extends ConsumerWidget {
  const ObjectEditorColorProperties({
    required this.onColorChanged,
    required this.colorProperty,
    Key? key,
  }) : super(key: key);

  final Function(Color) onColorChanged;
  final ObjectEditorColorProperty colorProperty;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(
      objectsControllerProvider.select(
        (value) {
          switch (colorProperty) {
            case ObjectEditorColorProperty.borderColor:
              if (value.selectedObject?.objType.isSectionObject == true) {
                return value.selectedObject?.borderColor;
              } else {
                return null;
              }
            case ObjectEditorColorProperty.fillColor:
              return value.selectedObject?.fillColor;
          }
        },
      ),
    );

    return SizedBox(
      height: 40,
      child: color != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  colorProperty.getLabel(),
                  style:
                      TextStyles.body01.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 16),
                WidgetColorPicker(
                  pickerColor: Color(color),
                  onColorChanged: onColorChanged,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: Color(color),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : null,
    );
  }
}

class WidgetColorPicker extends StatelessWidget {
  const WidgetColorPicker({
    Key? key,
    required this.pickerColor,
    required this.child,
    required this.onColorChanged,
  }) : super(key: key);

  final Color pickerColor;
  final Widget child;
  final ValueChanged<Color> onColorChanged;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Color>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              enabled: false,
              child: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: pickerColor,
                  portraitOnly: true,
                  onColorChanged: onColorChanged,
                  pickerAreaBorderRadius: BorderRadius.circular(15),
                  pickerAreaHeightPercent: 0.8,
                ),
              ),
            ),
          ];
        },
        child: child);
  }
}
