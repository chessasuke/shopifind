import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/common/constants/app_colors.dart';
import 'package:shopifind/store_editor/controller/objects_controller.dart';
import 'package:shopifind/store_editor/widgets/object_widget.dart';
import 'package:shopifind/store_editor/widgets/sidebar.dart';

class StoreEditor extends ConsumerStatefulWidget {
  const StoreEditor({Key? key}) : super(key: key);

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
        child: Row(
          children: [
            /// sidebar
            SizedBox(
              height: screenSize.height,
              width: 150,
              child: const Sidebar(),
            ),

            /// topbar and canvas
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: screenSize.height - 50,
                width: screenSize.width - 150,
                child: Stack(
                  children: [
                    for (final item in canvas.objects)
                      ObjectWidget(object: item)
                    // for (var i = 0; i < canvas.length; i++) ...[
                    //   ObjectWidget(object: canvas[i])
                    // ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
