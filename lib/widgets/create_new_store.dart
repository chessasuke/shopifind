import 'package:shopifind/controller/store_providers.dart';
import 'package:shopifind/model/store_model.dart';
import 'package:shopifind/screens/store_editor.dart';
import 'package:shopifind/service/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateNewStore extends StatelessWidget {
  const CreateNewStore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: InkWell(
        onTap: () async {
          // final StoreModel newStore = await AppService.createStore();
          // context
          //     .read(storesControllerProvider.notifier)
          //     .add(StoreModel.initialWithId(id: storeId));
          // context.read(selectedStoreProvider).state = newStore;

          // print('newStore: $newStore');
          // if (!newStore.id.startsWith('error')) {
            // context.read(selectedStoreIdProvider).state = storeId;

            Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const StoreEditor(),
              ),
            );
          // } 
          // else {
          //   showDialog(
          //       context: context,
          //       builder: (context) => AlertDialog(
          //           title: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Center(
          //               child: Text('Error Creating Store',
          //                   style: Theme.of(context)
          //                       .primaryTextTheme
          //                       .headline3!
          //                       .copyWith(
          //                           color:
          //                               Theme.of(context).colorScheme.onError)),
          //             ),
          //           ),
          //           content: Text(newStore.id.replaceFirst('error', ''))));
          // }
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
              Text('New Store',
                  style: Theme.of(context).primaryTextTheme.headline3),
              const Padding(
                  padding: EdgeInsets.only(top: 3), child: Icon(Icons.add)),
            ],
          )),
        ),
      ),
    );
  }
}
