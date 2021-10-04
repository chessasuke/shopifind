// import 'package:canvas_testing/canvas/utils.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class CanvObjectModel extends Equatable {
//   const CanvObjectModel({
//     required this.height,
//     required this.id,
//     required this.position,
//     required this.width,
//     required this.child,
//   });

//   final String id;
//   final double width;
//   final double height;
//   final Offset position;
//   final Widget child;

//   factory CanvObjectModel.initial() => CanvObjectModel(
//       height: 100,
//       id: Utils.generateId(),
//       position: Offset.zero,
//       width: 100,
//       child: const SizedBox());

//   CanvObjectModel copyWith({
//     String? id,
//     Offset? position,
//     double? width,
//     double? height,
//     Widget? child,
//   }) {
//     return CanvObjectModel(
//       id: id ?? this.id,
//       position: position ?? this.position,
//       width: width ?? this.width,
//       height: height ?? this.height,
//       child: child ?? this.child,
//     );
//   }

//   String get objId => id;
//   Size get size => Size(width, height);
//   Offset get offset => position;
//   Rect get rect => offset & size;

//   @override
//   List<Object?> get props => [id, position, child, height, width];
// }

// class CanvObjNotifier extends StateNotifier {
//   CanvObjNotifier([CanvObjectModel? canvObj])
//       : super(canvObj ?? CanvObjectModel.initial());

//   Offset get position => state.position;

//   double get width => state.width;

//   double get height => state.height;

//   void updatePosition(Offset newPosition) {
//     final newState = state.copyWith(position: newPosition);
//     state = newState;
//   }

//   void updateWidth(double newWidth) {
//     final newState = state.copyWith(width: newWidth);
//     state = newState;
//   }

//   void updateHeight(double newHeight) {
//     final newState = state.copyWith(height: newHeight);
//     state = newState;
//   }
// }

// final objProvider = StateNotifierProvider((ref) => CanvObjNotifier());

// class TestSingleObj extends StatelessWidget {
//   const TestSingleObj({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;

//     return SizedBox(
//         width: screenSize.width,
//         height: screenSize.height,
//         child: Stack(
//           children: const [
//             Center(
//               child: CanvObject(),
//             )
//           ],
//         ));
//   }
// }

// class CanvObject extends StatelessWidget {
//   const CanvObject({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(builder: (context, watch, child) {
//       final object = watch(objProvider);

//       return Stack(
//         children: [
//           Positioned(
//             left: object.position.dx,
//             top: object.position.dy,
//             child: SizedBox(
//               width: object.width + 10,
//               height: object.height + 10,
//               child: Align(
//                 child: Listener(
//                   onPointerMove: (details) {
//                     print('details: ${details.delta}');
//                     print('old position: ${object.position}');
//                     final newPosition =
//                         context.read(objProvider.notifier).position +
//                             details.delta;
//                     print('new position: $newPosition');
//                     context
//                         .read(objProvider.notifier)
//                         .updatePosition(newPosition);
//                   },
//                   child: Container(
//                     color: Colors.red,
//                     width: object.width,
//                     height: object.height,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             left: object.position.dx + object.width,
//             top: object.position.dy + (object.height / 2 - 5),
//             child: GestureDetector(
//               onHorizontalDragUpdate: (details) {
//                 var newWidth =
//                     context.read(objProvider.notifier).width + details.delta.dx;
//                 if (newWidth < 15) newWidth = 15;
//                 context.read(objProvider.notifier).updateWidth(newWidth);
//               },
//               child: Container(
//                 width: 15,
//                 height: 15,
//                 decoration: const BoxDecoration(
//                   color: Colors.yellow,
//                   shape: BoxShape.circle,
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             left: object.position.dx + object.width / 2 - 5,
//             top: object.position.dy + object.height,
//             child: GestureDetector(
//               onVerticalDragUpdate: (details) {
//                 var newHeight = context.read(objProvider.notifier).height +
//                     details.delta.dy;
//                 if (newHeight < 15) newHeight = 15;
//                 context.read(objProvider.notifier).updateHeight(newHeight);
//               },
//               child: Container(
//                 width: 15,
//                 height: 15,
//                 decoration: const BoxDecoration(
//                   color: Colors.yellow,
//                   shape: BoxShape.circle,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       );
//     });
//   }
// }
