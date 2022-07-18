import 'package:flutter/services.dart';
import 'package:shopifind/common/constants/app_colors.dart';
import 'package:shopifind/common/constants/display_properties.dart';
import 'package:shopifind/common/text/text_style.dart';
import 'package:shopifind/store_editor/controller/objects_controller.dart';
import 'package:shopifind/store_editor/model/canv_obj.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopifind/store_editor/model/canvas_object_type.dart';

class ObjectEditor extends ConsumerWidget {
  const ObjectEditor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canvasState = ref.watch(objectsControllerProvider);
    final selectedObject = canvasState.selectedObject;

    // print(
    //     '======== ObjectEditor selectedObject: ${selectedObject?.id} | ${selectedObject?.objType}');

    if (selectedObject == null) {
      return const SizedBox(
        height: 225,
        width: DisplayProperties.sidebarWidth,
      );
    } else {
      return SizedBox(
        width: DisplayProperties.sidebarWidth,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child:
                  _IdField(id: selectedObject.id, selectedObj: selectedObject),
            ),
            if (selectedObject.objType == ObjectType.section)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Description:', style: TextStyles.body01),
                    EditorTextInput(
                        key: UniqueKey(),
                        selectedObject: selectedObject,
                        width: 90,
                        height: 35,
                        initialValue: selectedObject.description,
                        onChange: (value) {
                          // if (value.isNotEmpty || value != '') {
                          //   ref
                          //       .read(objectsControllerProvider.notifier)
                          //       .updateName(value, selectedObject.id);
                          // }
                        }),
                  ],
                ),
              ),

            /// border Color
            // if (selectedObject.objType == ObjectType.section ||
            //     selectedObject.objType == ObjectType.store)
            //   Padding(
            //       padding: const EdgeInsets.symmetric(vertical: 8.0),
            //       child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceAround,
            //           children: [
            //             const Padding(
            //               padding: EdgeInsets.only(right: 32.0),
            //               child: Text('Border:'),
            //             ),
            //             BorderColorPicker(selectedObject: selectedObject)
            //           ]))
            // else
            //   const SizedBox(
            //     height: 55,
            //   ),

            // /// Background Color
            // Padding(
            //     padding: const EdgeInsets.symmetric(vertical: 8.0),
            //     child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceAround,
            //         children: [
            //           const Text('Background:'),
            //           BackgroundColorPicker(
            //               selectedObject: selectedObject)
            //         ])),

            /// Translation dx/dy
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('dx:', style: TextStyles.body01),
                  EditorTextInput(
                    key: UniqueKey(),
                    selectedObject: selectedObject,
                    width: 38,
                    height: 35,
                    initialValue: selectedObject.position.dx.toStringAsFixed(0),
                    onChange: (value) {
                      // if (value.isNotEmpty && value != '') {
                      //   ref.read(objectsControllerProvider.notifier).updateObj(
                      //         selectedObject.copyWith(
                      //           position: Position(
                      //             dx: double.parse(value),
                      //             dy: selectedObject.position.dy,
                      //           ),
                      //         ),
                      //       );
                      // } else {
                      //   ref.read(objectsControllerProvider.notifier).updateObj(
                      //         selectedObject.copyWith(
                      //           position: Position(
                      //             dx: 0,
                      //             dy: 0,
                      //           ),
                      //         ),
                      //       );
                      // }
                    },
                  ),
                  Text('dy:', style: TextStyles.body01),
                  EditorTextInput(
                    key: UniqueKey(),
                    selectedObject: selectedObject,
                    width: 38,
                    height: 35,
                    initialValue: selectedObject.position.dy.toStringAsFixed(0),
                    onChange: (value) {
                      // if (value.isNotEmpty && value != '') {
                      //   ref.read(objectsControllerProvider.notifier).updateObj(
                      //         selectedObject.copyWith(
                      //           position: Position(
                      //             dx: selectedObject.position.dx,
                      //             dy: double.parse(value),
                      //           ),
                      //         ),
                      //       );
                      // } else {
                      //   ref.read(objectsControllerProvider.notifier).updateObj(
                      //         selectedObject.copyWith(
                      //           position: Position(
                      //             dx: 0,
                      //             dy: 0,
                      //           ),
                      //         ),
                      //       );
                      // }
                    },
                  ),
                ],
              ),
            ),

            /// Width/Height
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  /// width
                  Text('w:', style: TextStyles.body01),
                  EditorTextInput(
                    key: UniqueKey(),
                    selectedObject: selectedObject,
                    width: 38,
                    height: 35,
                    initialValue: selectedObject.width.toStringAsFixed(0),
                    onChange: (value) {
                      // if (value.isEmpty || value == '') {
                      //   ref
                      //       .read(objectsControllerProvider.notifier)
                      //       .updateWidth(30, selectedObject.id);
                      //   ref
                      //       .read(objectsControllerProvider.notifier)
                      //       .updateHeight(30, selectedObject.id);
                      // } else {
                      //   double newValue = double.parse(value);
                      //   if (newValue < 30) newValue = 30;
                      //   ref
                      //       .read(objectsControllerProvider.notifier)
                      //       .updateWidth(newValue, selectedObject.id);
                      //   ref
                      //       .read(objectsControllerProvider.notifier)
                      //       .updateHeight(newValue, selectedObject.id);
                      // }
                      // // context.read(objectSelectedProvider).state =
                      // //     context
                      // //         .read(objProvider.notifier)
                      // //         .selectObj(selectedObject.id);
                    },
                  ),

                  /// height
                  Text('h:', style: TextStyles.body01),
                  EditorTextInput(
                    key: UniqueKey(),
                    selectedObject: selectedObject,
                    width: 38,
                    height: 35,
                    initialValue: selectedObject.height.toStringAsFixed(0),
                    onChange: (value) {
                      // if (value.isEmpty || value == '') {
                      //   ref
                      //       .read(objectsControllerProvider.notifier)
                      //       .updateHeight(30, selectedObject.id);
                      //   ref
                      //       .read(objectsControllerProvider.notifier)
                      //       .updateWidth(30, selectedObject.id);
                      // } else {
                      //   double newValue = double.parse(value);
                      //   if (newValue < 30) newValue = 30;
                      //   ref
                      //       .read(objectsControllerProvider.notifier)
                      //       .updateHeight(newValue, selectedObject.id);
                      //   ref
                      //       .read(objectsControllerProvider.notifier)
                      //       .updateWidth(newValue, selectedObject.id);
                      // }
                    },
                  ),
                ],
              ),
            ),
            // if (selectedObject.objType == ObjectType.section ||
            //     selectedObject.objType == ObjectType.store)
            //   EditorCorner(selectedObject: selectedObject),
          ],
        ),
      );
    }
  }
}

