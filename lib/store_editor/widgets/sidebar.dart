import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/common/constants/app_colors.dart';
import 'package:shopifind/common/constants/display_properties.dart';
import 'package:shopifind/common/text/text_style.dart';
import 'package:flutter/material.dart';
import 'package:shopifind/store_editor/widgets/sidebar_options.dart';

class Sidebar extends ConsumerWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      color: AppColors.neutral200,
      width: DisplayProperties.sidebarWidth,
      height: screenSize.height,
      child: Column(
        children: const [
          Flexible(child: _SidebarTitle()),
          SidebarOptions(),
        ],
      ),
    );
  }
}

class _SidebarTitle extends StatelessWidget {
  const _SidebarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
        width: DisplayProperties.sidebarWidth,
        height: DisplayProperties.sidebarTitleHeight,
        child: Center(
          child: AutoSizeText(
            'ShopiFind',
            maxLines: 1,
            style: TextStyles.heading01,
          ),
        ),
      ),
    );
  }
}
