import 'package:exemple/View/message_view.dart';
import 'package:exemple/platform_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunday_platform/sunday_platform.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SundayBottomBar(
      items: [
        SundayNavigationBarItem(
          style: PlatformStyle.current,
          icon: Icon(CupertinoIcons.chat_bubble_2_fill),
          label: "Messages",
        ),
        SundayNavigationBarItem(
          style: PlatformStyle.current,
          icon: Icon(CupertinoIcons.gear),
          label: "Settings",
        ),
      ],
      currentIndex: currentIndex,
      onTap: (tappedIndex) {
        if (!mounted) return;
        setState(() {
          currentIndex = tappedIndex;
        });
      },
      style: PlatformStyle.current,
      tabBuilder: (context, index) {
        switch (currentIndex) {
          case 0:
            return MessageView();
          default:
            return MessageView();
        }
      },
    );
  }
}
