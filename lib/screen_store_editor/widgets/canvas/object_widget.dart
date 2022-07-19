import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopifind/common/constants/app_colors.dart';
import 'package:shopifind/screen_store_editor/controller/objects_controller.dart';
import 'package:flutter/material.dart';
import 'package:shopifind/screen_store_editor/model/canv_obj.dart';
import 'package:shopifind/screen_store_editor/model/canvas_object_type.dart';
import 'package:shopifind/screen_store_editor/widgets/canvas/icon_object.dart';
import 'package:shopifind/screen_store_editor/widgets/canvas/section_object.dart';
import 'package:shopifind/view/section_dialog.dart';

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
                onPointerDown: (details) => _onTapObject(ref),
                onPointerMove: (details) => _onMoveObject(details, ref),
                child: object.objType.isSectionObject
                    ? SectionObject(object: object)
                    : IconObject(object: object),
              ),
            ),
          ),
        ),
        if (selectedObject?.id == object.id) _ResizingBtn(object: object),
        if (selectedObject?.id == object.id &&
            (object.objType == ObjectType.section))
          _EllipsisButton(object: object)
      ],
    );
  }

  void _onTapObject(WidgetRef ref) {
    ref.read(objectsControllerProvider.notifier).selectObject(object.id);
  }

  void _onMoveObject(PointerMoveEvent details, WidgetRef ref) {
    if (!object.isLocked) {
      final position =
          ref.read(objectsControllerProvider.notifier).getPosition(object.id);

      if (position != null) {
        final newPosition = Offset(position.dx, position.dy) + details.delta;

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
  }
}

class _ResizingBtn extends ConsumerWidget {
  const _ResizingBtn({
    required this.object,
    Key? key,
  }) : super(key: key);

  final CanvObj object;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      left: object.position.dx + object.width,
      top: object.position.dy + object.height,
      child: GestureDetector(
        onVerticalDragUpdate: (details) =>  _onUpdateWidth(details, ref),
        onHorizontalDragUpdate: (details) => _onUpdateHeight(details, ref),
        child: const _ReisizingBtnIcon(),
      ),
    );
  }

void _onUpdateWidth(DragUpdateDetails details, WidgetRef ref) {
          final size =
              ref.read(objectsControllerProvider.notifier).getSize(object.id);
          double newHeight;
          if (size != null) {
            newHeight = size.height + details.delta.dy;
            if (newHeight < 30) newHeight = 30;
            ref
                .read(objectsControllerProvider.notifier)
                .updateObj(object.copyWith(height: newHeight));
          }
        }

        void _onUpdateHeight(DragUpdateDetails details, WidgetRef ref) {
    final size =
        ref.read(objectsControllerProvider.notifier).getSize(object.id);
    double newWidth;
    if (size != null) {
      newWidth = size.width + details.delta.dx;
      if (newWidth < 30) newWidth = 30;
      ref
          .read(objectsControllerProvider.notifier)
          .updateObj(object.copyWith(width: newWidth));
    }
  }
}

class _ReisizingBtnIcon extends StatelessWidget {
  const _ReisizingBtnIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: AppColors.neutral400,
            shape: BoxShape.circle,
          ),
        );
  }
}

class _EllipsisButton extends StatelessWidget {
  const _EllipsisButton({
    required this.object,
    Key? key,
  }) : super(key: key);

  final CanvObj object;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: object.position.dx + object.width - 10,
      top: object.position.dy + 5,
      child: InkWell(
        onTap: () => showDialog(
          context: context,
          builder: (context) => ManageSectionDialog(section: object),
        ),
        child: const Padding(
          padding: EdgeInsets.all(4.0),
          child: Icon(
            FontAwesomeIcons.ellipsis,
            size: 15,
            color: AppColors.neutral400,
          ),
        ),
      ),
    );
  }
}
