import 'package:shopifind/controller/objects_providers.dart';
import 'package:shopifind/model/canv_object_model.dart';
import 'package:shopifind/view/section_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils.dart';

class ObjectWidget extends StatelessWidget {
  const ObjectWidget({Key? key, required this.object}) : super(key: key);

  final CanvObjectModel object;

  @override
  Widget build(BuildContext context) {
    return Stack(
      /// only the selected widget will call the
      /// methods afer the first one
      /// and not all will be called, depends on the resizing type

      children: [
        /// handles actual child and translation
        /// call with all types of objects
        Positioned(
          left: object.position.dx,
          top: object.position.dy,
          child: SizedBox(
            width: object.width + 10,
            height: object.height + 10,
            child: Align(
              child: Listener(
                onPointerDown: (details) {
                  context.read(selectedObjectProvider).state =
                      context.read(objsControllerProvider.notifier).selectObj(object.id);
                },
                onPointerMove: (details) {
                  /// allow translation if object is unlocked
                  if (!object.isLocked) {
                    /// if instead of getting position from the provider we do
                    /// object.position, (it will be very slow beacuse ? todo)
                    final newPosition = context
                            .read(objsControllerProvider.notifier)
                            .getPositionFromId(object.id) +
                        details.delta;
                    context.read(objsControllerProvider.notifier).updatePosition(
                        id: object.id, dx: newPosition.dx, dy: newPosition.dy);
                    context.read(selectedObjectProvider).state =
                        context.read(objsControllerProvider.notifier).selectObj(object.id);
                  }
                },
                child: Utils.buildCanvObjChild(object),
              ),
            ),
          ),
        ),

        /// handle uniform resizes from corner
        /// all types of objects will call this method
        if (object.isSelected)
          Positioned(
            left: object.position.dx + object.width,
            top: object.position.dy + object.height,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                double newHeight = context
                        .read(objsControllerProvider.notifier)
                        .getHeightFromId(object.id) +
                    details.delta.dy;
                if (newHeight < 30) newHeight = 30;
                context
                    .read(objsControllerProvider.notifier)
                    .updateSize(newHeight, newHeight, object.id);
                context.read(selectedObjectProvider).state =
                    context.read(objsControllerProvider.notifier).selectObj(object.id);
              },
              onHorizontalDragUpdate: (details) {
                var newWidth = context
                        .read(objsControllerProvider.notifier)
                        .getWidthFromId(object.id) +
                    details.delta.dx;
                if (newWidth < 30) newWidth = 30;
                context
                    .read(objsControllerProvider.notifier)
                    .updateSize(newWidth, newWidth, object.id);
                context.read(selectedObjectProvider).state =
                    context.read(objsControllerProvider.notifier).selectObj(object.id);
              },
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryVariant,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),

        /// handles section horizontal resize
        /// only section object will call this method
        if (object.isSelected &&
            (object.objType == ObjectType.section ||
                object.objType == ObjectType.store))
          Positioned(
            left: object.position.dx + object.width,
            top: object.position.dy + (object.height / 2 - 5),
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                var newWidth = context
                        .read(objsControllerProvider.notifier)
                        .getWidthFromId(object.id) +
                    details.delta.dx;
                if (newWidth < 30) newWidth = 30;
                context
                    .read(objsControllerProvider.notifier)
                    .updateWidth(newWidth, object.id);

                context.read(selectedObjectProvider).state =
                    context.read(objsControllerProvider.notifier).selectObj(object.id);
              },
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryVariant,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),

        /// handles section vertical resize
        /// only section object will call this method

        if (object.isSelected &&
            (object.objType == ObjectType.section ||
                object.objType == ObjectType.store))
          Positioned(
            left: object.position.dx + object.width / 2 - 5,
            top: object.position.dy + object.height,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                var newHeight = context
                        .read(objsControllerProvider.notifier)
                        .getHeightFromId(object.id) +
                    details.delta.dy;
                if (newHeight < 30) newHeight = 30;
                context
                    .read(objsControllerProvider.notifier)
                    .updateHeight(newHeight, object.id);

                context.read(selectedObjectProvider).state =
                    context.read(objsControllerProvider.notifier).selectObj(object.id);
              },
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryVariant,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),

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
        if (object.isSelected && (object.objType == ObjectType.section))
          Positioned(
              left: object.position.dx + 10,
              top: object.position.dy + 10,
              child: InkWell(
                onTap: () => showDialog(
                    context: context,
                    builder: (context) => SectionDialog(obj: object)),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    FontAwesomeIcons.ellipsisH,
                    size: 15,
                    color: Theme.of(context).colorScheme.secondaryVariant,
                  ),
                ),
              )),
      ],
    );
  }
}