class _IdField extends StatelessWidget {
  const _IdField({
    required this.selectedObj,
    required this.id,
    Key? key,
  }) : super(key: key);

  final String id;
  final CanvObj selectedObj;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Object Id',
                style: TextStyles.body01,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Tooltip(
                    message: 'Copy Id',
                    child: Padding(
                      padding: EdgeInsets.zero,
                      child: IconButton(
                        onPressed: () => Clipboard.setData(
                          ClipboardData(text: id),
                        ),
                        icon: const Icon(
                          Icons.copy,
                          color: AppColors.primary100,
                          size: TextStyles.body01FontSize,
                        ),
                      ),
                    ),
                  ),
                  _DeleteOrLockObjectIcons(
                    isDeleteIcon: true,
                    selectedObj: selectedObj,
                    size: TextStyles.body01FontSize,
                  ),
                ],
              ),
            ],
          ),
          SelectableText(
            id,
            style: TextStyles.body01,
            cursorColor: AppColors.primary100,
          ),
        ],
      ),
    );
  }
}

// class BackgroundColorPicker extends ConsumerWidget {
//   const BackgroundColorPicker({Key? key, required this.selectedObject})
//       : super(key: key);

//   final CanvObj selectedObject;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return WidgetColorPicker(
//         pickerColor: selectedObject.color,
//         child: Padding(
//           padding: const EdgeInsets.only(left: 15.0),
//           child: Container(
//             height: 35,
//             width: 38,
//             decoration: BoxDecoration(
//                 color: selectedObject.color,
//                 borderRadius: const BorderRadius.all(Radius.circular(10)),
//                 border: Border.all(
//                     color: Theme.of(context).colorScheme.onBackground)),
//           ),
//         ),
//         onColorChanged: (color) {
//           ref
//               .read(objsControllerProvider.notifier)
//               .updateBackgroundColor(color, selectedObject.id);
//           ref.read(selectedObjectProvider.notifier).state = ref
//               .read(objsControllerProvider.notifier)
//               .selectObj(selectedObject.id);
//         });
//   }
// }

// class BorderColorPicker extends ConsumerWidget {
//   const BorderColorPicker({Key? key, required this.selectedObject})
//       : super(key: key);

