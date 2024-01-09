import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                tileProvider: CancellableNetworkTileProvider(),
              ),
              RichAttributionWidget(
                popupInitialDisplayDuration: const Duration(seconds: 5),
                animationConfig: const ScaleRAWA(),
                showFlutterMapAttribution: false,
                attributions: [
                  TextSourceAttribution(
                    'Bản đồ mã nguồn mở',
                    onTap: () => launchUrl(
                      Uri.parse('https://openstreetmap.org/copyright'),
                    ),
                  ),
                  const TextSourceAttribution(
                    'Bản đồ này là bản đồ dũng mã nguồn mở thuộc Flutter_Map',
                    prependCopyright: true,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
