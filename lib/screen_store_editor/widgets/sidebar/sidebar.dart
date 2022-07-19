import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/common/constants/app_colors.dart';
import 'package:shopifind/common/constants/display_properties.dart';
import 'package:flutter/material.dart';
import 'package:shopifind/screen_store_editor/controller/objects_controller.dart';
import 'package:shopifind/screen_store_editor/model/canv_obj.dart';
import 'package:shopifind/screen_store_editor/model/canvas_object_type.dart';
import 'package:shopifind/screen_store_editor/widgets/sidebar/object_editor/object_editor.dart';
import 'package:shopifind/widgets/separator.dart';

class Sidebar extends ConsumerWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final screenSize = MediaQuery.of(context).size;
    return Container(
      color: AppColors.neutral200,
      // width: DisplayProperties.sidebarWidth,
      // height: screenSize.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GridView.count(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              crossAxisCount: 3,
              children: [
                for (final item in ObjectType.values)
                  _SidebarTool(objectType: item),
              ],
            ),
            const Separator(length: DisplayProperties.sidebarWidth),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: ObjectEditor(),
            ),
            const Separator(length: DisplayProperties.sidebarWidth),
          ],
        ),
      ),
    );
  }
}

class _SidebarTool extends ConsumerWidget {
  const _SidebarTool({
    required this.objectType,
    Key? key,
  }) : super(key: key);

  final ObjectType objectType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => _onTap(ref),
      child: Tooltip(
        message: objectType.getTooltipMsg(),
        child: Icon(
          objectType.getIcon(),
          color: AppColors.primary100,
        ),
      ),
    );
  }

  void _onTap(WidgetRef ref) {
    final newObj = CanvObj.initial(objectType);
    ref.read(objectsControllerProvider.notifier).addObject(newObj);
  }
}
