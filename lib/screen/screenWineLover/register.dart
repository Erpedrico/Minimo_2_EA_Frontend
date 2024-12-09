import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/userModel.dart';
import 'package:flutter_application_1/providers/perfilProvider.dart';
import 'package:flutter_application_1/services/userService.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  // Controladores de texto para los campos
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController commentController = TextEditingController();


  // Llamamos al user service
  final UserService userService = UserService();

  // Variable para el tipo de usuario
  String selectedType = 'wineLover';

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
      tipo: 'wineLover',
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

  void toLogIn() async {
    Get.offNamed('/login');
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
                validator: (value) =>
                    value == null || !value.contains('@') ? 'Email inválido' : null,
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) =>
                    value == null || value.length < 6 ? 'Mínimo 6 caracteres' : null,
              ),
              TextFormField(
                controller: commentController,
                decoration: InputDecoration(labelText: 'Comment'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: register,
                child: Text('Registrar'),
              ),
              ElevatedButton(
                onPressed: toLogIn,
                child: Text('Volver al login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

