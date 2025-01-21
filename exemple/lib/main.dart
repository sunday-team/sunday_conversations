import 'package:exemple/View/main_view.dart';
import 'package:exemple/platform_style.dart';
import 'package:flutter/material.dart';
import 'package:sunday_platform/sunday_platform.dart';

final ValueNotifier<Style> platformStyleNotifier = ValueNotifier(
  PlatformStyle.current,
);

void changePlatformStyle(Style newStyle) {
  platformStyleNotifier.value = newStyle;
}

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Style>(
      valueListenable: platformStyleNotifier,
      builder: (context, platformStyle, child) {
        return SundayApp(
          title: 'Sunday Convs',
          home: const MainView(),
          uiStyle: PlatformStyle.current,
        );
      },
    );
  }
}
