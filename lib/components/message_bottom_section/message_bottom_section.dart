import 'package:flutter/material.dart';
import 'package:lokalbot/shared/lokal_colors.dart';
import 'package:lokalbot/shared/lokal_variables.dart';

class MessageBottomSection extends StatefulWidget {
  TextInputType inputType;
  Function(String) sentPressed;
  MessageBottomSection(
      {Key? key,
      this.inputType = TextInputType.name,
      required this.sentPressed})
      : super(key: key);

  @override
  State<MessageBottomSection> createState() => _MessageBottomSectionState();
}

class _MessageBottomSectionState extends State<MessageBottomSection> {
  FocusNode node = FocusNode();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        textWidget(widget.sentPressed),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget textWidget(Function(String) sentPressed) {
    return SizedBox(
      width: LokalVariables.screenWidth(context) * 0.95,
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: TextField(
            autofocus: false,
            maxLines: 5,
            minLines: 1,
            keyboardType: widget.inputType,
            controller: controller,
            onChanged: (text) {
              setState(() {});
            },
            focusNode: node,
            decoration: InputDecoration(
                filled: true,
                suffixIcon: Container(
                  width: 80,
                  margin: const EdgeInsets.only(right: 5, top: 5, bottom: 5),
                  child: TextButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          color: Colors.transparent))),
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          backgroundColor: MaterialStateProperty.all(
                              controller.text.isNotEmpty
                                  ? LokalColors.primaryColor
                                  : Colors.grey)),
                      onPressed: () {
                        if (controller.text.isEmpty) return;
                        node.unfocus();
                        sentPressed(controller.text);
                        controller.text = '';
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(2),
                        child: Text(
                          'SEND',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      )),
                ),
                fillColor: const Color.fromRGBO(238, 238, 238, 1),
                enabledBorder: border,
                focusedBorder: border,
                border: border),
          )),
        ],
      ),
    );
  }

  OutlineInputBorder border = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(width: 0, color: Colors.transparent));
}

// node.unfocus();
//               sentPressed(controller.text);
//               controller.text = '';