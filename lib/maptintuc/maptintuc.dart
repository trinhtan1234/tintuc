import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            initialCenter: const LatLng(51.5, -0.09),
            initialZoom: 5,
            cameraConstraint: CameraConstraint.contain(
              bounds: LatLngBounds(
                const LatLng(-90, -180),
                const LatLng(90, 180),
              ),
            ),
          ),
          children: [
            TileLayer(
              wmsOptions: WMSTileLayerOptions(
                baseUrl: 'https://{s}.s2maps-tiles.eu/wms/?',
                layers: const ['s2cloudless-2021_3857'],
              ),
              subdomains: const ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'],
              userAgentPackageName: 'app.tintuc',
            ),
            // ignore: prefer_const_constructors
            RichAttributionWidget(
              popupInitialDisplayDuration: const Duration(seconds: 5),
              animationConfig: const ScaleRAWA(),
              showFlutterMapAttribution: false,
              attributions: const [
                TextSourceAttribution(
                  'Modified Copernicus Sentinel data 2021',
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
