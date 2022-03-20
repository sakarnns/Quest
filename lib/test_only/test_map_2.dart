import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample2 extends StatefulWidget {
  MapSample2({Key? key}) : super(key: key);

  @override
  State<MapSample2> createState() => _MapSample2State();
}

class _MapSample2State extends State<MapSample2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          TextButton(
            onPressed: () {},
            child: const Text(
              'Done',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
          ),
        ],
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
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                    10,
                    10,
                  ),
                  zoom: 5),
            ),
          ),
          Positioned(
              top: -20,
              left: 20,
              right: 20,
              child: Container(
                height: 100,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/logo_quest.svg',
                      height: 50,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child: LocationSearchBox()),
                  ],
                ),
              )),
          // Positioned(
          //     bottom: 25,
          //     left: 20,
          //     right: 20,
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 70.0),
          //       child: ElevatedButton(
          //         style: ElevatedButton.styleFrom(
          //             primary: Theme.of(context).primaryColor),
          //         child: Text('Save'),
          //         onPressed: () {},
          //       ),
          //     ))
        ],
      ),
    );
  }
}

class LocationSearchBox extends StatelessWidget {
  const LocationSearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (val) {
          print("Go button is clicked");
          print(val);
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Enter your Location...',
          prefixIcon: Icon(Icons.search),
          // suffixIcon: Icon(Icons.search),
          contentPadding: const EdgeInsets.only(left: 10, bottom: 5, right: 5),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
