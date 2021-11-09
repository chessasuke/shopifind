import 'package:shopifind/controller/objects_providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/object_widget.dart';

class CustomCanvas extends ConsumerWidget {
  const CustomCanvas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final objects = watch(objRepositoryProvider).state;

    return Stack(
      children: [
        for (var i = 0; i < objects.length; i++) ...[
          ObjectWidget(object: objects[i])
        ],
      ],
    );
  }
}
