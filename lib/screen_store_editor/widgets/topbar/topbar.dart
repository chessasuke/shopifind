import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/common/constants/app_colors.dart';
import 'package:shopifind/common/text/text_style.dart';
import 'package:shopifind/screen_store_editor/widgets/topbar/manage_store_btn.dart';
import 'package:shopifind/screen_landing/landing_screen.dart';
import 'package:shopifind/screen_store_editor/services/store_service_adapter.dart';
import 'package:shopifind/screen_store_editor/widgets/topbar/upload_store_btn.dart';

class Topbar extends StatelessWidget {
  const Topbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.neutral200,
      child: Row(
        children: const [
          _SidebarTitle(),
          Spacer(),
          ManageStoreBtn(),
          SizedBox(width: 8),
          SaveStoreBtn(),
          SizedBox(width: 8),
        ],
      ),
    );
  }
}

class _SidebarTitle extends ConsumerWidget {
  const _SidebarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: () => _onBack(context, ref),
        child: AutoSizeText(
          'ShopiFind',
          maxLines: 1,
          style: TextStyles.heading01,
        ),
      ),
    );
  }
}

void _onBack(BuildContext context, WidgetRef ref) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const LandingScreen(),
    ),
  );

  ref.refresh(storeServiceAdapter);
}
