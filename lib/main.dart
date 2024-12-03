import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/perfilExternalUsuario.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/screen/logIn.dart';
import 'package:flutter_application_1/screen/register.dart';
import 'package:flutter_application_1/widgets/tabBarScaffold.dart'; 
import 'package:flutter_application_1/providers/perfilProvider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PerfilProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      getPages: [
        // Ruta de inicio de sesión
        GetPage(
          name: '/login',
          page: () => LogInPage(),
        ),
        // Ruta de registro
        GetPage(
          name: '/register',
          page: () => RegisterPage(),
        ),
        // Ruta para TabBarScaffold
        GetPage(
          name: '/main',
          page: () => TabBarScaffold(),
        ),
        //Ruta para perfil de user
        GetPage(
          name: '/perfilExternalUsuario',
          page: () => PerfilExternalPage(),
        ),
      ],
    );
  }
}

