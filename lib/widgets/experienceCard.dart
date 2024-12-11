import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/experienceModel.dart';

class ExperienceCard extends StatelessWidget {
  final ExperienceModel experience;
  final VoidCallback onDelete;

  const ExperienceCard({
    Key? key,
    required this.experience,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              experience.title ?? 'Sin título',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Descripción: ${experience.description ?? 'Sin descripción'}'),
            Text('Propietario: ${experience.owner ?? 'Sin propietario'}'),
            Text('Precio: \$${experience.price ?? 'N/A'}'),
            Text('Localización: ${experience.location ?? 'Sin localización'}'),
            Text('Teléfono: ${experience.contactnumber ?? 'Sin número'}'),
            Text('Correo: ${experience.contactmail ?? 'Sin correo'}'),
            Text('Latitud: ${experience.coordinates?.latitude ?? 'Sin latitud'}'),
            Text('Longitud: ${experience.coordinates?.longitude ?? 'Sin longitud'}'),

            const SizedBox(height: 16),
            SizedBox(
              height: 200, // Altura del mapa
              child: FlutterMap(
                options: MapOptions(
                  center: experience.coordinates ??
                      LatLng(0.0, 0.0), // Coordenadas predeterminadas si no hay datos
                  zoom: 13.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                  ),
                  if (experience.coordinates != null)
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: experience.coordinates!,
                          builder: (ctx) => Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 30.0,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
