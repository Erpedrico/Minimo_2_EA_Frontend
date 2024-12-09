import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB04D47), 
      appBar: AppBar(
        title: Text(
          "WELCOME TO WINER", 
          style: TextStyle(
          color: Colors.white, 
          fontWeight: FontWeight.bold, 
          ),
        ),
        backgroundColor: Color(0xFFB04D47), 
        elevation: 0,
        centerTitle: true, 
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Descripción
            Text(
              "Please choose your profile:",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),

            // Botón Wine Lover
            ElevatedButton.icon(
              onPressed: () {
                // Redirige a la página Wine lover
                Get.offNamed('/login');
              },
              icon: Icon(
                Icons.person, 
                color: Colors.yellow, // Icono de usuario en amarillo
                size: 30,
              ),
              label: Text(
                'Wine lover',
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 20,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent, // Fondo transparente
                shadowColor: Colors.transparent, // Sin sombra
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.yellow, width: 2),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
            ),
            SizedBox(height: 20),

            // Botón Wine Maker
            ElevatedButton.icon(
              onPressed: () {
                // Redirige a la página Wine maker
                Get.offAllNamed('/loginWM');
              },
              icon: Icon(
                Icons.local_bar, 
                color: Colors.white, // Icono de copa de vino en blanco
                size: 30,
              ),
              label: Text(
                'Wine maker',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent, // Fondo transparente
                shadowColor: Colors.transparent, // Sin sombra
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.white, width: 2),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
