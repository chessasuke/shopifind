import 'package:shopifind/controller/store_providers.dart';
import 'package:shopifind/model/store_model.dart';
import 'package:shopifind/service/service.dart';
import 'package:shopifind/widgets/create_new_store.dart';
import 'package:shopifind/widgets/store_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding:
                const EdgeInsets.only(left: 16.0, right: 4, top: 4, bottom: 4),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.background,
              child: Text(
                'A',
                style: Theme.of(context).primaryTextTheme.headline3,
              ),
            ),
          ),
          elevation: 1,
          backgroundColor:
              Theme.of(context).colorScheme.primaryVariant.withOpacity(0.98),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body:SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(100.0),
                      child: Text(
                        'ShopiFind',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    )),
                    const CreateNewStore(),
                    
                  ],
                ),
              )
        
        //  Consumer(builder: (context, watch, child) {
        //   final query = watch(storeFetcherProvider);
        //   return query.when(
        //     data: (stores) {

        //       print('stores is empty? ${stores.isEmpty}');

        //       return SingleChildScrollView(
        //         child: Column(
        //           children: [
        //             Center(
        //                 child: Padding(
        //               padding: const EdgeInsets.all(100.0),
        //               child: Text(
        //                 'ShopiFind',
        //                 style: Theme.of(context).textTheme.headline2,
        //               ),
        //             )),
        //             const CreateNewStore(),
        //             if (stores.isNotEmpty)
        //               for (final store in stores)
        //                 Row(
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     children: [StoreCard(store: store)],
        //                   )
                      
        //           ],
        //         ),
        //       );
        //     },
        //     loading: () => const CircularProgressIndicator(),
        //     error: (error, _) => Center(child: Text(error.toString())),
        //   );
        // })

        // FutureBuilder(
        //   future: AppService.fetchStores(),
        //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        //     if (snapshot.hasData) {
        //       final QuerySnapshot query = snapshot.data as QuerySnapshot;

        //
        //     } else if (snapshot.hasError) {
        //       return Center(child: Text('Error: ${snapshot.error}'));
        //     } else {
        //       return const Center(
        //           child: SizedBox(child: CircularProgressIndicator()));
        //     }
        //   },
        // ),
        );
  }
}
