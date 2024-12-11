import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/screenWineLover/logIn.dart';
import 'package:flutter_application_1/screen/screenWineLover/register.dart';

class TabBarScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController( 
      length: 2, // Número de pestañas (LogIn y Register)
      child: Scaffold(
        body: Column(
          children: [
            Material(
              child: Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top), // Para manejar el notch
                child: const TabBar(
                  indicatorColor: Color(0xFF6A1B9A), // Línea debajo de las pestañas en morado
                  indicatorWeight: 3, // Grosor del indicador
                  labelColor: Colors.black, // Texto activo en negro
                  unselectedLabelColor: Colors.black, // Texto inactivo en negro
                  labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600), // Aumentamos el tamaño y estilo del texto
                  tabs: [
                    Tab(
                      text: 'LogIn',
                    ),
                    Tab(
                      text: 'Register',
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  LogInPage(), // Página de inicio
                  RegisterPage(), // Página de registro
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

