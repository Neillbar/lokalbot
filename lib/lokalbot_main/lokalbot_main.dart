import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lokalbot/components/chat_section/chat_section_view.dart';
import 'package:lokalbot/components/lokal_header.dart';
import 'package:lokalbot/components/message_bottom_section/message_bottom_section.dart';
import 'package:lokalbot/models/multi_component_model.dart';
import 'package:lokalbot/shared/lokal_variables.dart';

class LokalBotMain extends StatefulWidget {
  Stream<LokalBotActions>? botActions;
  LokalBotMain({Key? key, required this.botActions}) : super(key: key);

  @override
  State<LokalBotMain> createState() => _LokalBotMainState();
}

class _LokalBotMainState extends State<LokalBotMain> {
  StreamController<ChatSectionModel> chatStreamController =
      StreamController<ChatSectionModel>.broadcast();
  StreamController<bool> clearChatStreamController =
      StreamController<bool>.broadcast();
  StreamSubscription? _nextComponentSubscription;
  MultiComponentType _nextComponent = MultiComponentType.none;
  Function<T>(T)? finished;

  @override
  void initState() {
    super.initState();
    listenToNextComponent();
  }

  void listenToNextComponent() {
    _nextComponentSubscription =
        widget.botActions?.listen((LokalBotActions event) {
      if (event.chat != null) {
        if (event.chat?.type != _nextComponent) {
          _nextComponent = event.chat!.type;
        }
        if (event.chat?.submitted != null) {
          finished = <T>(value) => {event.chat!.submitted!(value)};
        }
        addToChat(event.chat!);
      }
      if (event.clearchat != null) {
        clearChatStreamController.add(true);
      }

      setState(() {});
    });
  }

  void clearChat() {
    clearChatStreamController.add(true);
  }

  void addToChat(ChatSectionModel chatFunction) {
    chatStreamController.add(chatFunction);
  }

  void addSentTextToChat(String value) {
    chatStreamController.add(ChatSectionModel(
        text: value,
        isbotTexting: false,
        submitted: <String>(dynamic outputValue) {}));
  }

  @override
  void dispose() {
    super.dispose();
    chatStreamController.close();
    clearChatStreamController.close();
    _nextComponentSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          width: LokalVariables.screenWidth(context),
          height: LokalVariables.screenHeight(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LokalHeader(
                isLoading: true,
              ),
              Expanded(
                  child: ChatSectionview(
                chatStream: chatStreamController.stream,
                clearChat: clearChatStreamController.stream,
              )),
             if(_nextComponent == MultiComponentType.general) MessageBottomSection(
                sentPressed: (String value) {
                  finished!(value);
                  addSentTextToChat(value);
                },
              )
            ],
          )),
    );
  }
}
