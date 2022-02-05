import 'package:flutter/material.dart';
import 'package:lokalbot/components/lokal_header/lokal_logo_component.dart';
import 'package:lokalbot/shared/lokal_variables.dart';

class LokalHeader extends StatelessWidget {
  bool isLoading;
  LokalHeader({Key? key, this.isLoading = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: LokalVariables.screenHeight(context) * 0.1,
        ),
        Row(
          children: [
            const Spacer(),
            LokalLogoComponent(),
            SizedBox(
              width: LokalVariables.screenWidth(context) * 0.06,
            ),
            const Text(
              'LokalBot',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
            ),
            const Spacer(),
            Container(
                height: 40,
                alignment: Alignment.topLeft,
                width: LokalVariables.screenWidth(context) * 0.09,
                child: Text(
                  '...',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 30, color: Colors.grey[700]),
                )),
            SizedBox(
              width: LokalVariables.screenWidth(context) * 0.12,
            ),
          ],
        ),
        Container(
          width: LokalVariables.screenWidth(context),
          alignment: Alignment.center,
          child: const Text(
            'quick instant replies',
            style: TextStyle(
                fontSize: 14, color: Color.fromRGBO(197, 197, 197, 1)),
          ),
        )
      ],
    );
  }
}
