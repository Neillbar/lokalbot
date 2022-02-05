import 'package:flutter/material.dart';
import 'package:lokalbot/shared/lokal_colors.dart';
import 'package:lokalbot/shared/lokal_variables.dart';

class ChatBubble extends StatelessWidget {
  String text;
  bool bubbleOnLeft;
  Color? bubbleColor;
  ChatBubble(
      {Key? key, this.text = '', this.bubbleOnLeft = true, this.bubbleColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          bubbleOnLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        IntrinsicWidth(
          child: Container(
            constraints: BoxConstraints(
                minWidth: 50,
                maxWidth: LokalVariables.screenWidth(context) * 0.9),
            margin: EdgeInsets.only(
                left: bubbleOnLeft ? 10 : 0, right: bubbleOnLeft ? 0 : 10),
            padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                color: bubbleColor ??
                    (bubbleOnLeft
                        ? LokalColors.botChatBubbleColor
                        : LokalColors.meChatBubbleColor)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text + '  ',
                textAlign: TextAlign.start,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
