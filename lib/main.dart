import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/screenWineLover/chat.dart';
import 'package:flutter_application_1/screen/screenWineLover/map.dart';
import 'package:flutter_application_1/screen/screenWineLover/perfilExternalUsuario.dart';
import 'package:flutter_application_1/screen/screenWineMaker/logInWM.dart';
import 'package:flutter_application_1/screen/screenWineMaker/registerWM.dart';
import 'package:flutter_application_1/widgets/bottomNavigationBarWM.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/screen/screenWineLover/logIn.dart';
import 'package:flutter_application_1/screen/screenWineLover/register.dart';
import 'package:flutter_application_1/screen/initPage.dart';
import 'package:flutter_application_1/widgets/bottomNavigationBar.dart'; 
//import 'package:flutter_application_1/widgets/tabBarScaffold.dart'; 
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
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => InitPage(),
        ),
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
          page: () => BottomNavScaffold(),
        ),
         GetPage(
          name: '/loginWM',
          page: () => LogInPageWM(),
        ),
        // Ruta de registro
        GetPage(
          name: '/registerWM',
          page: () => RegisterPageWM(),
        ),
        // Ruta para TabBarScaffold
        GetPage(
          name: '/mainWM',
          page: () => BottomNavScaffoldWM(),
        ),
        //Ruta para perfil de user
        GetPage(
          name: '/perfilExternalUsuario',
          page: () => PerfilExternalPage(),
        ),
        // Ruta para mapa
        GetPage(
          name: '/mapa',
          page: () => MapPage(),
        ),
        GetPage(
          name: '/chat',
          page: () => chatPage(),
        ),
      ],
    );
  }
}


