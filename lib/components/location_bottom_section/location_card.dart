import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';

class LocationCard extends StatelessWidget {
  AutocompletePrediction? address;
  Function(AutocompletePrediction) locationSelected;
  LocationCard({Key? key, this.address, required this.locationSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        if(address == null) return;
        locationSelected(address!);
        Navigator.pop(context);
      },
      child: Container(
        decoration: const BoxDecoration(
            color: Color.fromRGBO(245, 245, 245, 1),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            const SizedBox(
              width: 5,
            ),
            const Icon(
              Icons.location_pin,
              color: Colors.black,
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 
                  Text(
                    address?.description ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Color.fromRGBO(117, 117, 117, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    );
  }
}
