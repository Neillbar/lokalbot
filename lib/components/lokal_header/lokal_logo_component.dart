import 'package:flutter/material.dart';
import 'package:lokalbot/shared/lokal_colors.dart';

class LokalLogoComponent extends StatelessWidget {
  Size? logoSize;
  double? scaleFactor;
  LokalLogoComponent({Key? key, this.logoSize, this.scaleFactor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: logoSize?.height ?? 40,
      width: logoSize?.width ?? 40,
      child: Image.asset(
        'lib/assets/lokalbot_avatar.png',
        package: 'lokalbot',
        scale: scaleFactor ?? 0.8,
        fit: BoxFit.cover,
      ),
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: LokalColors.primaryColor),
    );
  }
}
