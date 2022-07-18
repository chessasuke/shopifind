import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ToggleBrightness extends ConsumerWidget {
  const ToggleBrightness({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: Icon(
        Theme.of(context).brightness == Brightness.dark
            ? FontAwesomeIcons.solidSun
            : FontAwesomeIcons.solidMoon,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      color: Colors.white,
      onPressed: () {
        ref.read(appThemeProvider).toggle();
      },
    );
  }
}
