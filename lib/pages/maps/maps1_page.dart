import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps1Page extends StatefulWidget {
  @override
  State<Maps1Page> createState() => _Maps1PageState();
}

class _Maps1PageState extends State<Maps1Page> {
  BitmapDescriptor? _customMarker;
  Position? currenPosition;
  Set<Marker> markers = {
    Marker(
      markerId: MarkerId("plaza"),
      position: LatLng(-12.059139185406039, -77.03708952564206),
    ),
  };

  Future<void> setCustomMarker() async {
    _customMarker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(48, 48)),
      "assets/markers/orange.png",
    );

    // markers.add(Marker(markerId: MarkerId(markers.length.toString()),position:
    // LatLng(latitude, longitude)));
  }

  Future<void> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("servicio de geolocalización esta deshabiltiado");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Permisos denegados");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        "Los permisos estan denegados permanentemente, no se puede solicitar permisos",
      );
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      currenPosition = position;
      Marker myPositionMaker = Marker(
        markerId: MarkerId("Mypos"),
        position: LatLng(currenPosition!.latitude, currenPosition!.longitude),
      );
      markers.add(myPositionMaker);
      setState(() {});
    } catch (e) {
      print("error: $e");
    }
  }

  @override
  void initState() {
    getPosition();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: currenPosition == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  currenPosition!.latitude,
                  currenPosition!.longitude,
                ),
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
