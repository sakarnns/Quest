import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:quest_2/styles/size.dart';

class GetLocationPage extends StatefulWidget {
  GetLocationPage({Key? key}) : super(key: key);

  @override
  State<GetLocationPage> createState() => _GetLocationPageState();
}

class _GetLocationPageState extends State<GetLocationPage> {
  Position? _currentPosition;
  String? _currentAddress;
  bool isLoading = false;

  Future<Position> _getPosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    print(permission);
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.deniedForever) {
        return Future.error("Location not available");
      }
    } else {
      print("Location not available111");
    }
    return await Geolocator.getCurrentPosition();
  }

  void _getAddress(latitude, longitude) async {
    try {
      List<Placemark> placemark = await GeocodingPlatform.instance
          .placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemark[0];

      setState(() {
        _currentAddress = '${place.locality}, ${place.country}';
        _currentAddress = 'Latitude:$latitude, Longitude:$longitude';
        print("latitude: $latitude");
        print("longitude: $longitude");
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        behavior: HitTestBehavior.translucent,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Location Services',
                style: TextStyle(fontSize: 28, color: Colors.black)),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: BackButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width(context: context) / 20,
                  ),
                  child: isLoading
                      ? CupertinoActivityIndicator()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_currentAddress != null)
                              Text(
                                _currentAddress!,
                                style: TextStyle(fontSize: 25),
                              ),
                            SizedBox(
                              height: height(context: context) / 20,
                            ),
                            MaterialButton(
                              color: Colors.black,
                              disabledColor: Colors.grey,
                              minWidth: 163,
                              height: 40,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                _currentPosition = await _getPosition();
                                _getAddress(_currentPosition!.latitude,
                                    _currentPosition!.longitude);
                                setState(() {
                                  isLoading = false;
                                });
                              },
                              child: Text(
                                'Get Location',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ],
                        )),
            ),
          ),
        ));
  }
}
