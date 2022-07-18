import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopifind/common/constants/app_colors.dart';
import 'package:shopifind/common/text/text_style.dart';
import 'package:shopifind/store_editor/controller/objects_controller.dart';

class ObjectEditorIdField extends ConsumerWidget {
  const ObjectEditorIdField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedObjId = ref.watch(
        objectsControllerProvider.select((value) => value.selectedObject?.id));

    return selectedObjId != null
        ? SizedBox(
            height: 100,
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Object Id',
                      style: TextStyles.body01
                          .copyWith(fontWeight: FontWeight.bold),
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
                                ClipboardData(text: selectedObjId),
                              ),
                              icon: const Icon(
                                Icons.copy,
                                color: AppColors.primary100,
                                size: TextStyles.body01FontSize,
                              ),
                            ),
                          ),
                        ),
                        const _DeleteOrLockObjectIcons(
                          isDeleteIcon: true,
                          size: TextStyles.body01FontSize,
                        ),
                      ],
                    ),
                  ],
                ),
                SelectableText(
                  selectedObjId,
                  style: TextStyles.body01,
                  cursorColor: AppColors.primary100,
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}


class _DeleteOrLockObjectIcons extends ConsumerWidget {
  const _DeleteOrLockObjectIcons({
    required this.isDeleteIcon,
    this.size = 30,
    Key? key,
  }) : super(key: key);

  final bool isDeleteIcon;
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
    if (selectedObj != null && isDeleteIcon) {
        ref
            .read(objectsControllerProvider.notifier)
            .removeObject(selectedObj.id);
    }
  }
}
