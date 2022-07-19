import 'package:auto_size_text/auto_size_text.dart';
import 'package:shopifind/common/constants/app_colors.dart';
import 'package:shopifind/common/text/text_style.dart';
import 'package:shopifind/common/widgets/basic_text_field.dart';
import 'package:shopifind/common/widgets/simple_button.dart';
import 'package:shopifind/screen_landing/landing_screen.dart';
import 'package:shopifind/screen_store_editor/controller/objects_controller.dart';
import 'package:shopifind/screen_store_editor/controller/product_providers.dart';
import 'package:shopifind/screen_store_editor/controller/store_controller.dart';
import 'package:shopifind/screen_store_editor/model/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/screen_store_editor/services/store_service.dart';
import 'package:shopifind/screen_store_editor/utils/utils.dart';

final storeNameProvider = StateProvider((ref) => '');

class ManageStoreBtn extends ConsumerWidget {
  const ManageStoreBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Store? currentStore =
        ref.watch(storesControllerProvider.notifier).selectedStore;

    return Padding(
      padding: const EdgeInsets.all(4),
      child: IconButton(
          onPressed: currentStore != null
              ? () async => showDialog(
                    context: context,
                    builder: (context) => _ManageStoreDialog(
                      currentStore: currentStore,
                    ),
                  )
              : null,
          icon: const Icon(Icons.store, color: AppColors.primary100)),
    );
  }
}

class _ManageStoreDialog extends ConsumerWidget {
  const _ManageStoreDialog({
    required this.currentStore,
    Key? key,
  }) : super(key: key);

  final Store currentStore;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 300,
        width: 400,
        color: AppColors.neutral200,
        // constraints: const BoxConstraints(maxHeight: 200, maxWidth: 300),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                AutoSizeText(
                  'Store Id: ${currentStore.id}',
                  style: TextStyles.subheading01,
                  maxLines: 1,
                ),
              ],
            ),
            BasicTextField(
              width: 100,
              onChange: (value) {
                if (value.isNotEmpty) {
                  ref.read(storeNameProvider.notifier).state = value;
                }
              },
              initialValue: currentStore.name!,
              labelText: 'Description',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SimpleButton(
                  color: AppColors.linkBlue,
                  text: 'Save Changes',
                  onTap: () => _onSave(context, ref),
                ),
                SimpleButton(
                  color: AppColors.error300,
                  onTap: () => _onDelete(context, ref),
                  text: 'Delete Store',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onSave(BuildContext context, WidgetRef ref) async {
    String newDescription = ref.read(storeNameProvider);
    if (newDescription.isEmpty) newDescription = 'Store Name';

    try {
      await ref
          .read(storeServiceProvider)
          .updateStoreName(id: currentStore.id!, name: newDescription);
      ref
          .read(storesControllerProvider.notifier)
          .editStore(newStore: currentStore.copyWith(name: newDescription));

      Utils.showSnackbarMessage(
        message: 'Name Updated!',
        context: context,
        isError: false,
      );
      Navigator.pop(context);
    } catch (e) {
      print('Error: $e');
      Utils.showSnackbarMessage(
        message: 'Error updating store name. Please, try again later.',
        context: context,
        isError: true,
      );
    }
  }

  void _onDelete(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(storeServiceProvider).deleteStore(currentStore.id!);
      ref.read(storesControllerProvider.notifier).removeStore(currentStore.id!);
      ref.read(productsControllerProvider.notifier).reset();
      ref.read(objectsControllerProvider.notifier).reset();

      Utils.showSnackbarMessage(
        message: 'Store Deleted',
        context: context,
        isError: false,
      );
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LandingScreen()),
          (route) => false);
    } catch (e) {
      print('Error: $e');
      Utils.showSnackbarMessage(
        message: 'Error deleting store. Please, try again later.',
        context: context,
        isError: true,
      );
    }
  }
}
