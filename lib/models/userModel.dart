import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {
  String? _username; 
  String? _id;       
  String? _token; 
  String _name;
  String _mail;
  String _password;
  String _comment;   
  String _tipo;     
  List<String>? _amigos; 
  List<String>? _solicitudes; 

  // Constructor
  UserModel({
    String? username,
    String? id,
    String? token,
    required String name,
    required String mail,
    required String password,
    required String comment,
    required String tipo,
    List<String>? amigos,
    List<String>? solicitudes,
  })  : _username = username,
        _id = id,
        _token = token,
        _name = name,
        _mail = mail,
        _password = password,
        _comment = comment,
        _tipo = tipo,
        _amigos = amigos,
        _solicitudes = solicitudes; 

  // Getters
  String? get username => _username;
  String? get id => _id;
  String? get token => _token;
  String get name => _name;
  String get mail => _mail;
  String get password => _password;
  String get comment => _comment;
  String get tipo => _tipo;
  List<String>? get amigos => _amigos; 
  List<String>? get solicitudes => _solicitudes; 

  // Método para actualizar el usuario
  void setUser({
    String? username,
    String? id,
    String? token,
    required String name,
    required String mail,
    required String password,
    required String comment,
    required String tipo,
    List<String>? amigos,
    List<String>? solicitud,
  }) {
    _username = username;
    _id = id;
    _token = token;
    _name = name;
    _mail = mail;
    _password = password;
    _comment = comment;
    _tipo = tipo;
    _amigos = amigos;
    _solicitudes = solicitud;
    notifyListeners();
  }

  void setToken(String? token) {
    _token = token;
    notifyListeners();
  }

  // Método fromJson para crear una instancia de UserModel desde un Map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'], 
      id: json['_id'],           
      token: json['token'],
      name: json['name'] ?? 'Usuario desconocido',
      mail: json['mail'] ?? 'No especificado',
      password: json['password'] ?? 'Sin contraseña',
      comment: json['comment'] ?? 'Sin comentarios',      
      tipo: json['tipo'] ?? 'Sin tipo',  
      amigos: json['amigos'] != null ? List<String>.from(json['amigos']) : [], 
      solicitudes: json['solicitudes'] != null ? List<String>.from(json['solicitudes']) : [], 
    );
  }

  // Método toJson para convertir una instancia de UserModel en un Map
  Map<String, dynamic> toJson() {
    return {
      'username': _username, 
      'name': _name,
      'mail': _mail,
      'password': _password,
      'comment': _comment,       
      'tipo': _tipo,
      'habilitado': true,
      'amigos': _amigos,
      'solicitudes':_solicitudes,
    };
  }
}
