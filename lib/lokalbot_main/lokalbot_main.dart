import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lokalbot/components/chat_section/chat_section_view.dart';
import 'package:lokalbot/components/location_bottom_section/location_bottom_section_component.dart';
import 'package:lokalbot/components/lokal_header/lokal_header.dart';
import 'package:lokalbot/components/message_bottom_section/message_bottom_section.dart';
import 'package:lokalbot/components/multiple_selection_section/multiple_selection_component.dart';
import 'package:lokalbot/components/selections_bottom_section/selections_bottom_section.dart';
import 'package:lokalbot/models/multi_component_model.dart';
import 'package:lokalbot/shared/lokal_variables.dart';

import '../components/photo_bottom_section/photo_bottom_section.dart';
import 'lokalbot_main_viewmodel.dart';

class LokalBotMain extends StatefulWidget {
  LokalbotMainViewModel viewModel;
  LokalBotMain({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<LokalBotMain> createState() => _LokalBotMainState();
}

class _LokalBotMainState extends State<LokalBotMain> {
  StreamController<LokalBotActions>? botActions =
      StreamController<LokalBotActions>.broadcast();
  StreamController<ChatSectionModel> chatStreamController =
      StreamController<ChatSectionModel>.broadcast();
  StreamController<bool> clearChatStreamController =
      StreamController<bool>.broadcast();
  StreamSubscription? _nextComponentSubscription;
  MultiComponentType _nextComponent = MultiComponentType.none;
  Function<T>(T)? finished;
  ChatSectionModel? chatSectionModel;
  bool emptyWidget = false;

  @override
  void initState() {
    super.initState();
    widget.viewModel.botActions = botActions;
    listenToNextComponent();
    print("Whatsupp222");
  }

  void listenToNextComponent() {
    _nextComponentSubscription =
        botActions?.stream.listen((LokalBotActions event) {
      if (event.chat != null) {
        chatSectionModel = event.chat;
        if (event.chat?.type != _nextComponent) {
          emptyWidget = true;
          _nextComponent = event.chat!.type;
        }
        if (event.chat?.submitted != null) {
          finished = <T>(value) => {event.chat!.submitted!(value)};
        }
        addToChat(event.chat!);
      }
      if (event.clearchat != null) {
        clearChat();
      }

      setState(() {});
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          emptyWidget = false;
        });
      });
    });
  }

  void clearChat() {
    clearChatStreamController.add(true);
  }

  void addToChat(ChatSectionModel chatFunction) {
    chatStreamController.add(chatFunction);
  }

  void addSentTextToChat(String value, {bool? isBotTexting}) {
    chatStreamController.add(ChatSectionModel(
        text: value,
        isbotTexting: isBotTexting ?? false,
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
              if (_nextComponent == MultiComponentType.multiSelection &&
                  !emptyWidget)
                Expanded(
                  child: MultipleSelectionComponent(
                    selectedItems: (List<MultiSelectModel> selectedItems) {
                      finished!(selectedItems);
                      String allItems = selectedItems
                          .map((MultiSelectModel e) => e.title)
                          .toList()
                          .join(", ");
                      addSentTextToChat(allItems);
                    },
                    options: chatSectionModel?.multiSelectoptions ?? [],
                  ),
                ),
              if (_nextComponent == MultiComponentType.options && !emptyWidget)
                SelectionsBottomSection(
                  optionSelected: (OptionsModel option) {
                    finished!(option);
                    addSentTextToChat(option.title);
                  },
                  options: chatSectionModel?.options ?? [],
                ),
              if (_nextComponent == MultiComponentType.general && !emptyWidget)
                MessageBottomSection(
                  sentPressed: (String value) {
                    finished!(value);
                    addSentTextToChat(value);
                  },
                ),
              if (_nextComponent == MultiComponentType.location)
                LocationbottomSectionComponent(
                  locationSelected: (LocationObject location) {
                    finished!(location);
                    addSentTextToChat(location.formattedAddress ?? '');
                  },
                ),
              if (_nextComponent == MultiComponentType.file)
                PhotoBottomSection(
                  maxPhotos: 10,
                  submitImages: (List<File> images) {
                    finished!(images);
                    addSentTextToChat(
                        '${images.length} ${images.length > 1 ? "Images" : "Image"} uploaded, thanks!',
                        isBotTexting: true);
                  },
                )
            ],
          )),
    );
  }
}
