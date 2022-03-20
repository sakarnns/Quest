import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class LocationService {
  final String key = 'AIzaSyAUXMIf_zqorDgIgMGkV-HchEm2dOLDXlw';

  //API-Google-Map Function//

  Future<String> getPlaceId(String input) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';

    // print(url);

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);

    // print(json);
    var placeId = json['candidates'][0]['place_id'] as String;

    print(placeId);

    return placeId;
  }

  Future<Map<String, dynamic>> getPlace(String input) async {
    final placeId = await getPlaceId(input);

    final String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';

    // print(url);

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results = json['result'] as Map<String, dynamic>;

    print(results);

    return results;
  }
}
