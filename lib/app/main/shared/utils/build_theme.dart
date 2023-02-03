import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:chronometer/app/main/models/theme.dart';

class BuildTheme {
  /// Funtion that create CupertinoThemeData by brightness option
  static CupertinoThemeData getCupertinoTheme(Theme theme) =>
      theme == Theme.dart
          ? const CupertinoThemeData(brightness: Brightness.dark)
          : const CupertinoThemeData(
              brightness: Brightness.light,
              primaryColor: CupertinoColors.white,
            );

  /// Funtion that create ThemeData by brightness option
  static ThemeData getMaterialTheme(Theme theme) => theme == Theme.dart
      ? ThemeData(brightness: Brightness.dark)
      : ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white70,
        );

  /// Funtion that get IOS Icon Color by build context
  static CupertinoDynamicColor getIOSIconColor(BuildContext context) =>
      CupertinoTheme.of(context).brightness == Brightness.light
          ? CupertinoColors.systemGrey
          : CupertinoColors.systemBlue;
}
