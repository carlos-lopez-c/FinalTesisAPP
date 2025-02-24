import 'package:flutter/material.dart';
import '/shared/header.dart';
import '../widgets/login_form.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 197, 197, 197), // Fondo claro
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header del formulario
                  Header(
                    imagePath: 'assets/imagenes/san-miguel.png',
                    title: 'Fundación de niños especiales',
                    subtitle: '"SAN MIGUEL" FUNESAMI',
                    item: '"Gestión de historias clínicas"',
                  ),
                  const SizedBox(height: 20),

                  // Formulario de inicio de sesión
                  LoginForm(),

                  const SizedBox(height: 16),

                  // Enlaces de acción: ¿Olvidaste tu contraseña? y Registrarse
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Navega hacia la pantalla de recuperación de contraseña
                          context.push('/forgot-password');
                        },
                        child: const Text('¿Olvidaste tu contraseña?'),
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
