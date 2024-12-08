import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/home.dart';
import 'package:flutter_application_1/screen/perfilPersonal.dart';
import 'package:flutter_application_1/screen/user.dart';
import 'package:flutter_application_1/screen/experiencies.dart';
import 'package:flutter_application_1/screen/map.dart';

class TabBarScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // Número de pestañas
      child: Scaffold(
        body: Column(
          children: [
            Material(
              color: Color(0xFF6A1B9A), // Lila oscuro
              child: Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top), // Para manejar el notch
                child: const TabBar(
                  indicatorColor: Colors.white, // Indicador blanco
                  indicatorWeight: 2, // Grosor del indicador
                  labelColor: Colors.white, // Texto activo blanco
                  unselectedLabelColor: Colors.white70, // Texto inactivo gris
                  labelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                  tabs: [
                    Tab(
                      icon: Icon(Icons.wine_bar),
                      text: 'Home',
                    ),
                    Tab(
                      icon: Icon(Icons.favorite),
                      text: 'Amigos',
                    ),
                    Tab(
                      icon: Icon(Icons.explore),
                      text: 'Experiencias',
                    ),
                    Tab(
                      icon: Icon(Icons.person),
                      text: 'Perfil',
                    ),
                    Tab(
                      icon: Icon(Icons.map),
                      text: 'Mapa',
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  HomePage(), // Página de inicio
                  UserPage(), // Página de usuario
                  ExperienciesPage(), // Página de experiencias
                  PerfilPage(), // Página de perfil
                  MapPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
