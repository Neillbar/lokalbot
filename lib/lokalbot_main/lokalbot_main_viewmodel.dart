import 'dart:async';
import 'dart:io';
import 'package:lokalbot/models/multi_component_model.dart';

class LokalbotMainViewModel {
  StreamController<LokalBotActions>? botActions;

  void textResponse(
      {required String text, required Function(String) response}) {
    _addToBotActionStream(ChatSectionModel<String>(
        type: MultiComponentType.general,
        text: text,
        submitted: <String>(value) {
          response(value);
        }));
  }

  void textWithNoResponse({required String text}) {
    _addToBotActionStream(ChatSectionModel(
        type: MultiComponentType.none,
        text: text,
        submitted: (dynamic response) {}));
  }

  void optionResponse(
      {required String text,
      required List<OptionsModel> options,
      required Function(OptionsModel) response}) {
    _addToBotActionStream(ChatSectionModel<OptionsModel>(
        type: MultiComponentType.options,
        text: text,
        options: options,
        submitted: <OptionsModel>(value) {
          response(value);
        }));
  }

  void locationResponse(
      {required String text, required Function(LocationObject) response}) {
    _addToBotActionStream(ChatSectionModel<LocationObject>(
        type: MultiComponentType.location,
        text: text,
        submitted: <LocationObject>(value) {
          response(value);
        }));
  }

  void imagesResponse(
      {required String text,
      String? maxAmount,
      required Function(List<File>) response}) {
    _addToBotActionStream(ChatSectionModel<List<File>>(
        type: MultiComponentType.file,
        text: text,
        submitted: <List>(value) {
          response(value);
        }));
  }

  void multiSelectionResponse(
      {required String text,
      required List<MultiSelectModel> options,
      required Function(List<MultiSelectModel>) response}) {
    _addToBotActionStream(ChatSectionModel<List<MultiSelectModel>>(
        type: MultiComponentType.multiSelection,
        text: text,
        multiSelectoptions: options,
        submitted: <List>(value) {
          response(value);
        }));
  }

  void clearText() {
    botActions?.add(LokalBotActions(clearchat: () {}));
  }

  bool _makeSureClassIsInitialzed(Function functionCall) {
    if (botActions == null) {
      Future.delayed(const Duration(milliseconds: 100), () {
        functionCall();
      });
      return false;
    }
    return true;
  }

  void _addToBotActionStream(ChatSectionModel object) {
    bool classInitialized =
        _makeSureClassIsInitialzed(() => _addToBotActionStream(object));
    if (classInitialized) {
      botActions?.add(LokalBotActions(chat: object));
    }
  }
}
