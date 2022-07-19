// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shopifind/controller/product_providers.dart';
// import 'package:shopifind/service/service.dart';
// import 'package:flutter/material.dart';
// import 'package:shopifind/store_editor/model/product.dart';
// import '../constants.dart';
// import '../utils.dart';

// class DialogUploadBtn extends ConsumerWidget {
//   const DialogUploadBtn({Key? key, required this.sectionID}) : super(key: key);

//   final String sectionID;

//   Future<void> processContent(
//     String rawContent,
//     String currentSectionId,
//     WidgetRef ref,
//     BuildContext context,
//   ) async {
//     final listRawProducts = Utils.splitContentByLines(rawContent);
//     print('processed ${listRawProducts.length} products');
//     int lineCount = 1;
//     for (final item in listRawProducts) {
//       final product = Utils.getProductFromLine(item, currentSectionId);
//       if (product is Product) {
//         ref.read(productsControllerProvider.notifier).add(product);
//       } else if (product is String) {
//         await showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//                   title: const Text('Error in Product Data'),
//                   content: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text('Error in line $lineCount. \n' +
//                           product +
//                           '\nSkipping record'),
//                       TextButton(
//                           onPressed: () => Navigator.pop(context),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                                 decoration: BoxDecoration(
//                                     border: Border.all(
//                                         color: Theme.of(context)
//                                             .colorScheme
//                                             .background),
//                                     borderRadius: const BorderRadius.all(
//                                         Radius.circular(10))),
//                                 child: Text(
//                                   'Continue',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Theme.of(context)
//                                           .colorScheme
//                                           .onBackground),
//                                 )),
//                           ))
//                     ],
//                   ),
//                 ));
//       }
//       lineCount++;
//     }
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: Row(
//         children: [
//           Container(
//             constraints: const BoxConstraints(
//               maxHeight: 50,
//             ),
//             child: GestureDetector(
//                 onTap: () async {
//                   final rawContent = await AppService.pickFileDesktop();
//                   if (rawContent != null) {
//                     await processContent(
//                       rawContent,
//                       sectionID,
//                       ref,
//                       context,
//                     );
//                   }
//                 },
//                 child: const AppBtn(text: 'Upload')),
//           ),
//         ],
//       ),
//     );
//   }
// }
