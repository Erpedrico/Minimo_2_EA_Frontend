import 'package:latlong2/latlong.dart';

class ExperienceModel {
  String? id;
  String? title;
  String? description;
  String? owner;
  int? price;
  String? location;
  int? contactnumber;
  String? contactmail;
  LatLng? coordinates; // Coordenadas calculadas (opcional)

  ExperienceModel({
    this.id,
    this.title,
    this.description,
    this.owner,
    this.price,
    this.location,
    this.contactnumber,
    this.contactmail,
    this.coordinates,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      owner: json['owner'],
      price: json['price'],
      location: json['location'],
      contactnumber: json['contactnumber'],
      contactmail: json['contactmail'],
      coordinates: LatLng(json['latitude'] ?? 0.0, json['longitude'] ?? 0.0), // Usar los valores directamente
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'owner': owner,
      'price': price,
      'location': location,
      'contactnumber': contactnumber,
      'contactmail': contactmail,
      'latitude': coordinates?.latitude,
      'longitude': coordinates?.longitude, // Asegúrate de usar las coordenadas en lugar de lat/lng
    };
  }
}
