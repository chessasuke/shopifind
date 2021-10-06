import 'package:shopifind/model/store_model.dart';
import 'package:shopifind/service/service.dart';

import '../controller/store_providers.dart' show storeFetcherProvider;
import 'package:shopifind/widgets/create_new_store.dart';
import 'package:shopifind/widgets/store_card.dart';
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
    final screenSize = MediaQuery.of(context).size;

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

      body: FutureBuilder(
        future: AppService.fetchStores(),
        builder: (context, snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = [Consumer(builder: (context, watch, child) {
              return 
                    SingleChildScrollView(
        child: Consumer(builder: (context, watch, child) {
          final query = watch(storeFetcherProvider);

          return query.when(
            data: (stores) {
              return Column(
                children: [
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.all(100.0),
                    child: Text(
                      'ShopiFind',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  )),
                  buildStoresList(
                      stores: stores, screenWidth: screenSize.width)
                ],
              );
            },
            loading: () => const SizedBox(
                height: 100, width: 100, child: CircularProgressIndicator()),
            error: (error, _) =>
                Center(child: Text('${error.toString()} | ${_.toString()}')),
          );
        }),
      );
            })];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              )
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }

  Wrap buildStoresList(
      {required List<StoreModel> stores, required double screenWidth}) {
    List<Widget> allWidgets = [];
    allWidgets.add(const CreateNewStore());

    for (final store in stores) {
      allWidgets.add(StoreCard(store: store));
    }
    return Wrap(
        spacing: 8.0, // gap between adjacent chips
        runSpacing: 4.0,
        children: allWidgets);
  }
}
