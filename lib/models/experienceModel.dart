/*class ExperienceModel {
  final String? id;
  final String? title;
  final String? owner;
  //final List<String>? participants;
  final String? description;
  final int? price;
  final String? location;
  final int? contactnumber;
  final String? contactmail;


  ExperienceModel({
    this.id,
    this.title,
    this.owner,
    //this.participants,
    this.description,
    this.price,
    this.location,
    this.contactnumber,
    this.contactmail
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      id: json['_id'],
      title: json['title'],
      owner: json['owner'],
      //participants: List<String>.from(json['participants']),
      description: json['description'],
      price: json['price'],
      location: json['location'],
      contactnumber: json['contactnumber'],
      contactmail: json['contactmail']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'owner': owner,
      //'participants': participants,
      'description': description,
      'price': price,
      'location': location,
      'contactnumber': contactnumber,
      'contactmail':contactmail
    };
  }
}*/

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
