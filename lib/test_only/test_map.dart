import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:quest_2/serviecs/location_map_service.dart';

//Page Map
class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  TextEditingController _searchController = TextEditingController();

  Set<Marker> _markers = Set<Marker>();
  Set<Polygon> _polygons = Set<Polygon>();
  List<LatLng> polygonLatLangs = <LatLng>[];

  // static final CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(13.736717, 100.523186),
  //   zoom: 14.4746,
  // );

  @override
  void initState() {
    super.initState();

    _setMarker(LatLng(13.736717, 100.523186));
  }

  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('marker'),
        position: point,
      ));
    });
  }

  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Locations',
            style: TextStyle(fontSize: 32.0, color: Colors.black)),
        backgroundColor: Color(0xFFEBEDF2),
        elevation: 0.0,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Row(
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
                    // focusedBorder: outlineInputBorder(),
                    // border: outlineInputBorder(),
                    // contentPadding: EdgeInsets.all(8.0),
                    hintText: 'Enter your Location...',
                    prefixIcon: Icon(Icons.search),
                    // suffixIcon: Icon(Icons.clear),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                      },
                    ),
                  ),
                  onChanged: (val) {
                    print(val);
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              markers: _markers,
              polygons: _polygons,
              // initialCameraPosition: _kGooglePlex,
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
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: Text('To the lake!'),
      //   icon: Icon(Icons.directions_boat),
      // ),
    );
  }

  Future<void> _goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(lat, lng), zoom: 16),
    ));

    _setMarker(LatLng(lat, lng));

    print(lat);
    print(lng);
  }
}
