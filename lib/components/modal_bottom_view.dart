import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lokalbot/shared/lokal_variables.dart';

class ModalBottomView extends StatelessWidget {
  Widget child;
  double? maxHeight;
  ModalBottomView({Key? key, required this.child, this.maxHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          maxHeight: maxHeight ?? LokalVariables.screenHeight(context) * 0.5),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(238, 238, 238, 1),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
      ),
      child: CupertinoScrollbar(isAlwaysShown: true, child: child),
    );
  }
}
