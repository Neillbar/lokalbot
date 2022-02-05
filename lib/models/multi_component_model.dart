import 'dart:io';

enum MultiComponentType {
  general,
  file,
  options,
  location,
  multiSelection,
  none
}

// class FileResponse {
//   List<File>? files;
//   int amountOfFiles;

//   FileResponse({this.amountOfFiles = 0, this.files});
// }

// class LocationResponse {
//   String? address;
//   String? area;
//   String country;
//   String? postalCode;

//   LocationResponse(
//       {this.address, this.area, this.postalCode, this.country = 'za'});
// }

class ChatSectionModel<T> {
  /// when [MultiComponentType] is [MultiComponentType.options]
  /// you need to add multiple items for the user to select from
  /// /// You need to expext a [OptionsModel] in submitted function
  ///
  List<OptionsModel>? options;
  /// if [MultiComponentType] is set to [MultiComponentType.multiSelection]
  /// You need to use pass in multiSelectoptions for the user to select from
  /// You need to expext a List<[MultiSelectModel]> in submitted function
  List<MultiSelectModel>? multiSelectoptions;
  bool isbotTexting;
  String text;
  MultiComponentType type;
  Function(T)? submitted;
  ChatSectionModel(
      {this.isbotTexting = true,
      required this.text,
      this.submitted,
      this.options,
      this.multiSelectoptions,
      this.type = MultiComponentType.none});
}

class OptionsModel {
  String title;
  String? description;
  String? id;
  OptionsModel({this.description, required this.title, this.id});
}

class MultiSelectModel {
  String title;
  String? description;
  String? id;
  bool checked;
  MultiSelectModel({this.description, required this.title, this.id, this.checked = false});
}

class LokalBotActions {
  Function()? clearchat;
  ChatSectionModel? chat;
  LokalBotActions({this.chat, this.clearchat});
}
