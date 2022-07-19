import 'package:flutter/material.dart';
import 'package:shopifind/screen_store_editor/model/canv_obj.dart';
import 'package:shopifind/screen_store_editor/model/canvas_object_type.dart';

class SectionObject extends StatelessWidget {
  const SectionObject({
    required this.object,
    Key? key,
  }) : super(key: key);

  final CanvObj object;

  @override
  Widget build(BuildContext context) {
    if (object.objType == ObjectType.section ||
        object.objType == ObjectType.store) {
      return _SectionObjectBorder(object: object);
    } else {
      return const SizedBox();
    }
  }
}

class _SectionObjectBorder extends StatelessWidget {
  const _SectionObjectBorder({
    required this.object,
    Key? key,
  }) : super(key: key);

  final CanvObj object;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(object.fillColor),
        borderRadius: BorderRadius.all(Radius.circular(object.cornerRadius)),
        border: Border.all(
          width: 1,
          color: Color(object.borderColor),
        ),
      ),
      width: object.width,
      height: object.height,
      child: object.objType == ObjectType.section
          ? Center(
              child: Text(
                object.description,
                overflow: TextOverflow.fade,
              ),
            )
          : null,
    );
  }
}
