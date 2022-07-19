// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class SidebarOptions extends ConsumerWidget {
//   const SidebarOptions({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Column(
//         children: [

//         ],
//       ),
//     );
//   }

// // void _onTap() async {
// //     bool? leave = false;
// //     leave = await showDialog(
// //         context: context,
// //         builder: (context) {
// //           return AlertDialog(
// //             title: const Text('Are you sure you want to leave?'),
// //             content: Column(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 const Text('Any change not saved will be lost'),
// //                 const SizedBox(height: 50),
// //                 Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                     children: [
// //                       TextButton(
// //                         onPressed: () => Navigator.pop(context, true),
// //                         child: Container(
// //                           decoration: BoxDecoration(
// //                               border: Border.all(
// //                                   color: Theme.of(context)
// //                                       .colorScheme
// //                                       .onBackground),
// //                               borderRadius:
// //                                   const BorderRadius.all(Radius.circular(10))),
// //                           child: Padding(
// //                             padding: const EdgeInsets.all(8.0),
// //                             child: Text('Leave',
// //                                 style: Theme.of(context)
// //                                     .primaryTextTheme
// //                                     .bodyText1),
// //                           ),
// //                         ),
// //                       ),
// //                       TextButton(
// //                         onPressed: () => Navigator.pop(context, false),
// //                         child: Container(
// //                           decoration: BoxDecoration(
// //                               border: Border.all(
// //                                   color: Theme.of(context)
// //                                       .colorScheme
// //                                       .onBackground),
// //                               borderRadius:
// //                                   const BorderRadius.all(Radius.circular(10))),
// //                           child: Padding(
// //                             padding: const EdgeInsets.all(8.0),
// //                             child: Text('Return',
// //                                 style: Theme.of(context)
// //                                     .primaryTextTheme
// //                                     .bodyText1),
// //                           ),
// //                         ),
// //                       )
// //                     ])
// //               ],
// //             ),
// //           );
// //         });

// //     if (leave != null) {
// //       if (leave) {
// //         /// reset state of store editor
// //         ref.read(productsControllerProvider.notifier).clear();
// //         ref.read(objsControllerProvider.notifier).clear();
// //         ref.read(selectedStoreIdProvider.notifier).state = '';
// //         ref.read(selectedObjectProvider.notifier).state = null;
// //         ref.read(selectedObjectIdProvider.notifier).state = '';
// //         ref.read(selectedObjectProvider.notifier).state = null;
// //         ref.refresh(storeFetcherProvider);
// //         Navigator.pushAndRemoveUntil(
// //             context,
// //             MaterialPageRoute(builder: (context) => const LandingScreen()),
// //             (route) => false);
// //       }
// //     }
// //   }

// }
