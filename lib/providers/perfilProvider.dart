import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/userModel.dart';

class PerfilProvider with ChangeNotifier {
  UserModel? perfilUsuario;

  // Método para actualizar el usuario
  void updateUser(UserModel newUser) {
    perfilUsuario = newUser;
    notifyListeners();  // Notifica a los widgets que escuchan este cambio
  }

  // Método para obtener el perfil actual
  UserModel? getUser() {
    return perfilUsuario;
  }
}
