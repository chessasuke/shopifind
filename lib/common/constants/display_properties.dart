import 'package:flutter/material.dart';
import 'package:shopifind/common/constants/app_colors.dart';

class DisplayProperties {
  /// AppBar
  static const double kAppBarSize = 68;

  /// Deafult Main Content Padding
  static const double mainHorizontalPadding = 20.0;
  static const double mainBottomPadding = 48.0;
  static const double mainTopPadding = 24.0;

  /// Sidebar width
  static const double sidebarWidth = 175.0;

  static const double sidebarTitleHeight = 50.0;
  static const double sidebarObjectEditorHeight = 250.0;

  static final OutlineInputBorder focusedBorder = OutlineInputBorder(
    gapPadding: 1,
    borderSide: const BorderSide(color: AppColors.primary100),
    borderRadius: BorderRadius.circular(8),
  );
}
