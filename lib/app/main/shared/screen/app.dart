import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chronometer/app/main/shared/screen/main_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) =>
      (defaultTargetPlatform == TargetPlatform.iOS)
          ? const _IOSApp()
          : const _AndroidApp();
}

class _IOSApp extends StatelessWidget {
  const _IOSApp({super.key});

  @override
  Widget build(BuildContext context) => const CupertinoApp(
        debugShowCheckedModeBanner: false,
        theme: CupertinoThemeData(brightness: Brightness.dark),
        home: MainScreen(),
      );
}

class _AndroidApp extends StatelessWidget {
  const _AndroidApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chronometer',
        theme: ThemeData.dark(),
        home: const MainScreen(),
      );
}
