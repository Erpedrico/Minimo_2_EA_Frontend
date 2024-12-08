import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/perfilProvider.dart';
import 'package:flutter_application_1/models/userModel.dart';
import 'package:flutter_application_1/services/userService.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class PerfilExternalPage extends StatelessWidget {
  final UserService _userService = UserService();
  @override
  Widget build(BuildContext context) {
    // Obtener el PerfilProvider desde el contexto
    final perfilProvider = Provider.of<PerfilProvider>(context, listen: false);

    // Acceder al perfil actual almacenado en el PerfilProvider
    UserModel? perfil = perfilProvider.perfilExternalUsuario;
    UserModel? currentUser = perfilProvider.perfilUsuario;

    // Verificamos si existe el perfil, si no, mostramos un mensaje de error
    if (perfil == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Perfil")),
        body: Center(child: Text("No se ha encontrado el perfil")),
      );
    }

    // Función para cerrar sesión
    void volver() {
      perfilProvider.deleteExternalUser();
      Get.offNamed('/main');
    }

    void addSolicitud() async{
      int response = await _userService.addSolicitud(currentUser?.username, perfil.username);
      // ignore: unrelated_type_equality_checks
      if (response==200){
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Solicitud de amistad enviada"),
          duration: Duration(seconds: 2), // El tiempo que aparece el mensaje
        ),
      );
      Get.offNamed('/main');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error al enviar solicitud"),
          duration: Duration(seconds: 2), // El tiempo que aparece el mensaje
        ),
      );
      }
    }

    // Si existe el perfil, mostramos los datos
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil de ${perfil.username}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nombre: ${perfil.name}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Correo: ${perfil.mail}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("Tipo: ${perfil.tipo}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("Comentario: ${perfil.comment}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("ID: ${perfil.id}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("Token: ${perfil.token}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("Nombre de Usuario: ${perfil.username}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: volver,
              child: Text("Volver"),
            ),
            ElevatedButton(
              onPressed: addSolicitud, 
              child: Text("Enviar solicitud de amistad")
            ),
          ],
        ),
      ),
    );
  }
}
