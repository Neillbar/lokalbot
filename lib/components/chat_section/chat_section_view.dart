import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lokalbot/components/chat_bubble.dart';
import 'package:lokalbot/models/multi_component_model.dart';

class ChatSectionview extends StatefulWidget {
  Stream<ChatSectionModel> chatStream;
  Stream<bool> clearChat;
  ChatSectionview({Key? key, required this.chatStream, required this.clearChat})
      : super(key: key);

  @override
  State<ChatSectionview> createState() => _ChatSectionviewState();
}

class _ChatSectionviewState extends State<ChatSectionview> {
  StreamSubscription? chatStreamSubscription;
  StreamSubscription? clearChatStreamSubscription;
  List<ChatSectionModel> chats = [];
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    chatStreamSubscription = widget.chatStream.listen((ChatSectionModel event) {
      addToChats(event);
    });
    clearChatStreamSubscription = widget.clearChat.listen((bool event) {
      if (event) {
        clearChats();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    disposeListeners();
  }

  void disposeListeners() {
    chatStreamSubscription?.cancel();
    clearChatStreamSubscription?.cancel();
  }

  void addToChats(ChatSectionModel event) {
    setState(() {
      chats.add(event);
    });
  }

  void clearChats() {
    setState(() {
      chats.clear();
    });
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 50), () {
      if (controller.position.maxScrollExtent > 0) {
        controller.animateTo(controller.position.maxScrollExtent,
            duration: const Duration(milliseconds: 50), curve: Curves.easeIn);
      }
    });
  }

  @override
  void didUpdateWidget(covariant ChatSectionview oldWidget) {
    super.didUpdateWidget(oldWidget);
    scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 50),
        controller: controller,
        shrinkWrap: true,
        itemBuilder: (context, index) => chats[index].isbotTexting
            ? ChatBubble(
                text: chats[index].text,
              )
            : ChatBubble(
                text: chats[index].text,
                bubbleOnLeft: false,
              ),
        separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
        itemCount: chats.length);
  }
}
