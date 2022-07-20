import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:shopifind/common/constants/app_colors.dart';
import 'package:shopifind/common/text/text_style.dart';
import 'package:shopifind/screen_store_editor/controller/store_controller.dart';
import 'package:shopifind/screen_store_editor/model/store.dart';
import 'package:shopifind/screen_store_editor/store_editor_screen.dart';
import 'package:shopifind/screen_store_editor/utils/utils.dart';
import 'package:shopifind/service/analytics/events/actions_events.dart';
import 'package:shopifind/service/analytics/models/event.dart';

class StoreCard extends ConsumerWidget {
  const StoreCard({Key? key, this.store}) : super(key: key);

  final Store? store;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => _onTap(ref, context),
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 150,
          maxHeight: 150,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          border: Border.all(
            color: AppColors.primary100,
          ),
        ),
        child: SizedBox.expand(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                getText(),
                style: TextStyles.subheading01,
                maxLines: 1,
              ),
              if (store == null)
                const Padding(
                  padding: EdgeInsets.only(top: 3),
                  child: Icon(
                    Icons.add,
                    color: AppColors.primary100,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String getText() {
    return store == null ? 'Create Store' : store!.name ?? 'Store Name';
  }

  void _onTap(WidgetRef ref, BuildContext context) async {
    Utils.trackEvent(
      event: Event(name: ActionsEvents.clickedStoreCard.name),
      ref: ref,
    );

    if (store == null) {
      final Store newStore = Store.initial();
      ref.read(storesControllerProvider.notifier).addStore(newStore);
      ref.read(storesControllerProvider.notifier).selectStore(newStore.id!);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const StoreEditor(),
        ),
      );
    } else {
      ref.read(storesControllerProvider.notifier).selectStore(store!.id!);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const StoreEditor(),
        ),
      );
    }
  }
}
