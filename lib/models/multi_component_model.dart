import 'dart:io';

enum MultiComponentType {
  general,
  file,
  options,
  location,
  multiSelection,
  none
}

class FileResponse {
  List<File>? files;
  int amountOfFiles;

  FileResponse({this.amountOfFiles = 0, this.files});
}

class LocationResponse {
  String? address;
  String? area;
  String country;
  String? postalCode;

  LocationResponse(
      {this.address, this.area, this.postalCode, this.country = 'za'});
}

class ChatSectionModel {
  bool isbotTexting;
  String text;
  MultiComponentType type;
  Function(dynamic) submitted;
  ChatSectionModel(
      {this.isbotTexting = true,
      required this.text,
      required this.submitted,
      this.type = MultiComponentType.general});
}

class LokalBotActions {
  Function()? clearchat;
  ChatSectionModel? chat;
  LokalBotActions({this.chat, this.clearchat});
}
