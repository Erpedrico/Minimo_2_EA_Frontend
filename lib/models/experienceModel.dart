/*import 'package:flutter/material.dart';

class ExperienceModel with ChangeNotifier {
  String _owner;
  String _participants;
  String _description;

  // Constructor
  ExperienceModel({required String owner, required String participants, required String description})
      : _owner = owner,
        _participants = participants,
        _description = description;

  // Getters
  String get owner => _owner;
  String get participants => _participants;
  String get description => _description;

  // Método para actualizar el usuario
  void setExperience(String owner, String participants, String description) {
    _owner = owner;
    _participants = participants;
    _description = description;
    notifyListeners();
  }

  // Método fromJson para crear una instancia de UserModel desde un Map
  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      owner: json['owner'] ?? 'Propietario desconocido',
      participants: json['participants'] ?? 'Sin Participantes',
      description: json['description'] ?? 'Sin descripcion',
    );
  }

  // Método toJson para convertir una instancia de UserModel en un Map
  Map<String, dynamic> toJson() {
    return {
      'name': _owner,
      'mail': _participants,
      'comment': _description,
    };
  }
}*/


class ExperienceModel {
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
}

