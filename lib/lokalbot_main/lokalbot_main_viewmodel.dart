import 'dart:async';
import 'package:lokalbot/models/multi_component_model.dart';

class LokalbotMainViewModel {
  StreamController<ChatSectionModel> chatStreamController;
  StreamController<bool> clearChatStreamController;

  LokalbotMainViewModel(
      {required this.chatStreamController,
      required this.clearChatStreamController});
}
