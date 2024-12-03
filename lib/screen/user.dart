import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart'; // Asegúrate de importar provider
import '../models/userModel.dart'; // Asegúrate de que esta ruta sea correcta
import '../services/userService.dart'; // Asegúrate de que esta ruta sea correcta
import '../providers/perfilProvider.dart'; // Ruta del perfilProvider
import '../widgets/userCard.dart'; // Asegúrate de que esta ruta sea correcta

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final TextEditingController _searchController = TextEditingController();
  final UserService _userService = UserService();
  List<UserModel> _friendsList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFriends();
  }

  // Cargar los amigos del perfil actual
  void _loadFriends() async {
    // Obtener el usuario actual desde perfilProvider
    UserModel? currentUser = Provider.of<PerfilProvider>(context, listen: false).getUser();

    // Comprobamos si el usuario tiene amigos
    if (currentUser != null) {
      if(currentUser.amigos!.isNotEmpty) 
      {
      List<UserModel> loadedFriends = [];
      for (String amigo in currentUser.amigos!) {
        // Llamamos al servicio findUser para obtener los detalles de cada amigo
        UserModel? user = await _userService.findUser(amigo,currentUser.token);
        if (user!=null){
          loadedFriends.add(user);
        }
      }

      setState(() {
        _friendsList = loadedFriends;
        _isLoading = false; // Detener la carga una vez que los datos estén listos
      });
    }
    }  else {
      setState(() {
        _isLoading = false; // No hay amigos, también detenemos la carga
      });
    }
  }
  
  void buscarUsuario(String nombre) async {
    UserModel? currentUser = Provider.of<PerfilProvider>(context, listen: false).getUser();
    print("Buscando usuario: $nombre");
    if (currentUser != null) {
      UserModel? user = await _userService.findUser(nombre,currentUser.token);
      if (user == null) {
      // Mostrar mensaje en pantalla
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Usuario no encontrado"),
          duration: Duration(seconds: 2), // El tiempo que aparece el mensaje
        ),
      );
    } else {
      print("Usuario encontrado: ${user.username}");
      Provider.of<PerfilProvider>(context, listen: false).setExternalUser(user);
      Get.offNamed('/perfilExternalUsuario');
    }
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Amigos'),
    ),
    body: Column(
      children: [
        // Barra de búsqueda
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Campo de texto de búsqueda
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Buscar usuario',
                    hintText: 'Introduce un nombre',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      buscarUsuario(value); // Llamamos a la función con el nombre
                    }
                  },
                ),
              ),
              SizedBox(width: 8.0), // Espacio entre el buscador y el botón
              // Botón de búsqueda
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  final value = _searchController.text;
                  if (value.isNotEmpty) {
                    buscarUsuario(value); // Llamamos a la función con el nombre
                  }
                },
              ),
            ],
          ),
        ),
        // Cuerpo principal
        Expanded(
          child: _isLoading
              ? Center(child: CircularProgressIndicator()) // Mostrar cargando
              : _friendsList.isEmpty
                  ? Center(child: Text('No hay amigos para mostrar')) // Si no hay amigos
                  : ListView.builder(
                      itemCount: _friendsList.length,
                      itemBuilder: (context, index) {
                        return UserCard(user: _friendsList[index]);
                      },
                    ),
        ),
      ],
    ),
  );
}
}