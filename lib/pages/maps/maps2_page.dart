import 'package:custom_info_window/custom_info_window.dart';
import 'package:firebaseconn2g15/pages/maps/utils/home_controller.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GoogleMap(
        onMapCreated: (controller) async {
          _mapController.onMapCreated(controller);
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(-12.063808950914853, -77.07579660655514),
          zoom: 18,
        ),
      ),
    );
  }
}
