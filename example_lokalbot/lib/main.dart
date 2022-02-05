import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lokalbot/lokalbot.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  StreamController<LokalBotActions> lokalBoActionsStreamController =
      StreamController<LokalBotActions>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            question1();
          },
        ),
        body: LokalBotMain(
          botActions: lokalBoActionsStreamController.stream,
        ),
      ),
    );
  }

  // #1 Question 1
  void question1() async {
    addTextForBot(
        'Hi Hi, My name is LokalBot, im here to guide yout through the process');
    addTextWithResponse(
        message:
            "Let's get started with your name and surname ? \n example: John Smith",
        type: MultiComponentType.general,
        response: <String>(value) {
          print("Thi si smy names: $value");
          addTextForBot('Hi $value welcome to lokalshop.');
        });
  }

  void addTextForBot(String message) {
    lokalBoActionsStreamController
        .add(LokalBotActions(chat: ChatSectionModel(text: message)));
  }

  void addTextWithResponse<T>(
      {required String message,
      required Function(T) response,
      MultiComponentType type = MultiComponentType.general}) {
    lokalBoActionsStreamController.add(LokalBotActions(
        chat: ChatSectionModel(
            type: type,
            text: message,
            submitted: <T>(value) {
              response(value);
            })));
  }
}
