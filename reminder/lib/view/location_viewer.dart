import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:reminder/model/app_constants.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'
    hide LatLng, Marker, Location;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:reminder/controller/PlacesResponse.dart';

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
  LatLng origin = LatLng(43.76797479617749, -79.30457865788011);
  List<LatLng> pharmas = [];
  double currentZoom = 13;

  void initState() {
    super.initState();
    mapController = MapController();
    _determinePosition();
    _getPharma();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    int count = 0;

    return Scaffold(
        appBar: AppBar(
          title: Text("View Pharmacies"),
          leading: Icon(Icons.arrow_back),
          actions: <Widget>[
            IconButton(onPressed: _zoomIn, icon: Icon(Icons.zoom_in)),
            IconButton(onPressed: _zoomOut, icon: Icon(Icons.zoom_out))
          ],
        ),
        body: Stack(children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
                minZoom: 5, maxZoom: 18, zoom: currentZoom, center: origin),
            layers: [
              TileLayerOptions(
                urlTemplate: AppConstants.mapBoxStyleID,
              ),
              MarkerLayerOptions(
                markers: [
                  for (int i = 0; i < pharmas.length; i++)
                    Marker(
                        height: 80,
                        width: 80,
                        point: pharmas[i],
                        builder: (context) {
                          return Container(
                            child: IconButton(
                              onPressed: () {
                                setState(() {});
                              },
                              icon: Icon(Icons.location_on, color: Colors.red),
                              iconSize: 45,
                            ),
                          );
                        }),
                ],
              ),
            ],
          ),
        ]));
  }

  _updateLocationStream(Position userLocation) async {
    _positionMessage = userLocation.latitude.toString() +
        ',' +
        userLocation.longitude.toString();
    final List<Placemark> places = await placemarkFromCoordinates(
        userLocation.latitude, userLocation.longitude);
    setState(() {
      _descriptionMessage = '${[places[0]]}';
    });
  }

  _getPharma() async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' +
            origin.latitude.toString() +
            ',' +
            origin.longitude.toString() +
            '&radius=10000&type=pharmacy&key=' +
            AppConstants.googleToken);

    var response = await http.post(url);

    PlacesResponse placeResponse =
        PlacesResponse.fromJson(jsonDecode(response.body));

    for (int i = 0; i < placeResponse.results!.length; i++) {
      if (placeResponse.results![i].types!.contains("pharmacy") == true) {
        pharmas.add(LatLng(placeResponse.results![i].geometry!.location!.lat!,
            placeResponse!.results![i].geometry!.location!.lng!));
      }
    }
    setState(() {});
  }

  void _zoomOut() {
    currentZoom -= 1;
    mapController.move(origin, currentZoom);
  }

  void _zoomIn() {
    currentZoom += 1;
    mapController.move(origin, currentZoom);
  }

  _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    setState(() {
      Geolocator.getCurrentPosition().then(
        (value) {
          origin = LatLng(value.latitude, value.longitude);
        },
      );
    });
  }
}
