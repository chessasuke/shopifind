// import 'package:shopifind/controller/objects_providers.dart';
// import 'package:shopifind/controller/product_providers.dart';
// import 'package:shopifind/store_editor/providers/store_providers.dart';
// import 'package:shopifind/screens/landing_screen.dart';
// import 'package:shopifind/service/service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../constants.dart';

// final storeNameProvider = StateProvider((ref) => '');

// class ManageStoreBtn extends ConsumerWidget {
//   const ManageStoreBtn({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final currentStore = ref.watch(selectedStoreProvider);

//     return Container(
//       constraints: const BoxConstraints(
//         maxHeight: 50,
//       ),
//       child: Container(
//         decoration: kContainerDecoration,
//         child: InkWell(
//           onTap: () {
//             showDialog(
//                 context: context,
//                 builder: (context) => SimpleDialog(
//                       title: Text('Store Id: ${currentStore!.id}'),
//                       children: [
//                         Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Text('Description',
//                                     style: Theme.of(context)
//                                         .primaryTextTheme
//                                         .bodyText1),
//                                 const SizedBox(width: 30),
//                                 Container(
//                                     decoration: kContainerDecoration,
//                                     width: 300,
//                                     child: TextFormField(
//                                       textAlign: TextAlign.center,
//                                       style: Theme.of(context)
//                                           .primaryTextTheme
//                                           .bodyText1,
//                                       initialValue: currentStore.description,
//                                       onChanged: (value) {
//                                         if (value.isNotEmpty) {
//                                           ref
//                                               .read(storeNameProvider.notifier)
//                                               .state = value;
//                                         }
//                                       },
//                                     )),
//                               ],
//                             ),
//                             const Text('TODO - publish btn'),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 TextButton(
//                                     onPressed: () async {
//                                       final newDescription =
//                                           ref.read(storeNameProvider);

//                                       final statusMsg = await AppService
//                                           .updateStoreDescription(
//                                               currentStore.id, newDescription);

//                                       if (statusMsg == 'ok') {
//                                         ref
//                                             .read(storesControllerProvider
//                                                 .notifier)
//                                             .editStoreDescription(
//                                               id: currentStore.id,
//                                               description: newDescription,
//                                             );
//                                         Navigator.pop(context);
//                                       } else {
//                                         showDialog(
//                                             context: context,
//                                             builder: (context) =>
//                                                 const AlertDialog(
//                                                     title: Text(
//                                                         'Error Saving Changes')));
//                                       }
//                                     },
//                                     child: AppBtn(text: 'Save Changes')),
//                                 TextButton(
//                                     onPressed: () async {
//                                       final statusMsg =
//                                           await AppService.deleteStore(
//                                               currentStore.id);

//                                       if (statusMsg == 'ok') {
//                                         /// reset state of store editor
//                                         ref
//                                             .read(productsControllerProvider
//                                                 .notifier)
//                                             .clear();

//                                         ref
//                                             .read(
//                                                 objsControllerProvider.notifier)
//                                             .clear();

//                                         ref
//                                             .read(selectedStoreIdProvider
//                                                 .notifier)
//                                             .state = '';
//                                         ref
//                                             .read(
//                                                 selectedObjectProvider.notifier)
//                                             .state = null;
//                                         ref
//                                             .read(selectedObjectIdProvider
//                                                 .notifier)
//                                             .state = '';
//                                         ref
//                                             .read(
//                                                 selectedObjectProvider.notifier)
//                                             .state = null;

//                                         ref.refresh(storeFetcherProvider);

//                                         Navigator.pushAndRemoveUntil(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     LandingScreen(
//                                                       key: UniqueKey(),
//                                                     )),
//                                             (route) => false);
//                                       } else {
//                                         showDialog(
//                                             context: context,
//                                             builder: (context) => AlertDialog(
//                                                   title: const Text(
//                                                       'Error Deleting Store'),
//                                                   content: Text(statusMsg),
//                                                 ));
//                                       }
//                                     },
//                                     child: AppBtn(
//                                         text: 'Delete Store',
//                                         color: Theme.of(context)
//                                             .colorScheme
//                                             .onError)),
//                               ],
//                             )
//                           ],
//                         )
//                       ],
//                     ));
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(4),
//             child: Text(
//               'Manage Store',
//               style: Theme.of(context).primaryTextTheme.bodyText1,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
