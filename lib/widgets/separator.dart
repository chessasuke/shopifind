import 'package:flutter/material.dart';
import 'package:shopifind/common/constants/app_colors.dart';

class Separator extends StatelessWidget {
  const Separator({
    this.length,
    this.isHorizontal = true,
    Key? key,
  }) : super(key: key);

  final bool isHorizontal;
  final double? length;

  @override
  Widget build(BuildContext context) {
    return isHorizontal
        ? Row(
            mainAxisSize: length == null ? MainAxisSize.min : MainAxisSize.max,
            children: [
              Container(
                color: AppColors.neutral300,
                height: 0.3,
                width: length,
              ),
            ],
          )
        : Column(
            mainAxisSize: length == null ? MainAxisSize.min : MainAxisSize.max,
            children: [
              Container(
                color: AppColors.neutral300,
                height: length,
                width: 0.3,
              ),
            ],
          );
  }
}
