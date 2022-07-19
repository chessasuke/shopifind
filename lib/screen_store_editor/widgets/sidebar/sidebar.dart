import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/common/constants/app_colors.dart';
import 'package:shopifind/common/constants/display_properties.dart';
import 'package:shopifind/common/text/text_style.dart';
import 'package:flutter/material.dart';
import 'package:shopifind/screen_store_editor/widgets/sidebar/sidebar_options.dart';

class Sidebar extends ConsumerWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('rebuild sidebar');

    final screenSize = MediaQuery.of(context).size;

    return Container(
      color: AppColors.neutral200,
      width: DisplayProperties.sidebarWidth,
      height: screenSize.height,
      child: SingleChildScrollView(
        child: Column(
          children: const [
            // Flexible(child: _SidebarTitle()),
            SidebarOptions(),
          ],
        ),
      ),
    );
  }
}
