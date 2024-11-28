import 'package:flutter/material.dart';
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
        UserModel user = await _userService.findUser(amigo,currentUser.token);
        loadedFriends.add(user);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Management'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator()) // Mostrar cargando
          : _friendsList.isEmpty
              ? Center(child: Text('No hay amigos para mostrar')) // Si no hay amigos
              : ListView.builder(
                  itemCount: _friendsList.length,
                  itemBuilder: (context, index) {
                    return UserCard(user: _friendsList[index]);
                  },
                ),
    );
  }
}
