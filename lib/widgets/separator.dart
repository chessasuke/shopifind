import 'package:flutter/material.dart';
import 'package:shopifind/common/constants/app_colors.dart';

class Separator extends StatelessWidget {
  const Separator({
    required this.length,
    this.isHorizontal = true,
    Key? key,
  }) : super(key: key);

  final bool isHorizontal;
  final double length;

  @override
  Widget build(BuildContext context) {
    return isHorizontal
        ? Container(
            color: AppColors.neutral300,
            height: 0.3,
            width: length,
          )
        : Container(
            color: AppColors.neutral300,
            height: length,
            width: 0.3,
          );
  }
}
