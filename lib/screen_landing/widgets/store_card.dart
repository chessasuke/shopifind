import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:shopifind/screen_store_editor/controller/store_controller.dart';
import 'package:shopifind/screen_store_editor/model/store.dart';
import 'package:shopifind/screen_store_editor/store_editor_screen.dart';

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
              color: Theme.of(context).colorScheme.onPrimary,
            )),
        child: SizedBox.expand(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(getText(), maxLines: 1),
              if (store == null)
                const Padding(
                    padding: EdgeInsets.only(top: 3), child: Icon(Icons.add)),
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
