import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/common/constants/app_colors.dart';
import 'package:shopifind/common/text/text_style.dart';

class EditorTextInput extends ConsumerStatefulWidget {
  const EditorTextInput({
    Key? key,
    required this.width,
    required this.height,
    required this.onChange,
    required this.initialValue,
  }) : super(key: key);

  final double width;
  final double height;
  final String initialValue;
  final Function(String) onChange;

  @override
  ConsumerState<EditorTextInput> createState() => _EditorTextInputState();
}

class _EditorTextInputState extends ConsumerState<EditorTextInput> {
  final FocusNode _focus = FocusNode();
  late TextEditingController _controller;

  @override
  void initState() {
    print(
        '======= EditorTextInput initState ${widget.initialValue} | key: ${widget.key.toString()}');
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print(
        '======= EditorTextInput didChangeDependencies ${widget.initialValue} | key: ${widget.key.toString()}');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant EditorTextInput oldWidget) {
    print(
        '======= EditorTextInput didUpdateWidget ${widget.initialValue} | key: ${widget.key.toString()}');
    _controller.text = widget.initialValue;
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: _controller.text.length),
    );
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary100),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      width: widget.width,
      height: widget.height,
      child: TextField(
        style: TextStyles.body01.copyWith(height: 0),
        cursorColor: AppColors.primary100,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: -12),
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
