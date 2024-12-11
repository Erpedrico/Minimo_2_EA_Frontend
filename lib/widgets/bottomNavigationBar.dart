import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/conciencia_digital/timerService.dart';
import 'package:flutter_application_1/screen/screenWineLover/home.dart';
import 'package:flutter_application_1/screen/screenWineLover/perfilPersonal.dart';
import 'package:flutter_application_1/screen/screenWineLover/user.dart';
import 'package:flutter_application_1/screen/screenWineLover/experiencies.dart';
import 'package:flutter_application_1/screen/screenWineLover/map.dart';

class BottomNavScaffold extends StatefulWidget {
  @override
  _BottomNavScaffoldState createState() => _BottomNavScaffoldState();
}

class _BottomNavScaffoldState extends State<BottomNavScaffold> {
  // Índice para controlar la pestaña seleccionada
  int _selectedIndex = 2;
  
  // Variable para evitar mostrar el dialog varias veces
  bool _dialogShown = false;

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
  void didChangeDependencies() {
    super.didChangeDependencies();

    final timerService = Provider.of<TimerService>(context, listen: true);
    if (timerService.elapsedMinutes % 10 == 0 && timerService.elapsedMinutes > 0) {
      // Retrasar el diálogo hasta que la construcción esté terminada
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showTakeABreakDialog();
      });
    }
  }

  void _showTakeABreakDialog() {
    // Marca que el dialog ya ha sido mostrado
    setState(() {
      _dialogShown = true;
    });

    // Muestra el dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("¡Tómate un descanso!"),
        content: Text("Llevas mucho tiempo con el móvil, ¿qué tal un descanso?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Restablece la bandera después de que el diálogo se cierre
              setState(() {
                _dialogShown = false;
              });
            },
            child: Text("Ok"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
