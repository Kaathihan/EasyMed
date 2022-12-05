import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class LocationViewer extends StatefulWidget {
  LocationViewer({Key? key}) : super(key: key);

  @override
  _LocationViewerState createState() {
    return _LocationViewerState();
  }
}

class _LocationViewerState extends State<LocationViewer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    int count = 0;
    return Scaffold(
      appBar: AppBar(
          title: Text("View Pharmacies"), leading: Icon(Icons.arrow_back)),
      body: MaterialApp(),
    );
  }
}
