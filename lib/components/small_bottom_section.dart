import 'package:flutter/material.dart';
import 'package:lokalbot/shared/lokal_colors.dart';
import 'package:lokalbot/shared/lokal_variables.dart';

class SmallbottomSection extends StatelessWidget {
  Widget child;
  SmallbottomSection({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: LokalVariables.screenWidth(context),
        height: LokalVariables.screenHeight(context) * 0.15,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.white.withOpacity(1),
          Colors.white.withOpacity(0.8),
          Colors.white.withOpacity(0.7),
          Colors.white.withOpacity(0.6),
          Colors.white.withOpacity(0.4),
          Colors.white.withOpacity(0.2),
          Colors.white.withOpacity(1),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        alignment: Alignment.center,
        child: child);
  }
}
