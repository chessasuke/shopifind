import 'package:shopifind/controller/store_providers.dart';
import 'package:shopifind/model/store_model.dart';
import 'package:shopifind/screens/store_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StoreCard extends StatelessWidget {
  const StoreCard({Key? key, required this.store}) : super(key: key);

  final StoreModel store;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: InkWell(
        onTap: () async {
          print('storeId: ${store.id}');
          context.read(selectedStoreIdProvider).state = store.id;

          Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const StoreEditor(),
            ),
          );
        },
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border:
                  Border.all(color: Theme.of(context).colorScheme.onPrimary)),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(store.description,
                  overflow: TextOverflow.clip,
                  style: Theme.of(context).primaryTextTheme.headline3),
            ],
          )),
        ),
      ),
    );
  }
}
