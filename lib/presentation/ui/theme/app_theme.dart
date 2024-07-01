import 'package:flutter/material.dart';
import 'package:ws_cars/presentation/ui/theme/text_theme.dart';

class AppTheme {
  static ThemeData appTheme() {
    final ColorScheme colorScheme =
        ColorScheme.fromSeed(seedColor: Colors.blueAccent);

    final ThemeData base = ThemeData.light();
    return base.copyWith(
      appBarTheme: AppBarTheme(color: Colors.grey.shade50),
      popupMenuTheme: PopupMenuThemeData(color: Colors.grey.shade50),
      scaffoldBackgroundColor: Colors.grey.shade50,
      textTheme: textTheme(base.textTheme),
      primaryColor: Colors.blueAccent,
      dividerColor: Colors.black.withOpacity(0.8),
      cardColor: Colors.white,
      colorScheme: colorScheme
          .copyWith(background: Colors.white)
          .copyWith(error: Colors.redAccent),
    );
  }
}