//   final CanvObj selectedObject;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return WidgetColorPicker(
//         pickerColor: selectedObject.borderColor,
//         child: Padding(
//           padding: const EdgeInsets.only(left: 15.0),
//           child: Container(
//             height: 35,
//             width: 38,
//             decoration: BoxDecoration(
//                 color: selectedObject.borderColor,
//                 borderRadius: const BorderRadius.all(Radius.circular(10)),
//                 border: Border.all(
//                     color: Theme.of(context).colorScheme.onBackground)),
//           ),
//         ),
//         onColorChanged: (color) {
//           ref
//               .read(objsControllerProvider.notifier)
//               .updateBorderColor(color, selectedObject.id);
//           ref.read(selectedObjectProvider.notifier).state = ref
//               .read(objsControllerProvider.notifier)
//               .selectObj(selectedObject.id);
//         });
//   }
// }

// class _DeleteAndLockObject extends StatelessWidget {
//   const _DeleteAndLockObject({
//     required this.selectedObj,
//     Key? key,
//   }) : super(key: key);

//   final CanvObj selectedObj;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         _DeleteOrLockObjectIcons(
//           isDeleteIcon: true,
//           selectedObj: selectedObj,
//         ),
//         // _DeleteOrLockObjectIcons(
//         //   isDeleteIcon: false,
//         //   selectedObj: selectedObj,
//         // ),
//       ],
//     );
//   }
// }

class _DeleteOrLockObjectIcons extends ConsumerWidget {
  const _DeleteOrLockObjectIcons({
    required this.selectedObj,
    required this.isDeleteIcon,
    this.size = 30,
    Key? key,
  }) : super(key: key);

  final bool isDeleteIcon;
  final CanvObj selectedObj;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedObject =
        ref.watch(objectsControllerProvider.notifier).selectedObject;

    return Tooltip(
      message: isDeleteIcon ? 'Delete' : 'Lock',
      child: InkWell(
        onTap: () => _onTap(ref),
        child: Padding(
          padding: EdgeInsets.zero,
          child: Icon(
            isDeleteIcon
                ? FontAwesomeIcons.trash
                : selectedObject!.isLocked
                    ? FontAwesomeIcons.lock
                    : FontAwesomeIcons.lockOpen,
            size: size,
            color: AppColors.primary100,
          ),
        ),
      ),
    );
  }

  void _onTap(WidgetRef ref) {
    final selectedObj =
        ref.read(objectsControllerProvider.notifier).selectedObject;
    if (selectedObj != null) {
      print(
          '====== DeleteOrLock selectedObj: ${selectedObj.objType} | id: ${selectedObj.id}');
      if (isDeleteIcon) {
        ref
            .read(objectsControllerProvider.notifier)
            .removeObject(selectedObj.id);
      }
      // else {
      //   ref.read(objectsControllerProvider.notifier).toggleLock(selectedObj.id);
      // }
    }
  }
}

class EditorTextInput extends ConsumerStatefulWidget {
  const EditorTextInput({
    Key? key,
    required this.selectedObject,
    required this.width,
    required this.height,
    required this.onChange,
    required this.initialValue,
  }) : super(key: key);

  final CanvObj selectedObject;
  final double width;
  final double height;
  final String initialValue;
  final Function(String) onChange;

  @override
  ConsumerState<EditorTextInput> createState() => _EditorTextInputState();
}

class _EditorTextInputState extends ConsumerState<EditorTextInput> {
  final FocusNode focus = FocusNode();
  late TextEditingController controller;

  @override
  void initState() {
    // print('widget.initialValue: ${widget.initialValue}');
    controller = TextEditingController(text: widget.initialValue);
    // controller.addListener(
    //   () {
    //     final String text = controller.text;
    //     controller.value = controller.value.copyWith(
    //       text: text,
    //       selection: TextSelection(
    //         baseOffset: text.length,
    //         extentOffset: text.length,
    //       ),
    //       composing: TextRange.empty,
    //     );
    //   },
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary100),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      width: widget.width,
      height: widget.height,
      child: TextField(
        style: TextStyles.body01,
        cursorColor: AppColors.primary100,
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

// class EditorCorner extends ConsumerWidget {
//   const EditorCorner({Key? key, required this.selectedObject})
//       : super(key: key);

//   final CanvObj selectedObject;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Slider(
//         activeColor: Theme.of(context).colorScheme.onBackground,
//         inactiveColor: Theme.of(context).colorScheme.secondary,
//         max: 90,
//         value: selectedObject.cornerRadius.roundToDouble(),
//         onChanged: (value) {
//           ref
//               .read(objectsControllerProvider.notifier)
//               .updateCornerRadius(value, selectedObject.id);
//           ref.read(objectsControllerProvider.notifier).state = ref
//               .read(objectsControllerProvider.notifier)
//               .selectObj(selectedObject.id);
//         });
//   }
// }
