import 'package:flutter/material.dart';
import 'package:shopifind/common/text/text_style.dart';

class SimpleButton extends StatelessWidget {
  const SimpleButton({
    Key? key,
    required this.text,
    this.onTap,
    this.color,
    this.style,
  }) : super(key: key);

  final String text;
  final Color? color;
  final TextStyle? style;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            color: color ?? Colors.transparent,
            width: 2,
          ),
        ),
        child: Text(
          text,
          style: style ?? TextStyles.caption01,
        ),
      ),
    );
  }
}
