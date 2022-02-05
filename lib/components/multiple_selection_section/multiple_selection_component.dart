import 'package:flutter/material.dart';
import 'package:lokalbot/components/lokal_header/lokal_logo_component.dart';
import 'package:lokalbot/components/modal_bottom_view.dart';
import 'package:lokalbot/lokalbot.dart';
import 'package:lokalbot/shared/lokal_colors.dart';
import 'package:lokalbot/shared/lokal_variables.dart';

class MultipleSelectionComponent extends StatefulWidget {
  List<MultiSelectModel> options;
  Function(List<MultiSelectModel>) selectedItems;
  MultipleSelectionComponent(
      {Key? key, required this.options, required this.selectedItems})
      : super(key: key);

  @override
  State<MultipleSelectionComponent> createState() =>
      _MultipleSelectionComponentState();
}

class _MultipleSelectionComponentState
    extends State<MultipleSelectionComponent> {
  @override
  Widget build(BuildContext context) {
    return ModalBottomView(
        child: Stack(
      children: [
        ListView.separated(
          padding: EdgeInsets.only(
              top: 10,
              bottom: listThatContainsACheckedItem() != null
                  ? LokalVariables.screenHeight(context) * 0.17
                  : 10),
          shrinkWrap: true,
          itemBuilder: (context, index) => MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              setState(() {
                widget.options[index].checked = !widget.options[index].checked;
              });
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6))),
                            fillColor: MaterialStateProperty.all(
                                LokalColors.primaryColor),
                            value: widget.options[index].checked,
                            onChanged: (bool? value) {
                              if (value != null) {
                                setState(() {
                                  widget.options[index].checked = value;
                                });
                              }
                            }),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.options[index].title,
                                style: TextStyle(
                                    color: LokalColors.primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              const Spacer(),
                              if (widget.options[index].description == null)
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
                          if (widget.options[index].description != null)
                            Text(
                              widget.options[index].description ?? '',
                              style: const TextStyle(
                                  color: Color.fromRGBO(93, 93, 93, 1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          itemCount: widget.options.length,
        ),
        if (listThatContainsACheckedItem() != null)
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
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
              child: SizedBox(
                height: LokalVariables.screenHeight(context) * 0.08,
                width: LokalVariables.screenWidth(context) * 0.4,
                child: TextButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side:
                                  const BorderSide(color: Colors.transparent))),
                      backgroundColor:
                          MaterialStateProperty.all(LokalColors.primaryColor)),
                  onPressed: () {
                    widget.selectedItems(listThatContainsACheckedItem() ?? []);
                  },
                  child: const Text(
                    'Done',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          )
      ],
    ));
  }

  List<MultiSelectModel>? listThatContainsACheckedItem() {
    Iterable<MultiSelectModel> list =
        widget.options.where((element) => element.checked == true).toList();
    if (list.isNotEmpty) {
      return list.toList();
    } else {
      return null;
    }
  }
}
