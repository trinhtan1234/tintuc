import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:tintuc/maptintuc/infodialog.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "";
  String lat = "";
  late StreamSubscription<Position> positionStream;

  LatLng currentLatLng = const LatLng(20.96103, 105.7410017);

  Marker currentLocationMarker = Marker(
    width: 45,
    height: 45,
    point: const LatLng(0, 0),
    builder: (context) => const Icon(
      Icons.location_searching_outlined,
      color: Colors.blue,
    ),
  );

  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    checkGps();
    loadGeoJSON();
  }

  Future<void> checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
        } else if (permission == LocationPermission.deniedForever) {
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }
      if (haspermission) {
        setState(() {});
        getLocation();
      }
    } else {}
    setState(() {});
  }

  Future<void> getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // print(position.longitude);
    // print(position.latitude);

    // long = position.longitude.toString();
    // lat = position.latitude.toString();

    setState(() {
      currentLatLng = LatLng(position.latitude, position.longitude);
      long = position.longitude.toString();
      lat = position.latitude.toString();
      currentLocationMarker = Marker(
          width: 45,
          height: 45,
          point: LatLng(position.latitude, position.longitude),
          builder: (context) => Container(
                width: 5,
                height: 5,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Center(
                  child: Icon(
                    Icons.lens_sharp,
                    color: Colors.blue,
                  ),
                ),
              ));
    });
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    positionStream = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((Position position) {
      long = position.longitude.toString();
      lat = position.latitude.toString();

      setState(() {});
    });
  }

  @override
  void dispose() {
    positionStream.cancel(); // Cancel the subscription to prevent memory leaks
    super.dispose();
  }

// Lấy dữ liệu từ file json
  Future<void> loadGeoJSON() async {
    String geoJSONContent =
        await rootBundle.loadString('assets/locations.json');
    Map<String, dynamic> geoJSONData = json.decode(geoJSONContent);
    List<dynamic> features = geoJSONData['features'];

    setState(() {
      markers = features.map((feature) {
        List<dynamic> coordinates = feature['geometry']['coordinates'];
        double latitude = coordinates[1];
        double longitude = coordinates[0];
        LatLng latLng = LatLng(latitude, longitude);
        String name = feature['properties']['name'].toString();
// hiển thị điểm trong file json
        return Marker(
          width: 45,
          height: 45,
          point: latLng,
          builder: (context) => GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => MarkerInfoDialog(
                  name: name,
                  coordinates: coordinates[1],
                ),
              );
            },
            child: const Icon(
              Icons.location_pin,
              color: Colors.green,
            ),
          ),
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bản đồ vị trí'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: currentLatLng, // Tọa độ trung tâm bản đồ
          zoom: 10.0, // Mức zoom mặc định
        ),
        children: <Widget>[
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(markers: [currentLocationMarker] + markers),
          Container(
            margin: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 50,
                height: 50,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Center(
                  child: IconButton(
                    onPressed: () {
                      getLocation();
                    },
                    icon: const Icon(
                      Icons.explore,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
