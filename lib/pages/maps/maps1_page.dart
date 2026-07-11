import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps1Page extends StatefulWidget {
  @override
  State<Maps1Page> createState() => _Maps1PageState();
}

class _Maps1PageState extends State<Maps1Page> {
  Set<Marker> markers = {
    Marker(
      markerId: MarkerId("plaza"),
      position: LatLng(-12.059139185406039, -77.03708952564206),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(-12.059139185406039, -77.03708952564206),
          zoom: 15,
        ),
        onTap: (LatLng lugar) {
          print(lugar);
          Marker newMarker = Marker(
            markerId: MarkerId(markers.length.toString()),
            position: lugar,
          );

          markers.add(newMarker);
          setState(() {});
        },
        markers: markers,
      ),
    );
  }
}
