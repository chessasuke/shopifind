import 'package:shopifind/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uuid/uuid.dart';
import 'model/canv_object_model.dart';

enum ObjectType { store, section, info, checkout, restroom, entry }

class Utils {
  static ObjectType stringToObjType(String type) {
    switch (type) {
      case 'section':
        return ObjectType.section;
      case 'info':
        return ObjectType.info;
      case 'checkout':
        return ObjectType.checkout;
      case 'restroom':
        return ObjectType.restroom;
      case 'entry':
        return ObjectType.entry;
      default:
        return ObjectType.store;
    }
  }

    static String objTypeToString(ObjectType type) {
    switch (type) {
      case ObjectType.section:
        return 'section';
      case ObjectType.info:
        return 'info' ;
      case ObjectType.checkout:
        return 'checkout';
      case ObjectType.restroom:
        return 'restroom';
      case ObjectType.entry:
        return 'entry';
      default:
        return 'store';
    }
  }

  static String generateId() {
    return const Uuid().v4();
  }

  static Widget buildCanvObjChild(
      CanvObjectModel object) {
    switch (object.objType) {
      case ObjectType.restroom:
        return SizedBox(
          width: object.width,
          height: object.height,
          child: FittedBox(
            fit: BoxFit.fill,
            child: SizedBox(
                width: 11,
                height: 11,
                child: Icon(
                  FontAwesomeIcons.restroom,
                  size: 10,
                  color: object.backgroundColor,
                )),
          ),
        );

      case ObjectType.entry:
        return SizedBox(
          width: object.width,
          height: object.height,
          child: FittedBox(
            fit: BoxFit.fill,
            child: SizedBox(
                width: 11,
                height: 11,
                child: Icon(FontAwesomeIcons.doorOpen,
                    size: 10, color: object.backgroundColor)),
          ),
        );

      case ObjectType.info:
        return SizedBox(
          width: object.width,
          height: object.height,
          child: FittedBox(
            fit: BoxFit.fill,
            child: SizedBox(
                width: 11,
                height: 11,
                child: Icon(FontAwesomeIcons.infoCircle,
                    size: 10, color: object.backgroundColor)),
          ),
        );

      case ObjectType.checkout:
        return SizedBox(
          width: object.width,
          height: object.height,
          child: FittedBox(
            fit: BoxFit.fill,
            child: SizedBox(
                width: 11,
                height: 11,
                child: Icon(FontAwesomeIcons.cashRegister,
                    size: 10, color: object.backgroundColor)),
          ),
        );

      case ObjectType.store:
          print(
            'store dimensoins: ${object.width} | ${object.width}');
        return Container(
          decoration: BoxDecoration(
            color: object.backgroundColor,
            borderRadius:
                BorderRadius.all(Radius.circular(object.cornerRadius)),
            border: Border.all(
              width: 1,
              color: object.borderColor,
            ),
          ),
          width: object.width,
          height: object.height,
        );

      /// default to ObjectType.section
      default:
        return Container(
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.all(Radius.circular(object.cornerRadius)),
            border: Border.all(width: 1, color: object.borderColor),
            color: object.backgroundColor,
          ),
          width: object.width,
          height: object.height,
          child: Center(
            child: Text(
              object.name,
              overflow: TextOverflow.fade,
            ),
          ),
        );
    }
  }

  static List<String> splitContentByLines(String content) {
    final splitContent = content.split("\n");
    return splitContent;
  }

  static dynamic getProductFromLine(String content, [String? updateSection]) {
    String error = '';

    final splitContent = content.split(",");
    if (splitContent.length != 4) {
      error = 'product data wrong length';
      print(error);
      return error;
    }

    if (splitContent.elementAt(0) is! String) {
      error = 'product id is not a string';
      print(error);
      return error;
    } else if (splitContent.elementAt(1) is! String) {
      error = 'product description is not a string';
      print(error);
      return error;
    } else if (double.tryParse(splitContent.elementAt(2)) == null) {
      error = 'product price is not a double';
      print(error);
      return error;
    } else if (splitContent.elementAt(3) is! String) {
      error = 'product section is not a string';
      print(error);
      return error;
    } else {
      String id = splitContent.elementAt(0);
      String description = splitContent.elementAt(1);
      double price = double.parse(splitContent.elementAt(2));
      late String sectionId;
      if (updateSection != null) {
        sectionId = updateSection;
      } else {
        sectionId = splitContent.elementAt(3);
      }

      return ProductModel(
        id: id,
        description: description,
        sectionId: sectionId,
        price: price,
      );
    }
  }
}
