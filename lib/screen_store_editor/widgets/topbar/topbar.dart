import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shopifind/common/constants/app_colors.dart';
import 'package:shopifind/common/text/text_style.dart';

class Topbar extends StatelessWidget {
  const Topbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.neutral200,
      child: Row(
        children: [
          const _SidebarTitle(),
          const Spacer(),
          Text(
            'TOPBAR',
            style: TextStyles.heading03,
          ),
          const Spacer()
        ],
      ),
    );
  }
}

class _SidebarTitle extends StatelessWidget {
  const _SidebarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: () {},
        child: AutoSizeText(
          'ShopiFind',
          maxLines: 1,
          style: TextStyles.heading01,
        ),
      ),
    );
  }
}
