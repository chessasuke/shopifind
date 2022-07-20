import 'package:auto_size_text/auto_size_text.dart';
import 'package:shopifind/common/constants/app_colors.dart';
import 'package:shopifind/common/text/text_style.dart';
import 'package:shopifind/common/widgets/basic_text_field.dart';
import 'package:shopifind/common/widgets/simple_button.dart';
import 'package:shopifind/screen_landing/landing_screen.dart';
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
              mainAxisAlignment: MainAxisAlignment.center,
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
              labelText: 'Name',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SimpleButton(
                  color: AppColors.neutral200,
                  style: TextStyles.caption01
                      .copyWith(color: AppColors.success500),
                  text: 'Save Changes',
                  onTap: () => _onSave(context, ref),
                ),
                SimpleButton(
                  color: AppColors.neutral200,
                  onTap: () => _onDelete(context, ref),
                  text: 'Delete Store',
                  style: TextStyles.caption01
                      .copyWith(color: AppColors.error500),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onSave(BuildContext context, WidgetRef ref) async {
    String newName = ref.read(storeNameProvider);
    if (newName.isEmpty) newName = 'Store Name';
    if (currentStore.isSaved == false) {
      Utils.showSnackbarMessage(
        message: "Please first save the store.",
        context: context,
        isError: false,
      );
      return;
    }

    try {
      await ref
          .read(storeServiceProvider)
          .updateStoreName(id: currentStore.id!, name: newName);
      ref
          .read(storesControllerProvider.notifier)
          .editStore(newStore: currentStore.copyWith(name: newName));

      Utils.showSnackbarMessage(
        message: 'Name Updated!',
        context: context,
        isError: false,
      );
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
    // if (currentStore.isSaved == false) {
    //   Utils.showSnackbarMessage(
    //     message: "Store is not saved.",
    //     context: context,
    //     isError: false,
    //   );
    //   return;
    // }
    try {
      await ref.read(storeServiceProvider).deleteStore(currentStore.id!);
      ref.read(storesControllerProvider.notifier).removeStore(currentStore.id!);
      Utils.showSnackbarMessage(
        message: 'Store Deleted',
        context: context,
        isError: false,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LandingScreen(),
        ),
      );
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
