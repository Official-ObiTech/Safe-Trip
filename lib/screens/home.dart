import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safe_trip/widget/(map)/info.dart';

class Home extends StatefulWidget{
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {

  final Completer<GoogleMapController> controllerGMapCompleter = Completer<GoogleMapController>();
  GoogleMapController? controllerMapInstance;

  double paddingBottom = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: defualtLocation,
        onMapCreated: (GoogleMapController controller) {
          controllerGMapCompleter.complete(controller);
        },
      ),
    );
  }
}