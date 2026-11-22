import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class _Place {
  final String name;
  final LatLng point;
  const _Place(this.name, this.point);
}

// Koordinat contoh sekitar IT Del, Laguboti. Ganti dengan lokasi pilihan Anda
// (klik kanan di openstreetmap.org lalu salin koordinatnya).
const _places = [
  _Place('Kampus', LatLng(2.3835, 99.1477)),
  _Place('Perpustakaan', LatLng(2.3842, 99.1485)),
  _Place('Kantin', LatLng(2.3828, 99.1470)),
];

class CampusMap extends StatelessWidget {
  const CampusMap({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: _places.first.point,
        initialZoom: 16,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'del.ac.id.pam_notes',
        ),
        MarkerLayer(
          markers: _places
              .map(
                (p) => Marker(
                  point: p.point,
                  width: 44,
                  height: 44,
                  child: GestureDetector(
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(p.name)),
                    ),
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 44,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const RichAttributionWidget(
          attributions: [
            TextSourceAttribution('© OpenStreetMap contributors'),
          ],
        ),
      ],
    );
  }
}