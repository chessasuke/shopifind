// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shopifind/controller/objects_providers.dart';
// import 'package:shopifind/controller/product_providers.dart';
// import 'package:shopifind/store_editor/providers/store_providers.dart';
// import 'package:shopifind/service/service.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:shopifind/widgets/manage_store.dart';

// class TopBar extends ConsumerWidget {
//   const TopBar({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final screenSize = MediaQuery.of(context).size;
//     return Container(
//       color: Theme.of(context).colorScheme.primaryVariant,
//       width: screenSize.width,
//       height: 75,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           const ManageStoreBtn(),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               Tooltip(
//                 message: 'Save to Cloud',
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: IconButton(
//                       onPressed: () async {
//                         print('save products to server');

//                         final store = ref.read(selectedStoreProvider);

//                         final products =
//                             ref.read(productsBySectionProvider(''));

//                         final objects = ref.read(objRepositoryProvider);

//                         final statusMsg = await AppService._uploadToSever(
//                           store!,
//                           products,
//                           objects,
//                         );
//                         showDialog(
//                             context: context,
//                             builder: (context) {
//                               return AlertDialog(
//                                 title: Text(
//                                   statusMsg == 'ok'
//                                       ? 'Data Published!'
//                                       : 'Error',
//                                   style: statusMsg == 'ok'
//                                       ? Theme.of(context).textTheme.bodyText1
//                                       : Theme.of(context)
//                                           .textTheme
//                                           .bodyText1!
//                                           .copyWith(color: Colors.red),
//                                 ),
//                                 content:
//                                     statusMsg != 'ok' ? Text(statusMsg) : null,
//                               );
//                             });
//                       },
//                       icon: const Icon(Icons.cloud_upload_rounded)),
//                 ),
//               ),
//               // Tooltip(
//               //   message: 'Preview',
//               //   child: Padding(
//               //     padding: const EdgeInsets.all(8.0),
//               //     child: IconButton(
//               //         onPressed: () {
//               //           print('preview');
//               //           showDialog(
//               //               context: context,
//               //               builder: (context) => const Preview());
//               //         },
//               //         icon: const Icon(FontAwesomeIcons.eye)),
//               //   ),
//               // ),

//               // Container(
//               //   height: 25,
//               //   width: 25,
//               //   color: Theme.of(context).colorScheme.primary,
//               // ),
//               // Container(
//               //   height: 25,
//               //   width: 25,
//               //   color: Theme.of(context).colorScheme.primaryVariant,
//               // ),
//               // Container(
//               //   height: 25,
//               //   width: 25,
//               //   color: Theme.of(context).colorScheme.onPrimary,
//               // ),
//               // Container(
//               //   height: 25,
//               //   width: 25,
//               //   color: Theme.of(context).colorScheme.secondary,
//               // ),
//               // Container(
//               //   height: 25,
//               //   width: 25,
//               //   color: Theme.of(context).colorScheme.secondaryVariant,
//               // ),
//               // Container(
//               //   height: 25,
//               //   width: 25,
//               //   color: Theme.of(context).colorScheme.onSecondary,
//               // ),
//               // Container(
//               //   height: 25,
//               //   width: 25,
//               //   color: Theme.of(context).colorScheme.background,
//               // ),
//               // Container(
//               //   height: 25,
//               //   width: 25,
//               //   color: Theme.of(context).colorScheme.onBackground,
//               // ),
//               // Container(
//               //   height: 25,
//               //   width: 25,
//               //   color: Theme.of(context).colorScheme.surface,
//               // ),
//               // Container(
//               //   height: 25,
//               //   width: 25,
//               //   color: Theme.of(context).colorScheme.onSurface,
//               // ),
//               // Container(
//               //   height: 25,
//               //   width: 25,
//               //   color: Theme.of(context).colorScheme.error,
//               // ),
//               // Container(
//               //   height: 25,
//               //   width: 25,
//               //   color: Theme.of(context).colorScheme.onError,
//               // ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
