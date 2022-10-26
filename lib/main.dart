import 'package:flutter/material.dart';
// flutter_mapパッケージ追加
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(MapApp());
}

class MapApp extends StatefulWidget {
  @override
  _MapAppState createState() => _MapAppState();
}

class _MapAppState extends State<MapApp> {
  final String _title = 'map_app';

  double lat = 0;
  double log = 0;

  late Position _position;

  void _getCurrentLocation() async {
    Position position = await _determinePosition();
    setState(() {
      _position = position;
      lat = position.latitude;
      log = position.longitude;
      print('lat:$lat');
      print('log:$log');
    });
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        // flutter_map設定
        body: FlutterMap(
          // マップ表示設定
          options: MapOptions(
            center: LatLng(34.3405724613467, 134.04341747098732),
            zoom: 15.0,
          ),
          nonRotatedChildren: [
            AttributionWidget.defaultWidget(
              source: 'OpenStreetMap contributors',
              onSourceTapped: null,
            ),
          ],
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(lat, log),
                  width: 80,
                  height: 80,
                  builder: (context) => const Icon(
                    Icons.room,
                    color: Color.fromARGB(255, 209, 28, 28),
                    size: 35.0,
                  ),
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _getCurrentLocation,
          tooltip: 'Increment',
          child: const Icon(Icons.my_location),
        ),
      ),
    );
  }
}
