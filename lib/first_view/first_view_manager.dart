import 'package:flutter/cupertino.dart';
import 'package:real_time_chat_app/chat_view/chat_view.dart';

mixin class FirstViewManager {
  final TextEditingController nameController = TextEditingController();

  navigateToChatView(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => ChatView(name: nameController.text),
      ),
    );
  }
}
