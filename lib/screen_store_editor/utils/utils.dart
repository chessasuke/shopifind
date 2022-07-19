import 'package:shopifind/screen_store_editor/model/canvas_object_type.dart';
import 'package:shopifind/screen_store_editor/model/product.dart';

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

  static List<String> splitContentByLines(String content) {
    final splitContent = content.split("\n");
    return splitContent;
  }

  static dynamic getProductFromLine(String productData,
      [String? updateSection]) {
    String error = '';
    final splitContent = productData.split(",");
    if (splitContent.length != 4) {
      error = 'product data invalid field';
      return error;
    } else {
      final productPrice = double.tryParse(splitContent.elementAt(2));
      if (productPrice == null) {
        error = 'product price was invalid';
        return error;
      }
      return Product(
        id: splitContent.elementAt(0),
        description: splitContent.elementAt(1),
        price: productPrice,
        sectionId: updateSection ?? splitContent.elementAt(3),
      );
    }
  }
}
