import 'package:shopifind/controller/objects_providers.dart';
import 'package:shopifind/controller/product_providers.dart';
import 'package:shopifind/controller/store_providers.dart';
import 'package:shopifind/model/store_model.dart';
import 'package:shopifind/service/service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      color: Theme.of(context).colorScheme.primaryVariant,
      width: screenSize.width,
      height: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Tooltip(
            message: 'Save to Cloud',
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () async {
                    print('save products to server');

                    // final store = context.read(selectedStoreProvider).state;
                    // final store = StoreModel.initial();

                    final products =
                        context.read(productsBySectionProvider('')).state;

                    // final objects = context.read(objRepositoryProvider).state;

                    // final statusMsg = await AppService.uploadToSever(
                    //     store, products, objects);
                    // showDialog(
                    //     context: context,
                    //     builder: (context) {
                    //       return AlertDialog(
                    //         title: Text(
                    //           statusMsg == 'ok' ? 'Data Published!' : 'Error',
                    //           style: statusMsg == 'ok'
                    //               ? Theme.of(context).textTheme.bodyText1
                    //               : Theme.of(context)
                    //                   .textTheme
                    //                   .bodyText1!
                    //                   .copyWith(color: Colors.red),
                    //         ),
                    //         content: statusMsg != 'ok' ? Text(statusMsg) : null,
                    //       );
                    //     });
                  },
                  icon: const Icon(Icons.cloud_upload_rounded)),
            ),
          ),
          Tooltip(
            message: 'Preview',
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    print('upload products');
                    // Service.uploadProducts(products);
                  },
                  icon: const Icon(FontAwesomeIcons.eye)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  print('upload products');
                  // Service.uploadProducts(products);
                },
                icon: const Icon(FontAwesomeIcons.copy)),
          ),

          // Container(
          //   height: 25,
          //   width: 25,
          //   color: Theme.of(context).colorScheme.primary,
          // ),
          // Container(
          //   height: 25,
          //   width: 25,
          //   color: Theme.of(context).colorScheme.primaryVariant,
          // ),
          // Container(
          //   height: 25,
          //   width: 25,
          //   color: Theme.of(context).colorScheme.onPrimary,
          // ),
          // Container(
          //   height: 25,
          //   width: 25,
          //   color: Theme.of(context).colorScheme.secondary,
          // ),
          // Container(
          //   height: 25,
          //   width: 25,
          //   color: Theme.of(context).colorScheme.secondaryVariant,
          // ),
          // Container(
          //   height: 25,
          //   width: 25,
          //   color: Theme.of(context).colorScheme.onSecondary,
          // ),
          // Container(
          //   height: 25,
          //   width: 25,
          //   color: Theme.of(context).colorScheme.background,
          // ),
          // Container(
          //   height: 25,
          //   width: 25,
          //   color: Theme.of(context).colorScheme.onBackground,
          // ),
          // Container(
          //   height: 25,
          //   width: 25,
          //   color: Theme.of(context).colorScheme.surface,
          // ),
          // Container(
          //   height: 25,
          //   width: 25,
          //   color: Theme.of(context).colorScheme.onSurface,
          // ),
          // Container(
          //   height: 25,
          //   width: 25,
          //   color: Theme.of(context).colorScheme.error,
          // ),
          // Container(
          //   height: 25,
          //   width: 25,
          //   color: Theme.of(context).colorScheme.onError,
          // ),
        ],
      ),
    );
  }
}
