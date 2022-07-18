import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/common/constants/app_colors.dart';
import 'package:shopifind/common/constants/display_properties.dart';
import 'package:shopifind/common/text/text_style.dart';

class EditorTextInput extends ConsumerStatefulWidget {
  const EditorTextInput({
    Key? key,
    required this.width,
    required this.height,
    required this.onChange,
    required this.initialValue,
    this.labelText,
  }) : super(key: key);

  final double width;
  final double height;
  final String initialValue;
  final Function(String) onChange;
  final String? labelText;

  @override
  ConsumerState<EditorTextInput> createState() => _EditorTextInputState();
}

class _EditorTextInputState extends ConsumerState<EditorTextInput> {
  final FocusNode _focus = FocusNode();
  late TextEditingController _controller;

  @override
  void initState() {
    print(
        '======= EditorTextInput initState initialValue: ${widget.initialValue} | key: ${widget.key.toString()}');
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print(
        '======= EditorTextInput didChangeDependencies initialValue: ${widget.initialValue} | key: ${widget.key.toString()}');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant EditorTextInput oldWidget) {
    print(
        '======= EditorTextInput didUpdateWidget initialValue: ${widget.initialValue} | key: ${widget.key.toString()}');
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
        style: TextStyles.body01.copyWith(color: AppColors.primary100),
        cursorColor: AppColors.primary100,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelStyle:
              TextStyles.caption01.copyWith(color: AppColors.primary100),
          border: DisplayProperties.focusedBorder,
          enabledBorder:  DisplayProperties.focusedBorder,
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
