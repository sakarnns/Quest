import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quest_2/styles/input_border.dart';
import 'package:quest_2/styles/size.dart';
import 'dart:async';
import 'location_map_service.dart';

class ActivityLocationMapPage extends StatefulWidget {
  ActivityLocationMapPage({Key? key}) : super(key: key);

  @override
  State<ActivityLocationMapPage> createState() =>
      _ActivityLocationMapPageState();
}

bool gotlocation = false;
String eventlocation = "";
double? latitude;
double? longitude;

class _ActivityLocationMapPageState extends State<ActivityLocationMapPage> {
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController _searchController = TextEditingController();

  Set<Marker> _markers = Set<Marker>();
  Set<Polygon> _polygons = Set<Polygon>();
  List<LatLng> polygonLatLangs = <LatLng>[];

  @override
  void initState() {
    super.initState();
    gotlocation = false;
    latitude != null && longitude != null
        ? _setMarker(
            LatLng(latitude!, longitude!),
          )
        : null;
  }

  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('marker'),
        position: point,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Location',
          style: TextStyle(
            fontSize: 32.0,
            color: Color(0xFF6F2DA8),
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: BackButton(
          color: Color(0xFF6F2DA8),
          onPressed: () {
            setState(() {});
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: gotlocation == true
                  ? () {
                      Navigator.pop(context);
                    }
                  : null,
              child: gotlocation == true
                  ? Text(
                      "Done",
                      style: TextStyle(
                          color: Color(0xFF007AFF),
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    )
                  : Text(
                      "Done",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width(context: context) / 50,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _searchController,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.search,
                    onFieldSubmitted: (val) async {
                      var place = await LocationService()
                          .getPlace(_searchController.text);
                      _goToPlace(place);

                      print(val);
                    },
                    decoration: InputDecoration(
                      focusedBorder: outlineInputBorder(),
                      border: outlineInputBorder(),
                      contentPadding: EdgeInsets.all(8.0),
                      hintText: 'Enter your Location...',
                      prefixIcon: Icon(Icons.search, color: Color(0xFF6F2DA8)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.clear,
                        ),
                        onPressed: () {
                          _searchController.clear();
                        },
                      ),
                    ),
                    onChanged: (val) {
                      eventlocation = val;
                      print("araiwa " + eventlocation);
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height(context: context) / 100,
          ),
          Expanded(
            child: GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapToolbarEnabled: true,
              tiltGesturesEnabled: true,
              buildingsEnabled: true,
              mapType: MapType.normal,
              markers: _markers,
              polygons: _polygons,
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                    13.736717,
                    100.523186,
                  ),
                  zoom: 15),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 16),
      ),
    );

    _setMarker(
      LatLng(lat, lng),
    );
    gotlocation = true;
    latitude = lat;
    longitude = lng;
  }
}
