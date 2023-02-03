import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:chronometer/app/main/shared/utils/build_theme.dart';

class CouterScreenWithGlobalState extends StatelessWidget {
  const CouterScreenWithGlobalState({super.key});
  final String title = 'Counter - Global State';

  @override
  Widget build(BuildContext context) =>
      defaultTargetPlatform == TargetPlatform.iOS
          ? _IOSCounterScreen(title: title)
          : _AndroidCounterScreen(title: title);
}

class CouterScreenWithLocalState extends StatelessWidget {
  final String title = 'Counter - Local State';

  @override
  Widget build(BuildContext context) =>
      defaultTargetPlatform == TargetPlatform.iOS
          ? _IOSCounterScreen(title: title)
          : _AndroidCounterScreen(title: title);
}

class _IOSCounterScreen extends StatelessWidget {
  _IOSCounterScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(title),
        leading: CupertinoButton(
          child: Icon(CupertinoIcons.back,
              size: 32, color: BuildTheme.getIOSIconColor(context)),
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      child: Container(
        child: const Text('Body', textAlign: TextAlign.center),
      ),
    );
  }
}

class _AndroidCounterScreen extends StatelessWidget {
  _AndroidCounterScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(child: const Text('Body', textAlign: TextAlign.center)));
  }
}
