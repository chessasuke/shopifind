import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/common/constants/app_colors.dart';
import 'package:shopifind/common/constants/display_properties.dart';
import 'package:shopifind/common/text/text_style.dart';

class BasicTextField extends ConsumerStatefulWidget {
  const BasicTextField({
    Key? key,
    required this.width,
    required this.onChange,
    required this.initialValue,
    this.labelText,
  }) : super(key: key);

  final double width;
  final String initialValue;
  final Function(String) onChange;
  final String? labelText;

  @override
  ConsumerState<BasicTextField> createState() => _EditorTextInputState();
}

class _EditorTextInputState extends ConsumerState<BasicTextField> {
  final FocusNode _focus = FocusNode();
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.initialValue);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant BasicTextField oldWidget) {
    _controller.text = widget.initialValue;
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: _controller.text.length),
    );
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextField(
        maxLines: 1,
      
        style: TextStyles.body01.copyWith(color: AppColors.primary100),
        cursorColor: AppColors.primary100,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          isDense: true,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelStyle:
              TextStyles.caption01.copyWith(color: AppColors.primary100),
          border: DisplayProperties.focusedBorder,
          enabledBorder: DisplayProperties.focusedBorder,
          focusedBorder: DisplayProperties.focusedBorder,
          labelStyle: TextStyles.body01.copyWith(color: AppColors.primary100),
          labelText: widget.labelText,
        ),
        focusNode: _focus,
        controller: _controller,
        onChanged: widget.onChange,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
