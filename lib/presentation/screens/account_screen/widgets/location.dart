import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => LocationState();
}

class LocationState extends State<Location> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(9.3171258, 76.6178996),
    zoom: 17.4746,
  );
  static const CameraPosition _kLake = CameraPosition(
      bearing: 20.8334901395799,
      target: LatLng(9.3171258, 76.6178996),
      tilt: 60.440717697143555,
      zoom: 19.151926040649414);

  Future<void> launchmap() async {
    final Uri uri =
        Uri(scheme: "https", host: 'goo.gl', path: 'maps/9GaKpkDYjcbXdQ586');
    if (!await launchUrl(
      uri,
      mode: LaunchMode.inAppWebView,
    )) {
      throw 'Could not launch ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor:const Color.fromARGB(255, 0, 115, 133),
        title: const Text('Location'),
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onTap: (argument) {
          launchmap();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor:const Color.fromARGB(255, 0, 115, 133),
        onPressed: _goToTheLake,
        label:const Text('Change view'),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
