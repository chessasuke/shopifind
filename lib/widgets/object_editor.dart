import 'package:shopifind/controller/objects_providers.dart';
import 'package:shopifind/model/canv_object_model.dart';
import 'package:shopifind/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ObjectEditor extends ConsumerWidget {
  const ObjectEditor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final selectedObject = watch(selectedObjectProvider).state;

    return selectedObject == null
        ? const SizedBox(
            height: 225,
            width: 150,
          )
        : SizedBox(
            width: 150,
            child: Column(
              mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SelectableText(
                      'ID: ${selectedObject.id}',
                      cursorColor:
                          Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
            
                  /// Lock and Trash
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [Tooltip(
                            message: 'Delete',
                            child: DeleteObject()), Tooltip
                            (
                              message: 'Lock',
                              child: LockObject()),])),
            
                  if (selectedObject.objType == ObjectType.section)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text('Name:'),
                          EditorTextInput(
                              key: UniqueKey(),
                              selectedObject: selectedObject,
                              width: 90,
                              height: 35,
                              initialValue: selectedObject.name,
                              onChange: (value) {
                                if (value.isNotEmpty || value != '') {
                                  context
                                      .read(objsControllerProvider.notifier)
                                      .updateName(value, selectedObject.id);
                                }
                              }),
                        ],
                      ),
                    ),
            
                  /// border Color
                  if (selectedObject.objType == ObjectType.section ||
                      selectedObject.objType == ObjectType.store)
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 32.0),
                                child: Text('Border:'),
                              ),
                              BorderColorPicker(selectedObject: selectedObject)
                            ]))
                  else
                    const SizedBox(
                      height: 55,
                    ),
            
                  /// Background Color
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Background:'),
                            BackgroundColorPicker(
                                selectedObject: selectedObject)
                          ])),
            
                  /// Translation dx/dy
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('dx:'),
                            EditorTextInput(
                                key: UniqueKey(),
                                selectedObject: selectedObject,
                                width: 38,
                                height: 35,
                                initialValue: selectedObject.position.dx,
                                onChange: (value) {
                                  if (value.isEmpty || value == '') {
                                    context
                                        .read(objsControllerProvider.notifier)
                                        .updatePosition(
                                            id: selectedObject.id, dx: 0);
                                  } else {
                                    context
                                        .read(objsControllerProvider.notifier)
                                        .updatePosition(
                                            id: selectedObject.id,
                                            dx: double.parse(value));
                                  }
                                }),
                            const Text('dy:'),
                            EditorTextInput(
                                key: UniqueKey(),
                                selectedObject: selectedObject,
                                width: 38,
                                height: 35,
                                initialValue: selectedObject.position.dy,
                                onChange: (value) {
                                  if (value.isEmpty || value == '') {
                                    context
                                        .read(objsControllerProvider.notifier)
                                        .updatePosition(
                                            id: selectedObject.id, dy: 0);
                                  } else {
                                    context
                                        .read(objsControllerProvider.notifier)
                                        .updatePosition(
                                            id: selectedObject.id,
                                            dy: double.parse(value));
                                  }
                                }),
                          ])),
            
                  /// Width/Height
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            /// width
                            const Text('w:'),
                            EditorTextInput(
                                key: UniqueKey(),
                                selectedObject: selectedObject,
                                width: 38,
                                height: 35,
                                initialValue: selectedObject.width,
                                onChange: (value) {
                                  if (value.isEmpty || value == '') {
                                    context
                                        .read(objsControllerProvider.notifier)
                                        .updateWidth(30, selectedObject.id);
                                    context
                                        .read(objsControllerProvider.notifier)
                                        .updateHeight(30, selectedObject.id);
                                  } else {
                                    double newValue = double.parse(value);
                                    if (newValue < 30) newValue = 30;
                                    context
                                        .read(objsControllerProvider.notifier)
                                        .updateWidth(
                                            newValue, selectedObject.id);
                                    context
                                        .read(objsControllerProvider.notifier)
                                        .updateHeight(
                                            newValue, selectedObject.id);
                                  }
                                  // context.read(objectSelectedProvider).state =
                                  //     context
                                  //         .read(objProvider.notifier)
                                  //         .selectObj(selectedObject.id);
                                }),
            
                            /// height
                            const Text('h:'),
                            EditorTextInput(
                              key: UniqueKey(),
                              selectedObject: selectedObject,
                              width: 38,
                              height: 35,
                              initialValue: selectedObject.height,
                              onChange: (value) {
                                if (value.isEmpty || value == '') {
                                  context
                                      .read(objsControllerProvider.notifier)
                                      .updateHeight(30, selectedObject.id);
                                  context
                                      .read(objsControllerProvider.notifier)
                                      .updateWidth(30, selectedObject.id);
                                } else {
                                  double newValue = double.parse(value);
                                  if (newValue < 30) newValue = 30;
                                  context
                                      .read(objsControllerProvider.notifier)
                                      .updateHeight(
                                          newValue, selectedObject.id);
                                  context
                                      .read(objsControllerProvider.notifier)
                                      .updateWidth(newValue, selectedObject.id);
                                }
                              },
                            ),
                          ])),
                  if (selectedObject.objType == ObjectType.section ||
                      selectedObject.objType == ObjectType.store)
                    EditorCorner(selectedObject: selectedObject),
                ]));
  }
}

