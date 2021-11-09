import 'package:shopifind/controller/objects_providers.dart';
import 'package:shopifind/controller/product_providers.dart';
import 'package:shopifind/controller/store_providers.dart';
import 'package:shopifind/model/canv_object_model.dart';
import 'package:shopifind/screens/welcome_screen.dart';
import 'package:shopifind/widgets/object_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
        color: Theme.of(context).colorScheme.primaryVariant,
        width: 150,
        height: screenSize.height,
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                bool? leave = false;
                leave = await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Are you sure you want to leave?'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Any change not saved will be lost'),
                            const SizedBox(height: 50),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Leave',
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .bodyText1),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Return',
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .bodyText1),
                                      ),
                                    ),
                                  )
                                ])
                          ],
                        ),
                      );
                    });

                if (leave != null) {
                  if (leave) {
                    /// reset state of store editor
                    context.read(productsControllerProvider.notifier).clear();
                    context.read(objsControllerProvider.notifier).clear();
                    context.read(selectedStoreIdProvider).state = '';
                    context.read(selectedObjectProvider).state = null;
                    context.read(selectedObjectIdProvider).state = '';
                    context.read(selectedObjectProvider).state = null;
                    context.refresh(storeFetcherProvider);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WelcomeScreen()),
                        (route) => false);
                  }
                }
              },
              child: SizedBox(
                  width: 150,
                  height: 50,
                  child: Center(
                      child: Text('ShopiFind',
                          style:
                              Theme.of(context).primaryTextTheme.headline3))),
            ),
            SizedBox(
              height: screenSize.height - 50,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minHeight: constraints.maxHeight, maxHeight: 10000),
                      child: SizedBox(
                        height: 600,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const ObjectEditor(),

                            Container(
                              height: 1,
                              width: 150,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),

                            /// Store dimensions
                            SizedBox(
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      print('Store dimensions');
                                      context
                                          .read(objsControllerProvider.notifier)
                                          .addObject(CanvObjectModel.initial()
                                              .copyWith(
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .primaryVariant,
                                            borderColor: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                            objType: ObjectType.store,
                                            name: 'Store Dimensions',
                                          ));

                                      print('object added');

                                      print(context.read(
                                          objsControllerProvider.notifier));
                                    },
                                    child: const Tooltip(
                                        message: 'Store Dimensions',
                                        child: Icon(
                                          FontAwesomeIcons.warehouse,
                                        )),
                                  ),

                                  /// Entry
                                  GestureDetector(
                                    onTap: () {
                                      context
                                          .read(objsControllerProvider.notifier)
                                          .addObject(CanvObjectModel.initial()
                                              .copyWith(
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .onBackground,
                                                  borderColor: Theme.of(context)
                                                      .colorScheme
                                                      .onBackground,
                                                  objType: ObjectType.entry,
                                                  name: 'Entrada'));
                                    },
                                    child: const Tooltip(
                                        message: 'Entry',
                                        child: Icon(FontAwesomeIcons.doorOpen)),
                                  ),
                                ],
                              ),
                            ),

                            /// Restroom
                            SizedBox(
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      context
                                          .read(objsControllerProvider.notifier)
                                          .addObject(
                                            CanvObjectModel.initial().copyWith(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .onBackground,
                                                borderColor: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground,
                                                objType: ObjectType.restroom,
                                                name: 'Restroom'),
                                          );
                                    },
                                    child: const Tooltip(
                                        message: 'Restroom',
                                        child: Icon(FontAwesomeIcons.restroom)),
                                  ),

                                  /// CASH REGISTER
                                  GestureDetector(
                                    onTap: () {
                                      context
                                          .read(objsControllerProvider.notifier)
                                          .addObject(
                                            CanvObjectModel.initial().copyWith(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .onBackground,
                                                borderColor: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground,
                                                objType: ObjectType.checkout,
                                                name: 'Checkout'),
                                          );
                                    },
                                    child: const Tooltip(
                                        message: 'Checkout',
                                        child: Icon(
                                            FontAwesomeIcons.cashRegister)),
                                  ),
                                ],
                              ),
                            ),

                            /// Square / Circle
                            SizedBox(
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      context
                                          .read(objsControllerProvider.notifier)
                                          .addObject(CanvObjectModel.initial()
                                              .copyWith(
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                            borderColor: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                            name: 'Info Center',
                                            objType: ObjectType.info,
                                          ));
                                    },
                                    child: const Tooltip(
                                        message: 'Info Center',
                                        child:
                                            Icon(FontAwesomeIcons.infoCircle)),
                                  ),

                                  /// SECTION
                                  GestureDetector(
                                    onTap: () {
                                      context
                                          .read(objsControllerProvider.notifier)
                                          .addObject(CanvObjectModel.initial()
                                              .copyWith(
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .primaryVariant,
                                                  borderColor: Theme.of(context)
                                                      .colorScheme
                                                      .onBackground,
                                                  simpleResize: false,
                                                  name: 'Section'));
                                    },
                                    child: const Tooltip(
                                        message: 'Section',
                                        child: Icon(FontAwesomeIcons.square)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
