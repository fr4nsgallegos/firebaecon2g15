import 'package:custom_info_window/custom_info_window.dart';
import 'package:firebaseconn2g15/pages/maps/utils/home_controller.dart';
import 'package:firebaseconn2g15/pages/maps/utils/place_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps2Page extends StatefulWidget {
  const Maps2Page({super.key});

  @override
  State<Maps2Page> createState() => _Maps2PageState();
}

class _Maps2PageState extends State<Maps2Page> {
  Set<Marker> markers = {};
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  final _mapController = HomeController();

  Future<void> loadPlaces() async {
    Set<Marker> auxMarkers = {};
    BitmapDescriptor _iconMarker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(48, 48)),
      "assets/markers/green.png",
    );
    // places.forEach((place) {
    //   auxMarkers.add(
    //     Marker(
    //       markerId: MarkerId(place.id.toString()),
    //       position: place.position,
    //       icon: _iconMarker,
    //       infoWindow: InfoWindow(title: place.name, snippet: place.services),
    //     ),
    //   );
    // });

    places.forEach((place) {
      auxMarkers.add(
        Marker(
          markerId: MarkerId(place.id.toString()),
          position: place.position,
          icon: _iconMarker,
          onTap: () {
            _customInfoWindowController.addInfoWindow!(
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(color: Colors.red),
              ),
              place.position,
            );
          },
        ),
      );
    });

    markers = auxMarkers;
    setState(() {});
  }

  @override
  void initState() {
    loadPlaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) async {
              _mapController.onMapCreated(controller);
              _customInfoWindowController.googleMapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(-12.063808950914853, -77.07579660655514),
              zoom: 16,
            ),
            onTap: (LatLng position) {
              _customInfoWindowController.hideInfoWindow!();
            },
            markers: markers,
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 250,
            width: 250,
            offset: 50,
          ),
        ],
      ),
    );
  }
}
