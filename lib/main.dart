import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Map(),
    );
  }
}

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: Center(
        child: FlutterMap(
          mapController: MapController(),
          options: MapOptions(
            center: latLng.LatLng(34.342940650325446, 134.04432819189344),
            zoom: 16.0,
            maxZoom: 17.0,
            minZoom: 3.0,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
              retinaMode: true,
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                  point: latLng.LatLng(32.74472, 129.87361),
                  builder: (ctx) => const Icon(
                    Icons.location_pin,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ],
          children: const [],
        ),
      ),
    );
  }
}
