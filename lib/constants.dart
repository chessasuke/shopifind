import 'package:flutter/material.dart';

const BoxDecoration kContainerDecoration =
    BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)));

class AppBtn extends StatelessWidget {
  const AppBtn({Key? key, required this.text, this.color}) : super(key: key);

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: color ?? Theme.of(context).colorScheme.surface,
            )),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: color ?? Theme.of(context).colorScheme.surface,
            ),
          ),
        ),
      ),
    );
  }
}
