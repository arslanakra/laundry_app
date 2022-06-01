import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../utils/constants.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(45.521563, -122.677433);
  Position? currentPosition;
  LocationPermission? permission;
  late GoogleMapController _googleMapLocator;
  final Geolocator geoLocator = Geolocator();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getLocation();
    });
    super.initState();

  }
  getLocation() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return;
      }
    }
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      currentPosition = position;
    });

  }
  // getCurrentLocation() async {
  //
  //   // print('advhsjdhkajhsjhas');
  //   Geolocator
  //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true)
  //       .then((Position position) {
  //
  //     setState(() {
  //       currentPosition = position;
  //       print(currentPosition);
  //     });
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: currentPosition != null ?  GoogleMap(
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          compassEnabled: true,
          zoomGesturesEnabled: true,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target:  LatLng(currentPosition!.latitude, currentPosition!.longitude),
            zoom: 13.5,
          ),
          zoomControlsEnabled: false,
        ) :
        Center(child: SpinKitFoldingCube(color: Constants.primaryColor,),),
      ),
    );
  }
}
