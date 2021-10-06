import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/controller/objects_providers.dart';
import 'package:shopifind/model/canv_object_model.dart';
import 'package:shopifind/utils.dart';

class Preview extends ConsumerWidget {
  const Preview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    Size dialogSize = const Size(380, 750);
    final List<CanvObjectModel> objs = watch(objRepositoryProvider).state;

    final storeDimensionObj =
        objs.firstWhere((element) => element.objType == ObjectType.store);

    final storePositionX = storeDimensionObj.position.dx;
    final storePositionY = storeDimensionObj.position.dy;

    final storePositionCenter = Offset(
      storePositionX + storeDimensionObj.width / 2,
      storePositionY + storeDimensionObj.height / 2,
    );

    final dialogCenter = Offset(dialogSize.width / 2, dialogSize.height / 2);

    // print('dialogCenter: ${dialogCenter.dy}');


    // final Offset centerMap = Offset(storePositionX, storePositionY);
    // final Offset centerScreenSize =
    //     Offset(dialogSize.width / 2, dialogSize.height / 2);
    // final Offset adjustment = centerScreenSize - centerMap;

    // print('centerScreenSize: $centerScreenSize');
    // print('centerMap: $centerMap');

    final testPosition = Offset(storePositionCenter
                      .dy - 30, storePositionCenter
                      .dx - 30);

    final Offset adjFactor = dialogCenter - storePositionCenter;

    // print(
    //     'storePositionCenter: $storePositionCenter | dialog center: $dialogCenter');
    // print('adjust center: $adjFactor');

    return Dialog(
      child: SizedBox(
        width: dialogSize.width,
        height: dialogSize.height,
        // child: Column(
        //   children: [
        // SizedBox(
        //   width: dialogSize.width * 0.7,
        //   height: dialogSize.height * 0.7,
        child: SizedBox.expand(
          child: InteractiveViewer(
              child: Stack(
            children: [
              for (final obj in objs)
                Positioned(
                  top: obj.position.dy, // + centerAdj.dy,
                  left: obj.position.dx, // + centerAdj.dx,
                  child: Utils.buildCanvObjChild(obj),
                ),
             
            //  Positioned(
            //       top: dialogCenter
            //           .dy -10 , // - adjFactor.dy, //storeDimensionObj.position.dy + centerAdj.dy,
            //       left: dialogCenter.dx -10, // - adjFactor.dx, //storeDimensionObj.position.dx + centerAdj.dx,
            //       child: Container(
            //         color: Colors.yellow,
            //         height: 20,
            //         width: 20,
            //       )),
            //     Positioned(
            //       top: storePositionCenter
            //           .dy, //storeDimensionObj.position.dy + centerAdj.dy,
            //       left: storePositionCenter
            //           .dx, //storeDimensionObj.position.dx + centerAdj.dx,
            //       child: Container(
            //         color: Colors.blue,
            //         height: 20,
            //         width: 20,
            //       )),
            //   Positioned(
            //       top: testPosition.dy, //storeDimensionObj.position.dy + centerAdj.dy,
            //       left: testPosition.dx, //storeDimensionObj.position.dx + centerAdj.dx,
            //       child: Container(
            //         color: Colors.red,
            //         height: 20,
            //         width: 20,
            //       )),
            ],
          )),
        ),
        // ),
        // SizedBox(
        //   width: dialogSize.width * 0.2,
        //   height: dialogSize.height * 0.2,
        //   child: Row(
        //     children: const [
        //       Padding(
        //         padding: EdgeInsets.all(4.0),
        //         child: InkWell(
        //           child: Icon(Icons.dashboard),
        //         ),
        //       ),
        //       Padding(
        //         padding: EdgeInsets.all(4.0),
        //         child: InkWell(
        //             child: Icon(Icons.file_copy),
        //           ),
        //       ),
        //       Padding(
        //         padding: EdgeInsets.all(4.0),
        //         child: InkWell(
        //             child: Icon(Icons.group),
        //           ),
        //       ),
        //       Padding(
        //         padding: EdgeInsets.all(4.0),
        //         child: InkWell(
        //             child: Icon(Icons.map),
        //           ),
        //       ),
        //     ],
        //   ))
        //   ],
        // ),
      ),
    );
  }
}
