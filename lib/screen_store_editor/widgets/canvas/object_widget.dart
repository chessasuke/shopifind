import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/common/constants/app_colors.dart';
import 'package:shopifind/screen_store_editor/controller/objects_controller.dart';
import 'package:flutter/material.dart';
import 'package:shopifind/screen_store_editor/model/canv_obj.dart';
import 'package:shopifind/screen_store_editor/widgets/canvas/icon_object.dart';
import 'package:shopifind/screen_store_editor/widgets/canvas/section_object.dart';


class ObjectWidget extends ConsumerWidget {
  const ObjectWidget({
    required this.object,
    Key? key,
  }) : super(key: key);

  final CanvObj object;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canvasState = ref.watch(objectsControllerProvider);
    final selectedObject = canvasState.selectedObject;
    return Stack(
      children: [
        Positioned(
          left: object.position.dx,
          top: object.position.dy,
          child: SizedBox(
            width: object.width + 10,
            height: object.height + 10,
            child: Align(
              child: Listener(
                onPointerDown: (details) {
                  ref
                      .read(objectsControllerProvider.notifier)
                      .selectObject(object.id);
                },
                onPointerMove: (details) {
                  if (!object.isLocked) {
                    final position = ref
                        .read(objectsControllerProvider.notifier)
                        .getPosition(object.id);

                    if (position != null) {
                      final newPosition =
                          Offset(position.dx, position.dy) + details.delta;

                      ref.read(objectsControllerProvider.notifier).updateObj(
                            object.copyWith(
                              position: Position(
                                dx: newPosition.dx,
                                dy: newPosition.dy,
                              ),
                            ),
                          );
                    }
                  }
                },
                child: object.objType.isSectionObject
                    ? SectionObject(object: object)
                    : IconObject(object: object),
              ),
            ),
          ),
        ),

        if (selectedObject?.id == object.id)
          Positioned(
            left: object.position.dx + object.width,
            top: object.position.dy + object.height,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                final size = ref
                    .read(objectsControllerProvider.notifier)
                    .getSize(object.id);
                double newHeight;
                if (size != null) {
                  newHeight = size.height + details.delta.dy;
                  if (newHeight < 30) newHeight = 30;
                  ref
                      .read(objectsControllerProvider.notifier)
                      .updateObj(object.copyWith(height: newHeight));
                }
              },
              onHorizontalDragUpdate: (details) {
                final size = ref
                    .read(objectsControllerProvider.notifier)
                    .getSize(object.id);
                double newWidth;
                if (size != null) {
                  newWidth = size.width + details.delta.dx;
                  if (newWidth < 30) newWidth = 30;
                  ref
                      .read(objectsControllerProvider.notifier)
                      .updateObj(object.copyWith(width: newWidth));
                }
              },
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: AppColors.dataBlue01,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),

        // if (object.isSelected &&
        //     (object.objType == ObjectType.section ||
        //         object.objType == ObjectType.store))
        //   Positioned(
        //     left: object.position.dx + object.width,
        //     top: object.position.dy + (object.height / 2 - 5),
        //     child: GestureDetector(
        //       onHorizontalDragUpdate: (details) {
        //         var newWidth = ref
        //                 .read(objsControllerProvider.notifier)
        //                 .getWidthFromId(object.id) +
        //             details.delta.dx;
        //         if (newWidth < 30) newWidth = 30;
        //         ref
        //             .read(objsControllerProvider.notifier)
        //             .updateWidth(newWidth, object.id);

        //         ref.read(selectedObjectProvider.notifier).state = ref
        //             .read(objsControllerProvider.notifier)
        //             .selectObj(object.id);
        //       },
        //       child: Container(
        //         width: 10,
        //         height: 10,
        //         decoration: BoxDecoration(
        //           color: Theme.of(context).colorScheme.secondaryVariant,
        //           shape: BoxShape.circle,
        //         ),
        //       ),
        //     ),
        //   ),

        /// handles section vertical resize
        /// only section object will call this method

        // if (object.isSelected &&
        //     (object.objType == ObjectType.section ||
        //         object.objType == ObjectType.store))
        //   Positioned(
        //     left: object.position.dx + object.width / 2 - 5,
        //     top: object.position.dy + object.height,
        //     child: GestureDetector(
        //       onVerticalDragUpdate: (details) {
        //         var newHeight = ref
        //                 .read(objsControllerProvider.notifier)
        //                 .getHeightFromId(object.id) +
        //             details.delta.dy;
        //         if (newHeight < 30) newHeight = 30;
        //         ref
        //             .read(objsControllerProvider.notifier)
        //             .updateHeight(newHeight, object.id);

        //         ref.read(selectedObjectProvider.notifier).state = ref
        //             .read(objsControllerProvider.notifier)
        //             .selectObj(object.id);
        //       },
        //       child: Container(
        //         width: 10,
        //         height: 10,
        //         decoration: BoxDecoration(
        //           color: Theme.of(context).colorScheme.secondaryVariant,
        //           shape: BoxShape.circle,
        //         ),
        //       ),
        //     ),
        //   ),

        /// show close btn
        /// display if object section
        // if (object.isSelected && (object.objType != ObjectType.section))
        //   Positioned(
        //       left: object.position.dx - 5,
        //       top: object.position.dy - 8,
        //       child: InkWell(
        //         onTap: () =>
        //             context.read(objProvider.notifier).removeObject(object.id),
        //         child: Padding(
        //           padding: const EdgeInsets.all(4.0),
        //           child: Icon(
        //             FontAwesomeIcons.timesCircle,
        //             size: 15,
        //             color: Theme.of(context).colorScheme.secondaryVariant,
        //           ),
        //         ),
        //       ),
        //       ),

        // /// show lock btn
        // if (object.isSelected)
        //   Positioned(
        //       left: object.objType == ObjectType.section
        //           ? object.position.dx + 30
        //           : object.position.dx + 15,
        //       top: object.objType == ObjectType.section
        //           ? object.position.dy + 8
        //           : object.position.dy - 8,
        //       child: InkWell(
        //         onTap: () =>
        //             context.read(objProvider.notifier).toggleLock(object.id),
        //         child: Padding(
        //           padding: const EdgeInsets.all(4.0),
        //           child: Icon(
        //             object.isLocked
        //                 ? FontAwesomeIcons.lock
        //                 : FontAwesomeIcons.lockOpen,
        //             size: 15,
        //             color: Theme.of(context).colorScheme.secondaryVariant,
        //           ),
        //         ),
        //       ),
        //       ),

        /// show edit btn
        /// display if object stores info

        // if (object.isSelected && (object.objType == ObjectType.section))
        //   Positioned(
        //       left: object.position.dx + 10,
        //       top: object.position.dy + 10,
        //       child: InkWell(
        //         onTap: () => showDialog(
        //             context: context,
        //             builder: (context) => SectionDialog(obj: object)),
        //         child: Padding(
        //           padding: const EdgeInsets.all(4.0),
        //           child: Icon(
        //             FontAwesomeIcons.ellipsisH,
        //             size: 15,
        //             color: Theme.of(context).colorScheme.secondaryVariant,
        //           ),
        //         ),
        //       )),
      ],
    );
  }
}
