import 'package:flutter/material.dart';
import 'package:lokalbot/components/location_bottom_section/find_location_view.dart';
import 'package:lokalbot/models/multi_component_model.dart';
import 'package:lokalbot/shared/lokal_colors.dart';
import 'package:lokalbot/shared/lokal_variables.dart';

class LocationbottomSectionComponent extends StatefulWidget {
  Function(LocationObject) locationSelected;

  LocationbottomSectionComponent({Key? key, required this.locationSelected})
      : super(key: key);

  @override
  State<LocationbottomSectionComponent> createState() =>
      _LocationbottomSectionComponentState();
}

class _LocationbottomSectionComponentState
    extends State<LocationbottomSectionComponent> {
  LocationObject? location;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: LokalVariables.screenWidth(context),
      // height: LokalVariables.screenHeight(context) * 0.35,
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
      child: Column(
        children: [
          if (location == null)
            SizedBox(
              height: 100,
              width: LokalVariables.screenWidth(context),
            ),
          if (location != null)
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              width: LokalVariables.screenWidth(context) * 0.85,
              height: 100,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: const Icon(
                      Icons.location_pin,
                      color: Colors.green,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    height: 80,
                    width: 2,
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 10, right: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Selected Location",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            location?.formattedAddress ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(135, 135, 135, 1)),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 5, right: 5),
                height: LokalVariables.screenHeight(context) * 0.08,
                width: LokalVariables.screenWidth(context) * 0.5,
                child: TextButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side:
                                  const BorderSide(color: Colors.transparent))),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[350])),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FindLocationView(
                            locationSelected: (LocationObject location) {
                              setState(() {
                                this.location = location;
                              });
                            },
                          ),
                        ));
                  },
                  child: FittedBox(
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              color: LokalColors.primaryColor,
                              shape: BoxShape.circle),
                          child: const Icon(
                            Icons.my_location,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          location == null ? 'Add location' : 'Change location',
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (location != null)
                SizedBox(
                  height: LokalVariables.screenHeight(context) * 0.08,
                  width: LokalVariables.screenWidth(context) * 0.3,
                  child: TextButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: const BorderSide(
                                        color: Colors.transparent))),
                        backgroundColor: MaterialStateProperty.all(
                            LokalColors.primaryColor)),
                    onPressed: () {
                      if (location == null) return;
                      widget.locationSelected(location!);
                    },
                    child: const Text(
                      'Done',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
