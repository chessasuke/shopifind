import 'package:flutter/material.dart';
import 'package:shopifind/screen_store_editor/model/canv_obj.dart';

class IconObject extends StatelessWidget {
  const IconObject({
    required this.object,
    Key? key,
  }) : super(key: key);

  final CanvObj object;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: object.width,
      height: object.height,
      child: FittedBox(
        fit: BoxFit.fill,
        child: SizedBox(
          width: 11,
          height: 11,
          child: Icon(
            object.objType.getIcon(),
            size: 10,
            color: Color(object.fillColor),
          ),
        ),
      ),
    );
  }
}
