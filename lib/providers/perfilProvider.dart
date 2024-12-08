import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/userModel.dart';

class PerfilProvider with ChangeNotifier {
  UserModel? perfilUsuario;
  UserModel? perfilExternalUsuario;
  UserModel? voidUsuario;

  // Método para actualizar el usuario
  void updateUser(UserModel newUser) {
    perfilUsuario = newUser;
    notifyListeners();  // Notifica a los widgets que escuchan este cambio
  }

  // Método para obtener el perfil actual
  UserModel? getUser() {
    return perfilUsuario;
  }

  void deleteUser() {
    perfilUsuario = voidUsuario;
    print(voidUsuario);
    notifyListeners();  // Notifica a los widgets que escuchan este cambio
  }

  void setExternalUser(UserModel newUser) {
    perfilExternalUsuario = newUser;
    notifyListeners();  // Notifica a los widgets que escuchan este cambio
  }

  void deleteExternalUser() {
    perfilExternalUsuario = voidUsuario;
    print(voidUsuario);
    notifyListeners();  // Notifica a los widgets que escuchan este cambio
  }

  UserModel? getExternalUser() {
    return perfilExternalUsuario;
  }
}
