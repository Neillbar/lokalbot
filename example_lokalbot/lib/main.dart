import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lokalbot/lokalbot.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Properties
  String? fullName;
  List<MultiSelectModel> myFavFruit = [];
  OptionsModel? myOptions;
  StreamController<LokalBotActions> lokalBoActionsStreamController =
      StreamController<LokalBotActions>();

  // #1 Question 1
  void question1() async {
    addTextForBot(
        'Hi Hi, My name is LokalBot, im here to guide yout through the process');
    addTextWithResponse(
      message: "Let's start with your name and surname ?\nExample: Jhn Smith",
      response: (String response) {
        fullName = response;
        question2();
      },
      type: MultiComponentType.general,
    );
  }

  void question2() {
    addTextForBot("awesome ${fullName ?? ''}, thanks for signing up with us.");
    addTextWithResponse(
        message: 'Now, please choose your favourite fruit',
        type: MultiComponentType.multiSelection,
        multiSelectoptions: [
          MultiSelectModel(title: "Apple", id: "apple"),
          MultiSelectModel(title: "Banana", id: "banana"),
          MultiSelectModel(title: "Strawberry", id: "strawberry")
        ],
        response: (List<MultiSelectModel> selections) {
          myFavFruit = selections;
          question3();
        });
  }

  void question3() {
    addTextForBot(
        "aaaah we see you like couple of fruits, is ${myFavFruit[0].title} your fav?");
    addTextWithResponse(
        message:
            "Ignore that question 😂 😂 😂, Lets get down to business. When do you prefer to work ?",
        type: MultiComponentType.options,
        options: [
          OptionsModel(
              id: "morning",
              title: "Morning",
              description: "You are not so lekker in the head"),
          OptionsModel(
              id: "afternoon",
              title: "Afternoon",
              description: "You like to be lazy in the morning"),
          OptionsModel(
              id: "late_evenings",
              title: "Late Evenings",
              description: "You are my type of guy, us bots 🤖 never sleep"),
        ],
        response: (OptionsModel options) {
          myOptions = options;
          if (options.id == "morning") {
            addTextForBot("🖕 🖕 🖕");
          }
          if (options.id == "afternoon") {
            addTextForBot("${myOptions?.title ?? ''} are you a lazy bum ?  👌");
          }
          if (options.id == "late_evenings") {
            addTextForBot(
                "Yeah ${myOptions?.title ?? ''} is my fav time to work as well.... we are in sync 😎");
          }
        });
  }

  void addTextForBot(String message) {
    lokalBoActionsStreamController
        .add(LokalBotActions(chat: ChatSectionModel(text: message)));
  }

  void addTextWithResponse<T>(
      {required String message,
      required Function(T) response,
      List<MultiSelectModel>? multiSelectoptions,
      List<OptionsModel>? options,
      MultiComponentType type = MultiComponentType.general}) {
    lokalBoActionsStreamController.add(LokalBotActions(
        chat: ChatSectionModel(
            multiSelectoptions: multiSelectoptions,
            options: options,
            type: type,
            text: message,
            submitted: <T>(value) {
              response(value);
            })));
  }

  @override
  void initState() {
    super.initState();
    question1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     question1();
      //   },
      // ),
      body: LokalBotMain(
        botActions: lokalBoActionsStreamController.stream,
      ),
    );
  }
}


  // MultiSelectModel(
  //             title: "Products",
  //             id: "products",
  //             description:
  //                 "Description  for product 4 in detail. when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
  //         MultiSelectModel(
  //             title: "Event Tickets",
  //             id: "event_tickets",
  //             description:
  //                 "Description  for product 2 in detail. when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
  //         MultiSelectModel(
  //             title: "Digital Products",
  //             id: "digital_products",
  //             description:
  //                 "Description  for product 3 in detail. when an unknown printer took a galley of type and scrambled it to make a type specimen book.")



 