// import 'package:shopifind/screen_store_editor/model/canvas_object_type.dart';
// import 'package:shopifind/screen_store_editor/model/product.dart';
// import 'package:uuid/uuid.dart';

// // enum ObjectType { store, section, info, checkout, restroom, entry }

// class Utils {
  
//   static ObjectType stringToObjType(String type) {
//     switch (type) {
//       case 'section':
//         return ObjectType.section;
//       case 'info':
//         return ObjectType.info;
//       case 'checkout':
//         return ObjectType.checkout;
//       case 'restroom':
//         return ObjectType.restroom;
//       case 'entry':
//         return ObjectType.entry;
//       default:
//         return ObjectType.store;
//     }
//   }

//   // static String generateId() {
//   //   return const Uuid().v4();
//   // }

//   // static List<String> splitContentByLines(String content) {
//   //   final splitContent = content.split("\n");
//   //   return splitContent;
//   // }

//   // static dynamic getProductFromLine(String content, [String? updateSection]) {
//   //   String error = '';

//   //   final splitContent = content.split(",");
//   //   if (splitContent.length != 4) {
//   //     error = 'product data wrong length';
//   //     print(error);
//   //     return error;
//   //   }

//   //   if (splitContent.elementAt(0) is! String) {
//   //     error = 'product id is not a string';
//   //     print(error);
//   //     return error;
//   //   } else if (splitContent.elementAt(1) is! String) {
//   //     error = 'product description is not a string';
//   //     print(error);
//   //     return error;
//   //   } else if (double.tryParse(splitContent.elementAt(2)) == null) {
//   //     error = 'product price is not a double';
//   //     print(error);
//   //     return error;
//   //   } else if (splitContent.elementAt(3) is! String) {
//   //     error = 'product section is not a string';
//   //     print(error);
//   //     return error;
//   //   } else {
//   //     String id = splitContent.elementAt(0);
//   //     String description = splitContent.elementAt(1);
//   //     double price = double.parse(splitContent.elementAt(2));
//   //     late String sectionId;
//   //     if (updateSection != null) {
//   //       sectionId = updateSection;
//   //     } else {
//   //       sectionId = splitContent.elementAt(3);
//   //     }

//   //     return Product(
//   //       id: id,
//   //       description: description,
//   //       sectionId: sectionId,
//   //       price: price,
//   //     );
//   //   }
//   // }
// }
