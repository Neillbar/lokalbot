import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lokalbot/components/lokal_header/lokal_logo_component.dart';
import 'package:lokalbot/components/modal_bottom_view.dart';
import 'package:lokalbot/models/multi_component_model.dart';
import 'package:lokalbot/shared/lokal_colors.dart';
import 'package:lokalbot/shared/lokal_variables.dart';

class SelectionsBottomSection extends StatelessWidget {
  List<OptionsModel> options;
  Function(OptionsModel) optionSelected;
  SelectionsBottomSection(
      {Key? key, required this.options, required this.optionSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ModalBottomView(
      child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) => MaterialButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  optionSelected(options[index]);
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromRGBO(238, 238, 238, 0.8),
                            Color.fromRGBO(238, 238, 238, 0.6),
                            Color.fromRGBO(238, 238, 238, 0.4),
                            Color.fromRGBO(238, 238, 238, 0.6),
                            Color.fromRGBO(238, 238, 238, 0.8),
                          ]),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              options[index].title,
                              style: TextStyle(
                                  color: LokalColors.primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                            const Spacer(),
                            if (options[index].description == null)
                              LokalLogoComponent(
                                logoSize: const Size(25, 25),
                                scaleFactor: 1.4,
                              ),
                            const SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        if (options[index].description != null)
                          Text(
                            options[index].description ?? '',
                            style: const TextStyle(
                                color: Color.fromRGBO(93, 93, 93, 1),
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          )
                      ],
                    ),
                  ),
                ),
              ),
          separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
          itemCount: options.length),
    );
  }
}
