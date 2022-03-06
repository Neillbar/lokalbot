import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:lokalbot/components/location_bottom_section/find_location_viewmodel.dart';
import 'package:lokalbot/components/location_bottom_section/location_card.dart';
import 'package:lokalbot/models/multi_component_model.dart';
import 'package:lokalbot/shared/lokal_colors.dart';
import 'package:lokalbot/shared/lokal_variables.dart';

class FindLocationView extends StatefulWidget {
  Function(LocationObject) locationSelected;

  FindLocationView({Key? key, required this.locationSelected})
      : super(key: key);

  @override
  State<FindLocationView> createState() => _FindLocationViewState();
}

class _FindLocationViewState extends State<FindLocationView> {
  final _findLocationViewModel = FindLocationViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: LokalVariables.screenHeight(context) * 0.1,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 50,
                height: 50,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 30,
                  ),
                ),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(239, 239, 239, 1)),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  child: TextField(
                onChanged: (String text) {
                  _findLocationViewModel.runSearchResult(text, () {
                    setState(() {});
                  });
                },
                style: const TextStyle(color: Colors.white, fontSize: 12),
                decoration: InputDecoration(
                    hintText: "Type in your search here",
                    hintStyle:
                        const TextStyle(color: Colors.white, fontSize: 12),
                    fillColor: LokalColors.botChatBubbleColor,
                    filled: true,
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                    suffixIcon: Container(
                      margin: const EdgeInsets.only(
                          right: 8, left: 5, top: 5, bottom: 5),
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          color: Colors.grey, shape: BoxShape.circle),
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    )),
              )),
              const SizedBox(
                width: 50,
              )
            ],
          ),
          Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => LocationCard(
                      address: _findLocationViewModel.searchResults[index],
                      locationSelected:
                          (AutocompletePrediction location) async {
                        await _findLocationViewModel.fetchLocationDetails(
                            placeId: location.placeId);
                        if (_findLocationViewModel.locationObject != null) {
                          widget.locationSelected(
                              _findLocationViewModel.locationObject!);
                        }
                      }),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: _findLocationViewModel.searchResults.length)),
          // SizedBox(
          //   width: LokalVariables.screenWidth(context),
          //   child: Column(
          //     children: [
          //       Container(
          //         alignment: Alignment.center,
          //         height: 1,
          //         color: Colors.grey,
          //         width: LokalVariables.screenWidth(context) * 0.8,
          //       ),
          //       Container(
          //         margin: const EdgeInsets.only(top: 20, bottom: 10),
          //         height: LokalVariables.screenHeight(context) * 0.08,
          //         alignment: Alignment.center,
          //         child: TextButton(
          //           style: ButtonStyle(
          //               elevation: MaterialStateProperty.all(0),
          //               shape:
          //                   MaterialStateProperty.all<RoundedRectangleBorder>(
          //                       RoundedRectangleBorder(
          //                           borderRadius: BorderRadius.circular(18.0),
          //                           side: const BorderSide(
          //                               color: Colors.transparent))),
          //               backgroundColor: MaterialStateProperty.all(
          //                   LokalColors.primaryColor)),
          //           onPressed: () {},
          //           child: Row(
          //             mainAxisSize: MainAxisSize.min,
          //             children: [
          //               Container(
          //                 width: 50,
          //                 height: 50,
          //                 decoration: const BoxDecoration(
          //                     color: Colors.white, shape: BoxShape.circle),
          //                 child: Icon(
          //                   Icons.my_location,
          //                   color: LokalColors.primaryColor,
          //                 ),
          //               ),
          //               const Padding(
          //                 padding: EdgeInsets.only(right: 10, left: 10),
          //                 child: Text(
          //                   'My current location',
          //                   style: TextStyle(color: Colors.white, fontSize: 16),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  InputBorder border = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)));
}
