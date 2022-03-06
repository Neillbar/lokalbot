import 'package:google_place/google_place.dart';
import 'package:lokalbot/extensions/list_extensions.dart';
import 'package:lokalbot/models/multi_component_model.dart';

class FindLocationViewModel {
  var googlePlace = GooglePlace("AIzaSyDbdmHyVchBwF8xVMwylzze7_a1wzzPx2s");
  List<AutocompletePrediction> searchResults = [];
  LocationObject? locationObject;

  void runSearchResult(String text, Function resultAdded) async {
    if (text == '') return;
    searchResults.clear();
    googlePlace.autocomplete.get(text).then((AutocompleteResponse? value) {
      value?.predictions?.forEach((AutocompletePrediction e) {
        searchResults.add(e);
        resultAdded();
      });
    });
  }

  Future<void> fetchLocationDetails({String? placeId}) async {
    if (placeId == null) return;
    DetailsResponse? locationDetails = await googlePlace.details.get(placeId);
    locationObject = LocationObject(
        placeId: placeId,
        formattedAddress: locationDetails?.result?.formattedAddress,
        icon: locationDetails?.result?.icon,
        country: getValueFromKey(
            components: locationDetails?.result?.addressComponents,
            key: 'country'),
        postalCode: getValueFromKey(
            components: locationDetails?.result?.addressComponents,
            key: 'postal_code'),
        streetName: getValueFromKey(
            components: locationDetails?.result?.addressComponents,
            key: 'route'),
        area: CoordinatesModel(
            lat: locationDetails?.result?.geometry?.location?.lat,
            lng: locationDetails?.result?.geometry?.location?.lng));
  }

  String? getValueFromKey(
      {required List<AddressComponent>? components, required String key}) {
    if (components == null) return null;
    String? finalValue;
    components.firstWhereOrNull((element) {
      for (String item in element.types ?? []) {
        if (item == key) {
          finalValue = element.longName;
          return true;
        }
      }
      return false;
    });
    return finalValue;
  }
}
