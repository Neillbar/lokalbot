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
            test();
          },
        ),
        body: LokalBotMain(
          botActions: lokalBoActionsStreamController.stream,
        ),
      ),
    );
  }

  void test() {
    lokalBoActionsStreamController.add(LokalBotActions(
        chat: ChatSectionModel(
      submitted: (dynamic text) {
        if (text != null) {
          String currentText = text;
          validateName(currentText);
        }
      },
      text: "Please give us your name",
      isbotTexting: true,
    )));
  }

  void validateName(String name) {
    if (name.characters.length < 5) {
      errorMessage((value) => {validateName(value)});
    } else {
      askSecondQuestion();
    }
  }

  void errorMessage(Function(String) tryAgain) {
    lokalBoActionsStreamController.add(LokalBotActions(
        chat: ChatSectionModel(
      submitted: (dynamic value) {
        print("This is my surname: $value");
        tryAgain(value);
      },
      text:
          "Oops unfortunately your name have to be longer than 4 characters, please try again.\n\n what is your name ?",
    )));
  }

  void askSecondQuestion() {
    lokalBoActionsStreamController.add(LokalBotActions(
        chat: ChatSectionModel(
      submitted: (dynamic value) {
        print("This is my surname: $value");
      },
      text: "What is your surname",
    )));
  }
}
