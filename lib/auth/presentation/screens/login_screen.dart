import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/auth/presentation/providers/auth_provider.dart';
import '/shared/header.dart';
import '../widgets/login_form.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.errorMessage.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage),
            backgroundColor: Colors.red.shade300,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    });
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FF), // Fondo azul muy claro
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white,
                      const Color(0xFFE8F4FF),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
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
                    const SizedBox(height: 32),

                    // Formulario de inicio de sesión
                    LoginForm(),

                    const SizedBox(height: 24),

                    // Enlaces de acción
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            context.push('/forgot-password');
                          },
                          icon: const Icon(Icons.lock_reset,
                              color: Color(0xFF1976D2)),
                          label: const Text(
                            '¿Olvidaste tu contraseña?',
                            style: TextStyle(
                              color: Color(0xFF1976D2),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
