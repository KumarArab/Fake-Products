import 'package:flutter/material.dart';
import 'package:flutter_project/packages/design/design_system/tokens/app_colors.dart';

class AppTypography {
  AppTypography._();

  static const String fontFamily = 'Roboto';

  static const TextStyle title = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.grey900,
    height: 1.3,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.grey700,
    height: 1.4,
  );

  static const TextStyle regular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.grey900,
    height: 1.5,
  );
}

