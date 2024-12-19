import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/userModel.dart';
import 'package:flutter_application_1/providers/perfilProvider.dart';
import 'package:flutter_application_1/services/userService.dart';
import 'package:flutter_application_1/utils/authentication.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/utils/authentication.dart';


const List<String> scopes = <String>[
  'email',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  clientId: 'TU_CLIENT_ID.apps.googleusercontent.com',
  scopes: scopes,
);

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  String errorMessage = '';

  final UserService userService = UserService();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signInWithGoogle() async {
    try {
      // Inicia sesión con Google
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // El usuario canceló el inicio de sesión
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Crea credenciales para Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Autentica con Firebase
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Obtén el correo electrónico del usuario
      final String? email = userCredential.user?.email;
      print('Usuario autenticado: $email');

      // Aquí puedes enviar el correo a tu API
    } catch (e) {
      print('Error al iniciar sesión con Google: $e');
    }
  }

  // Función para manejar el login
  void logIn() async {
    // Validación de campos
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      setState(() {
        errorMessage = 'Campos vacíos';
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    final logIn = (
      username: usernameController.text,
      password: passwordController.text,
    );

    try {
      // Llamada al servicio para iniciar sesión
      final response = await userService.logIn(logIn);

      if (response is UserModel) {
        // Si el login fue exitoso, actualizamos el perfil y redirigimos
        // Usamos el Provider para acceder a la instancia de PerfilProvider y actualizar el usuario
        final perfilProvider = Provider.of<PerfilProvider>(context, listen: false);
        perfilProvider.updateUser(response); // Actualizamos el perfil del usuario
        if (response.tipo=='wineLover'){
          Get.offNamed('/main');
        } else{
          Get.offNamed('/mainWM');
        } 
      } else {
        // Si el login no fue exitoso, mostramos un error
        setState(() {
          errorMessage = 'Usuario o contraseña incorrectos';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: No se pudo conectar con la API';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
  
  Future<void> _handleSignInWithGoogle() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      // Inicia sesión con Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
          print('Usuario autenticado y enviado a la API correctamente');
        } else {
          // Manejo de errores al enviar a la API
          setState(() {
            errorMessage = 'Error al enviar el correo a la API';
          });
        }
    } catch (e) {
      setState(() {
        errorMessage = 'Error al iniciar sesión con Google: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void toMainPage() async {
    Get.offNamed('/');
  }

  void toGoogle() async {
    Get.offNamed('/google');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Nombre de usuario'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Contraseña'),
            ),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: logIn,
                    child: Text(
                      'Iniciar Sesión',
                      style: TextStyle(color: Colors.white), // Texto blanco
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFB04D47), // Fondo rosa-rojo
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Bordes redondeados
                      ),
                    ),
                  ),
            ElevatedButton(
              onPressed: toMainPage,
              child: Text(
                'Volver a la página principal',
                style: TextStyle(color: Colors.white), // Texto blanco
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFB04D47), // Fondo rosa-rojo
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Bordes redondeados
                ),
              ),
            ),
            ElevatedButton(
              onPressed: toGoogle,
              child: Text(
                'Iniciar sesión con Google',
                style: TextStyle(color: Colors.white), // Texto blanco
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFB04D47), // Fondo rosa-rojo
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Bordes redondeados
                ),
              ),
            ),
            // Aquí el FutureBuilder
          ],
        ),
      ),
    );
  }
}


