import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/userModel.dart';
import 'package:flutter_application_1/providers/perfilProvider.dart';
import 'package:flutter_application_1/services/userService.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class RegisterPageWM extends StatefulWidget {
  @override
  _RegisterPageStateWM createState() => _RegisterPageStateWM();
}

class _RegisterPageStateWM extends State<RegisterPageWM> {
  final _formKey = GlobalKey<FormState>();

  // Controladores de texto para los campos
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();  // Nuevo campo
  final TextEditingController commentController = TextEditingController();


  // Llamamos al user service
  final UserService userService = UserService();

  // Variable para el tipo de usuario
  String selectedType = 'wineMaker';

  // Función para manejar el registro
  Future<void> register() async {
    if (_formKey.currentState!.validate()) {
      // Datos del formulario
      final user = UserModel(
      username: usernameController.text,
      name: nameController.text,
      mail: mailController.text,
      password: passwordController.text,
      comment: commentController.text,
      tipo: 'wineMaker',
      amigos: [],
      solicitudes: [],
    );
    print(user.username); 

      // Llamar al servicio
      final response = await userService.createUser(user);
      print('Vamos a ver');
      if (response is UserModel) {
        print('Fue exito');
        // Si el login fue exitoso, actualizamos el perfil y redirigimos
        // Usamos el Provider para acceder a la instancia de PerfilProvider y actualizar el usuario
        final perfilProvider = Provider.of<PerfilProvider>(context, listen: false);
        perfilProvider.updateUser(response); // Actualizamos el perfil del usuario
        Get.offNamed('/main'); // Redirigimos a la página principal
      } else {
        // Si el login no fue exitoso, mostramos un error
        setState(() {
        });
      }
    }
  }

  void toMainPage() async {
    Get.offNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: mailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo requerido';
                  } else if (!RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                    return 'Email inválido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) =>
                    value == null || value.length < 6 ? 'Mínimo 6 caracteres' : null,
              ),
              TextFormField(
                controller: confirmPasswordController,
                decoration: InputDecoration(labelText: 'Confirmar Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo requerido';
                  } else if (value != passwordController.text) {
                    return 'Las contraseñas no coinciden';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: commentController,
                decoration: InputDecoration(labelText: 'Comment'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: register,
                child: Text('Registrar',
                style: TextStyle(color: Colors.white), // Texto blanco
                ),
                style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFB04D47), // Fondo rosa-rojo (puedes cambiar el valor según tu preferencia)
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // Bordes redondeados
                ),
                ),
              ),
              ElevatedButton(
                onPressed: toMainPage,
                child: Text('Volver a la pagina principal',
                style: TextStyle(color: Colors.white), // Texto blanco
                ),
                style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFB04D47), // Fondo rosa-rojo (puedes cambiar el valor según tu preferencia)
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // Bordes redondeados
                ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
