import 'package:flutter/material.dart';
import 'package:shopifind/common/constants/app_colors.dart';
import 'package:shopifind/common/text/text_style.dart';
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
        name: splitContent.elementAt(1),
        price: productPrice,
        sectionId: updateSection ?? splitContent.elementAt(3),
      );
    }
  }

  static void showSnackbarMessage({
    required String message,
    required BuildContext context,
    required bool isError,
  }) {
    final snackBar = SnackBar(
        backgroundColor: AppColors.neutral200,
        elevation: 4.0,
        behavior: SnackBarBehavior.floating,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: TextStyles.heading02,
            ),
          ],
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
