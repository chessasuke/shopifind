import 'package:auto_size_text/auto_size_text.dart';
import 'package:shopifind/common/constants/app_colors.dart';
import 'package:shopifind/common/constants/display_properties.dart';
import 'package:shopifind/common/text/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/screen_landing/widgets/store_card.dart';
import 'package:shopifind/screen_store_editor/services/store_service_adapter.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AppBar(),
      backgroundColor: AppColors.neutral300,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Padding(
                  padding: EdgeInsets.all(24.0),
                  child: _Title(),
                ),
                _StoreList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Center(
        child: CircleAvatar(
          backgroundColor: AppColors.neutral300,
          child: Text('Anon'),
        ),
      ),
      elevation: 1,
      backgroundColor: AppColors.neutral200,
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(DisplayProperties.topbarHeight);
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      'ShopiFind',
      maxLines: 1,
      style: TextStyles.display02,
    );
  }
}

class _StoreList extends ConsumerStatefulWidget {
  const _StoreList({Key? key}) : super(key: key);

  @override
  ConsumerState<_StoreList> createState() => _StoreListState();
}

class _StoreListState extends ConsumerState<_StoreList> {

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(storeServiceAdapter);
    return query.when(
      data: (stores) {
        return Wrap(
          spacing: 25.0,
          runSpacing: 10.0,
          children: [
            const StoreCard(),
            ...stores.map((store) => StoreCard(store: store)).toList(),
          ],
        );
      },
      loading: () => const _Loading(),
      error: (error, _) {
        return const _ErrorCard();
      },
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        SizedBox(
          width: 60,
          height: 60,
          child: CircularProgressIndicator(
            color: AppColors.primary100,
          ),
        ),
      ],
    );
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.neutral500,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'There was an error fetching stores.\nPlease try again later.',
              style: TextStyles.body01.copyWith(
                color: AppColors.secondary100,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: TextStyles.body01FontSize * 2,
            ),
          ],
        ),
      ),
    );
  }
}
