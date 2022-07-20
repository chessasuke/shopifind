import 'package:shopifind/common/constants/app_colors.dart';
import 'package:shopifind/screen_store_editor/controller/objects_controller.dart';
import 'package:shopifind/screen_store_editor/controller/product_providers.dart';
import 'package:shopifind/screen_store_editor/controller/store_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/screen_store_editor/model/store.dart';
import 'package:shopifind/screen_store_editor/services/store_service.dart';
import 'package:shopifind/screen_store_editor/utils/utils.dart';
import 'package:shopifind/service/analytics/events/actions_events.dart';
import 'package:shopifind/service/analytics/models/event.dart';
import 'package:shopifind/service/analytics/providers/analytics_provider.dart';

class SaveStoreBtn extends ConsumerWidget {
  const SaveStoreBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: IconButton(
          onPressed: () => _saveStore(ref: ref, context: context),
          icon: const Icon(Icons.upload_sharp, color: AppColors.primary100)),
    );
  }

  void _saveStore(
      {required WidgetRef ref, required BuildContext context}) async {
    Utils.trackEvent(event: Event(name: ActionsEvents.saveStore.name), ref: ref);

    final Store? currentStore =
        ref.watch(storesControllerProvider.notifier).selectedStore;
    final products = ref.watch(productsControllerProvider);
    final objects = ref.watch(objectsControllerProvider.notifier).objects;

    if (currentStore != null) {
      final storeToSave =
          currentStore.copyWith(items: products, objects: objects);
      try {
        await ref
            .read(storeServiceProvider)
            .saveStoreToServer(store: storeToSave);
        Utils.showSnackbarMessage(
          isError: true,
          message: 'Store uploaded!',
          context: context,
        );
      } catch (e) {
        print('Error saving store: $e');
        Utils.showSnackbarMessage(
          isError: true,
          message: 'Error saving store. Please try again later',
          context: context,
        );
      }
    }
  }
}
