import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'font_weights.dart';

class TextStyles {
  static const String fontFamily = 'OpenSans';

  static const TextStyle designSystemBaseTextStyle = TextStyle(
        color: AppColors.primary100,
    fontFamily: fontFamily,
    decoration: TextDecoration.none,
  );

  static const double display01FontSize = 80;
  static TextStyle display01 = TextStyles.designSystemBaseTextStyle.copyWith(
    fontWeight: FontWeights.medium,
    color: AppColors.primary100,
    fontSize: display01FontSize,
    height: display01FontSize / display01FontSize,
    letterSpacing: TextStyles.display01FontSize * -0.02,
  );

  static const double display02FontSize = 56;
  static TextStyle display02 = TextStyles.designSystemBaseTextStyle.copyWith(
    fontWeight: FontWeights.medium,
    color: AppColors.primary100,
    fontSize: display02FontSize,
    height: display02FontSize / display02FontSize,
    letterSpacing: TextStyles.display02FontSize * -0.02,
  );

  
  static const double heading01FontSize = 36;
  static const double heading01LineHeight = 40;
  static TextStyle heading01 = TextStyles.designSystemBaseTextStyle.copyWith(
    fontWeight: FontWeights.medium,
    color: AppColors.primary100,
    fontSize: heading01FontSize,
    height: heading01LineHeight / heading01FontSize,
    letterSpacing: TextStyles.heading01FontSize * -0.02,
  );

  static const double heading02FontSize = 28;
  static TextStyle heading02 = TextStyles.designSystemBaseTextStyle.copyWith(
    fontWeight: FontWeights.medium,
    color: AppColors.primary100,
    fontSize: heading02FontSize,
    height: 36 / heading02FontSize,
    letterSpacing: TextStyles.heading02FontSize * -0.02,
  );

  static const double heading03FontSize = 16;
  static TextStyle heading03 = TextStyles.designSystemBaseTextStyle.copyWith(
    fontWeight: FontWeights.medium,
    color: AppColors.primary100,
    fontSize: heading03FontSize,
    height: 24 / heading03FontSize,
  );

  static const double subheading01FontSize = 14;
  static TextStyle subheading01 = TextStyles.designSystemBaseTextStyle.copyWith(
    fontWeight: FontWeights.semiBold,
    color: AppColors.primary100,
    fontSize: subheading01FontSize,
    height: 20 / subheading01FontSize,
  );

  static const double subheading02FontSize = 12;
  static TextStyle subheading02 = TextStyles.designSystemBaseTextStyle.copyWith(
    fontWeight: FontWeights.medium,
    color: AppColors.primary100,
    fontSize: subheading02FontSize,
    height: 16 / subheading02FontSize,
  );

  static const double body01FontSize = 14;
  static const double body01LineHeight = 20;
  static TextStyle body01 = TextStyles.designSystemBaseTextStyle.copyWith(
    fontWeight: FontWeights.normal,
    color: AppColors.primary100,
    fontSize: body01FontSize,
    height: 20 / body01FontSize,
    letterSpacing: TextStyles.body01FontSize * 0.01,
  );

  static const double body02FontSize = 12;
  static TextStyle body02 = TextStyles.designSystemBaseTextStyle.copyWith(
    fontWeight: FontWeights.normal,
    color: AppColors.primary100,
    fontSize: body02FontSize,
    height: 16 / body02FontSize,
    letterSpacing: TextStyles.body02FontSize * 0.01,
  );

  static const double caption01FontSize = 12;
  static TextStyle caption01 = TextStyles.designSystemBaseTextStyle.copyWith(
    fontWeight: FontWeights.medium,
    color: AppColors.primary100,
    fontSize: caption01FontSize,
    height: 16 / caption01FontSize,
  );

  static final underlinedTextButtonTextStyle =
      TextStyles.designSystemBaseTextStyle.copyWith(
    fontWeight: FontWeight.w500,
    height: 24 / 14,
    decoration: TextDecoration.underline,
  );
}