class BackgroundColorPicker extends StatelessWidget {
  const BackgroundColorPicker({Key? key, required this.selectedObject})
      : super(key: key);

  final CanvObjectModel selectedObject;

  @override
  Widget build(BuildContext context) {
    return WidgetColorPicker(
        pickerColor: selectedObject.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Container(
            height: 35,
            width: 38,
            decoration: BoxDecoration(
                color: selectedObject.backgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                    color: Theme.of(context).colorScheme.onBackground)),
          ),
        ),
        onColorChanged: (color) {
          context
              .read(objsControllerProvider.notifier)
              .updateBackgroundColor(color, selectedObject.id);
          context.read(selectedObjectProvider).state =
              context.read(objsControllerProvider.notifier).selectObj(selectedObject.id);
        });
  }
}

class BorderColorPicker extends StatelessWidget {
  const BorderColorPicker({Key? key, required this.selectedObject})
      : super(key: key);

  final CanvObjectModel selectedObject;

  @override
  Widget build(BuildContext context) {
    return WidgetColorPicker(
        pickerColor: selectedObject.borderColor,
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Container(
            height: 35,
            width: 38,
            decoration: BoxDecoration(
                color: selectedObject.borderColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                    color: Theme.of(context).colorScheme.onBackground)),
          ),
        ),
        onColorChanged: (color) {
          context
              .read(objsControllerProvider.notifier)
              .updateBorderColor(color, selectedObject.id);
          context.read(selectedObjectProvider).state =
              context.read(objsControllerProvider.notifier).selectObj(selectedObject.id);
        });
  }
}

class LockObject extends ConsumerWidget {
  const LockObject({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final selectedObject = watch(selectedObjectProvider).state;

    return SizedBox(
      height: 35,
      width: 38,
      child: InkWell(
        onTap: () {
          context.read(objsControllerProvider.notifier).toggleLock(selectedObject!.id);
          context.read(selectedObjectProvider).state =
              context.read(objsControllerProvider.notifier).selectObj(selectedObject.id);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Icon(
            selectedObject!.isLocked
                ? FontAwesomeIcons.lock
                : FontAwesomeIcons.lockOpen,
            size: 30,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}

class DeleteObject extends ConsumerWidget {
  const DeleteObject({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final selectedObject = watch(selectedObjectProvider).state;

    return SizedBox(
      height: 35,
      width: 38,
      child: InkWell(
        onTap: () {
          /// deselect objects
          context.read(objsControllerProvider.notifier).removeObject(selectedObject!.id);
          context.read(selectedObjectProvider).state = null;
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: Icon(
            FontAwesomeIcons.trash,
            size: 30,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}

/// text field to update name
class EditorTextInput extends StatefulWidget {
  const EditorTextInput({
    Key? key,
    required this.selectedObject,
    required this.width,
    required this.height,
    required this.onChange,
    required this.initialValue,
  }) : super(key: key);

  final CanvObjectModel selectedObject;
  final double width;
  final double height;
  final initialValue;
  final Function(String) onChange;

  @override
  State<EditorTextInput> createState() => _EditorTextInputState();
}

class _EditorTextInputState extends State<EditorTextInput> {
  final FocusNode focus = FocusNode();
  late TextEditingController controller;

  @override
  void initState() {
    if (widget.initialValue is String) {
      controller = TextEditingController(text: widget.initialValue);
    } else {
      controller =
          TextEditingController(text: widget.initialValue.toStringAsFixed(0));
    }
    controller.addListener(() {
      final String text = controller.text;
      controller.value = controller.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.onBackground),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      width: widget.width,
      height: widget.height,
      child: TextField(
        cursorColor: Theme.of(context).colorScheme.onBackground,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: -12),
        ),
        // focusNode: focus,
        controller: controller,
        onChanged: widget.onChange,
      ),
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
                showLabel: true,
                pickerAreaHeightPercent: 0.8,
              ),
            ),
          ),
        ];
      },
      child: child,
    );
  }
}

class EditorCorner extends StatelessWidget {
  const EditorCorner({Key? key, required this.selectedObject})
      : super(key: key);

  final CanvObjectModel selectedObject;

  @override
  Widget build(BuildContext context) {
    return Slider(
        activeColor: Theme.of(context).colorScheme.onBackground,
        inactiveColor: Theme.of(context).colorScheme.secondary,
        max: 90,
        value: selectedObject.cornerRadius.roundToDouble(),
        onChanged: (value) {
          context
              .read(objsControllerProvider.notifier)
              .updateCornerRadius(value, selectedObject.id);
          context.read(selectedObjectProvider).state =
              context.read(objsControllerProvider.notifier).selectObj(selectedObject.id);
        });
  }
}
