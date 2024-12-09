import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _leftGrapeAnimation;
  late Animation<double> _rightGrapeAnimation;

  @override
  void initState() {
    super.initState();

    // Controlador para ambas animaciones
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    // Animación para la uva de la izquierda
    _leftGrapeAnimation = Tween<double>(begin: -150, end: 150).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceInOut),
    );

    // Animación para la uva de la derecha
    _rightGrapeAnimation = Tween<double>(begin: -150, end: 150).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Stack(
          children: [
            // Texto central
            Center(
              child: Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: const Text(
                  'Gracias por unirte a la familia Winners',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // Uva izquierda
            AnimatedBuilder(
              animation: _leftGrapeAnimation,
              builder: (context, child) {
                return Positioned(
                  top: MediaQuery.of(context).size.height / 2 + _leftGrapeAnimation.value,
                  left: MediaQuery.of(context).size.width / 4 - 25,
                  child: Transform.scale(
                    scale: 2.0, // Escala de la uva
                    child: Icon(
                      Icons.circle, // Cambia esto a una imagen personalizada si tienes una
                      size: 50,
                      color: Colors.purple,
                    ),
                  ),
                );
              },
            ),
            // Uva derecha
            AnimatedBuilder(
              animation: _rightGrapeAnimation,
              builder: (context, child) {
                return Positioned(
                  top: MediaQuery.of(context).size.height / 2 + _rightGrapeAnimation.value,
                  left: MediaQuery.of(context).size.width * 3 / 4 - 25,
                  child: Transform.scale(
                    scale: 2.0, // Escala de la uva
                    child: Icon(
                      Icons.circle, // Cambia esto a una imagen personalizada si tienes una
                      size: 50,
                      color: Colors.purple,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
