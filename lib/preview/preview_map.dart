// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shopifind/controller/objects_providers.dart';
// import 'package:shopifind/model/canv_object_model.dart';
// import 'package:shopifind/utils.dart';

// class PreviewMap extends StatefulWidget {
//   const PreviewMap({
//     Key? key,
//     required this.dialogSize,
//   }) : super(key: key);

//   final Size dialogSize;

//   @override
//   State<PreviewMap> createState() => _PreviewMapState();
// }

// class _PreviewMapState extends State<PreviewMap> {
//   late GlobalKey _mapKey;

//   @override
//   void initState() {
//     _mapKey = GlobalKey();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: widget.dialogSize.height - 54,
//       width: widget.dialogSize.width,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               decoration: BoxDecoration(
//                   border: Border.all(
//                       color: Theme.of(context).colorScheme.onBackground),
//                   borderRadius: const BorderRadius.horizontal(
//                       left: Radius.circular(15.0),
//                       right: Radius.circular(15.0))),
//               width: widget.dialogSize.width * 0.7,
//               height: 30,
//               child: const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Center(
//                   child: TextField(
//                     textAlign: TextAlign.center,
//                     decoration: InputDecoration(border: InputBorder.none),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Consumer(builder: (context, watch, child) {
//             final List<CanvObjectModel> objs =
//                 watch(objRepositoryProvider).state;

//             final storeDimensionObj = objs
//                 .firstWhere((element) => element.objType == ObjectType.store);

//             final storePositionX = storeDimensionObj.position.dx;
//             final storePositionY = storeDimensionObj.position.dy;

//             final storePositionCenter = Offset(
//               storePositionX + storeDimensionObj.width / 2,
//               storePositionY + storeDimensionObj.height / 2,
//             );

//             // final dialogCenter = Offset(dialogSize.width / 2, dialogSize.height / 2);

//             // /// adjustment of position based on alignment of dialog and store centers
//             // final centerAdjustment = dialogCenter - storePositionCenter;

//             print(
//                 'store dimensions: ${storeDimensionObj.width} | ${storeDimensionObj.width}');

//               final RenderBox renderBoxMap =
//                 _mapKey.currentContext!.findRenderObject() as RenderBox;
//             final mapPosition = renderBoxMap.localToGlobal(Offset.zero);
//             final mapCenterPosition = Offset(mapPosition.dx, mapPosition.dy);
//             final adjustment = (mapCenterPosition - storePositionCenter);

//             // Offset adjustMapPosition() {
//             //   final RenderBox renderBoxMap =
//             //       _mapKey.currentContext!.findRenderObject() as RenderBox;
//             //   final mapPosition = renderBoxMap.localToGlobal(Offset.zero);
//             //   final mapCenterPosition = Offset(mapPosition.dx, mapPosition.dy);
//             //   return (mapCenterPosition - storePositionCenter);
//             // }

//             return SizedBox(
//               key: _mapKey,
//               width: storeDimensionObj.width,
//               height: storeDimensionObj.height,
//               child: Center(
//                 child: InteractiveViewer(
//                     maxScale: 2,
//                     child: Stack(
//                       children: [
//                         Positioned(
//                           top: mapCenterPosition.dy,
//                           left: mapCenterPosition.dx,
//                           child: Container(color: Colors.redAccent, width: 10, height: 10,)),
//                                                   Positioned(
//                             top: storePositionCenter.dy,
//                             left: storePositionCenter.dx,
//                             child: Container(
//                               color: Colors.blue,
//                               width: 10,
//                               height: 10,
//                             )),
//                                                                               Positioned(
//                             top: adjustment.dy,
//                             left: adjustment.dx,
//                             child: Container(
//                               color: Colors.yellow,
//                               width: 10,
//                               height: 10,
//                             )),
//                         // for (final obj in objs)
//                         //   Positioned(
//                         //     left: obj.position.dx + adjustMapPosition().dx,
//                         //     top: obj.position.dy + adjustMapPosition().dy,
//                         //     child: Utils.buildCanvObjChild(obj),
//                         //   ),
//                       ],
//                     )),
//               ),
//             );
//           }),
//         ],
//       ),
//     );
//   }
// }
