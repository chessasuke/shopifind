import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/common/constants/app_colors.dart';
import 'package:shopifind/common/constants/display_properties.dart';
import 'package:shopifind/screen_store_editor/controller/objects_controller.dart';
import 'package:shopifind/screen_store_editor/widgets/canvas/object_widget.dart';
import 'package:shopifind/screen_store_editor/widgets/sidebar/sidebar.dart';
import 'package:shopifind/screen_store_editor/widgets/topbar/topbar.dart';

class StoreEditor extends ConsumerStatefulWidget {
  const StoreEditor({Key? key,}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StoreEditorState();
}

class _StoreEditorState extends ConsumerState<StoreEditor> {
  late Size screenSize;

  @override
  void didChangeDependencies() {
    
    screenSize = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final canvas = ref.watch(objectsControllerProvider);
    return Scaffold(
      backgroundColor: AppColors.neutral300,
      body: SizedBox.expand(
        child: Stack(
          children: [
            /// sidebar
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                height: screenSize.height - DisplayProperties.topbarHeight,
                width: DisplayProperties.sidebarWidth,
                child: const Sidebar(),
              ),
            ),

            /// topbar
            Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: screenSize.width,
                height: DisplayProperties.topbarHeight,
                child: const Topbar(),
              ),
            ),

            ///  canvas
            for (final item in canvas.objects) ObjectWidget(object: item),
          ],
        ),
      ),
    );
  }
}
