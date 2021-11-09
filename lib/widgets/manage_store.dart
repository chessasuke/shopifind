import 'package:shopifind/controller/objects_providers.dart';
import 'package:shopifind/controller/product_providers.dart';
import 'package:shopifind/controller/store_providers.dart';
import 'package:shopifind/screens/welcome_screen.dart';
import 'package:shopifind/service/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/widgets/upload_btn.dart';
import '../constants.dart';

final storeNameProvider = StateProvider((ref) => '');

class ManageStoreBtn extends ConsumerWidget {
  const ManageStoreBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final currentStore = watch(selectedStoreProvider).state;

    return Container(
      constraints: const BoxConstraints(
        maxHeight: 50,
      ),
      child: Container(
        decoration: kContainerDecoration,
        child: InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => SimpleDialog(
                      title: Text('Store Id: ${currentStore!.id}'),
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('Description',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1),
                                const SizedBox(width: 30),
                                Container(
                                    decoration: kContainerDecoration,
                                    width: 300,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyText1,
                                      initialValue: currentStore.description,
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          context
                                              .read(storeNameProvider)
                                              .state = value;
                                        }
                                      },
                                    )),
                              ],
                            ),
                            const Text('TODO - publish btn'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                    onPressed: () async {
                                      final newDescription =
                                          context.read(storeNameProvider).state;

                                      final statusMsg = await AppService
                                          .updateStoreDescription(
                                              currentStore.id, newDescription);

                                      if (statusMsg == 'ok') {
                                        context
                                            .read(storesControllerProvider
                                                .notifier)
                                            .editStoreDescription(
                                              id: currentStore.id,
                                              description: newDescription,
                                            );
                                        Navigator.pop(context);
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                const AlertDialog(
                                                    title: Text(
                                                        'Error Saving Changes')));
                                      }
                                    },
                                    child: AppBtn(text: 'Save Changes')),
                                TextButton(
                                    onPressed: () async {
                                      final statusMsg =
                                          await AppService.deleteStore(
                                              currentStore.id);

                                      if (statusMsg == 'ok') {
                                        /// reset state of store editor
                                        context
                                            .read(productsControllerProvider
                                                .notifier)
                                            .clear();

                                        context
                                            .read(
                                                objsControllerProvider.notifier)
                                            .clear();

                                        context
                                            .read(selectedStoreIdProvider)
                                            .state = '';
                                        context
                                            .read(selectedObjectProvider)
                                            .state = null;
                                        context
                                            .read(selectedObjectIdProvider)
                                            .state = '';
                                        context
                                            .read(selectedObjectProvider)
                                            .state = null;

                                        context.refresh(storeFetcherProvider);

                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    WelcomeScreen(
                                                      key: UniqueKey(),
                                                    )),
                                            (route) => false);
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: const Text(
                                                      'Error Deleting Store'),
                                                  content: Text(statusMsg),
                                                ));
                                      }
                                    },
                                    child: AppBtn(
                                        text: 'Delete Store',
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onError)),
                              ],
                            )
                          ],
                        )
                      ],
                    ));
          },
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              'Manage Store',
              style: Theme.of(context).primaryTextTheme.bodyText1,
            ),
          ),
        ),
      ),
    );
  }
}
