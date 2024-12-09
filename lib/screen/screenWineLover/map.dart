import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
//import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa con OpenStreetMap'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(41.382395521312176, 2.1567611541534366), // Ejemplo: Buenos Aires
          zoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(41.382395521312176, 2.1567611541534366), // Barcelona
                builder: (ctx) => Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 30.0,
                ),
              ),
              Marker(
                point: LatLng(39.884440544020734, 4.266759450372821), // mao
                builder: (ctx) => Icon(
                  Icons.location_on,
                  color: Colors.blue,
                  size: 30.0,
                ),
              ),
              
              // Add more markers here
            ],
          ),
        ],
      ),
    );
  }
}
