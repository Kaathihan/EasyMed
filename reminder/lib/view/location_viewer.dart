import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:reminder/model/app_constants.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationViewer extends StatefulWidget {
  LocationViewer({Key? key}) : super(key: key);

  @override
  _LocationViewerState createState() {
    return _LocationViewerState();
  }
}

class _LocationViewerState extends State<LocationViewer> {
  @override
  late MapController mapController;
  var _positionMessage = '';
  var _descriptionMessage = '';
  LatLng currentLocation = LatLng(0, 0);
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    int count = 0;

    Geolocator.isLocationServiceEnabled().then((value) => null);
    Geolocator.requestPermission().then((value) => null);
    Geolocator.checkPermission().then((LocationPermission permission) {
      print("Check Location Permission: $permission");
    });
    Geolocator.getPositionStream(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.best),
    ).listen(_updateLocationStream);
    return Scaffold(
        appBar: AppBar(
            title: Text("View Pharmacies"), leading: Icon(Icons.arrow_back)),
        body: Stack(children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
                minZoom: 5, maxZoom: 18, zoom: 13, center: currentLocation),
            layers: [
              TileLayerOptions(
                urlTemplate: AppConstants.mapBoxStyleID,
              ),
              MarkerLayerOptions(rotate: true),
            ],
          ),
        ]));
  }

  _updateLocationStream(Position userLocation) async {
    Position userLocation = await Geolocator.getCurrentPosition();
    setState(() {
      currentLocation = LatLng(
          userLocation.latitude.toDouble(), userLocation.longitude.toDouble());
    });
  }
}
