import 'package:exemple/platform_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:sunday_platform/sunday_platform.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  var conversations = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SundayScaffold(
        appBar: CupertinoSliverNavigationBar(largeTitle: Text("Messages")),
        style: PlatformStyle.current,
        child: Center(child: Text("Hello !")),
      ),
    );
  }
}
