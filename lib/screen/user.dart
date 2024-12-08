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
  List<UserModel> _solicitudesList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFriends();
    _loadSolicitudes();
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
    setState(() {
        _isLoading = false; // Detener la carga una vez que los datos estén listos
      });
    }  else {
      setState(() {
        _isLoading = false; // No hay amigos, también detenemos la carga
      });
    }
  }
  
  void _loadSolicitudes() async {
    // Obtener el usuario actual desde perfilProvider
    UserModel? currentUser = Provider.of<PerfilProvider>(context, listen: false).getUser();

    // Comprobamos si el usuario tiene amigos
    if (currentUser != null) {
      if(currentUser.solicitudes!.isNotEmpty) 
      {
      List<UserModel> loadedSolicitudes = [];
      for (String solicitudes in currentUser.solicitudes!) {
        // Llamamos al servicio findUser para obtener los detalles de cada amigo
        UserModel? user = await _userService.findUser(solicitudes,currentUser.token);
        if (user!=null){
          loadedSolicitudes.add(user);
        }
      }

      setState(() {
        _solicitudesList = loadedSolicitudes;
        _isLoading = false; // Detener la carga una vez que los datos estén listos
      });
    }
    setState(() {
        _isLoading = false; // Detener la carga una vez que los datos estén listos
      });
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

  void addFriend(username) async{
    UserModel? currentUser = Provider.of<PerfilProvider>(context, listen: false).getUser();
      int response = await _userService.addFriend(currentUser?.username, username);
      int response2 = await _userService.delSolicitud(currentUser?.username, username);
      // ignore: unrelated_type_equality_checks
      if (response==200 && response2==200){
        _loadFriends();
        _loadSolicitudes();
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Usuario añadido como amigo"),
          duration: Duration(seconds: 2), // El tiempo que aparece el mensaje
        ),
      );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Usuario no añadido como amigo"),
          duration: Duration(seconds: 2), // El tiempo que aparece el mensaje
        ),
      );
      }
    }

    void noaddFriend(username) async{
      UserModel? currentUser = Provider.of<PerfilProvider>(context, listen: false).getUser();
      int response = await _userService.delSolicitud(currentUser?.username, username);
      // ignore: unrelated_type_equality_checks
      if (response==200){
        _loadFriends();
        _loadSolicitudes();
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Solicitud de amistad eliminada"),
          duration: Duration(seconds: 2), // El tiempo que aparece el mensaje
        ),
      );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error al eliminar solicitud"),
          duration: Duration(seconds: 2), // El tiempo que aparece el mensaje
        ),
      );
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
                    labelText: 'Añadir usuario',
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
        flex: 1,
        child: _isLoading
            ? Center(child: CircularProgressIndicator()) // Mostrar cargando
            : _solicitudesList.isEmpty
                ? Center(child: Text('No hay solicitudes de amistad')) // Si no hay solicitudes
                : SingleChildScrollView(
                    child: ExpansionTile(
                      title: Text(
                        'Mostrar solicitudes de amistad (${_solicitudesList.length})',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      initiallyExpanded: false, // Empieza cerrado
                      children: _solicitudesList.map((user) {
                        final username = user.username; // Obtener el nombre de usuario
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.grey[200], // Fondo gris claro
                            ),
                            child: ListTile(
                              title: Text(username ?? 'Usuario desconocido'), // Muestra el nombre de usuario
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.check, color: Colors.green),
                                    onPressed: () => addFriend(username), // Llama a `addFriend`
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.close, color: Colors.red),
                                    onPressed: () => noaddFriend(username), // Llama a `noaddFriend`
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
      ),
        Expanded(
          flex: 2,
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