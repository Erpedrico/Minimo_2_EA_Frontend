import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/home.dart';
import 'package:flutter_application_1/screen/perfilPersonal.dart';
import 'package:flutter_application_1/screen/user.dart';
import 'package:flutter_application_1/screen/experiencies.dart';
import 'package:flutter_application_1/screen/map.dart';

class BottomNavScaffold extends StatefulWidget {
  @override
  _BottomNavScaffoldState createState() => _BottomNavScaffoldState();
}

class _BottomNavScaffoldState extends State<BottomNavScaffold> {
  // Índice para controlar la pestaña seleccionada
  int _selectedIndex = 2;

  // Lista de widgets para las diferentes pantallas
  final List<Widget> _pages = [   
    UserPage(),          
    ExperienciesPage(),
    HomePage(),
    MapPage(),
    PerfilPage(),           
  ];

  // Método para manejar el cambio de pestaña
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Actualiza el índice seleccionado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fondo lila aplicado correctamente a toda la pantalla
      backgroundColor: Color(0xFFD8BFD8), // Lila suave (Hex: #D8BFD8)
      body: _pages[_selectedIndex], // Muestra la página según el índice seleccionado
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Índice de la pestaña seleccionada
        onTap: _onItemTapped, // Llama al método para cambiar de pestaña
        selectedItemColor: Colors.white, // Iconos seleccionados en blanco
        unselectedItemColor: Colors.white60, // Iconos no seleccionados en blanco con opacidad
        backgroundColor: const Color.fromARGB(255, 173, 13, 88), // Fondo púrpura de la barra de navegación
        type: BottomNavigationBarType.fixed, // Asegura que los iconos estén alineados correctamente
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Amigos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Experiencias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wine_bar),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}



