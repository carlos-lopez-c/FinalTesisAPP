import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/auth/presentation/providers/auth_provider.dart';
import 'package:h_c_1/auth/presentation/providers/two_factor_provider.dart';
import '/shared/header.dart';
import 'package:go_router/go_router.dart';

class TwoFactorScreen extends ConsumerWidget {
  const TwoFactorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final twoFactorState = ref.watch(twoFactorProvider);
    final twoFactorNotifier = ref.read(twoFactorProvider.notifier);
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
      if (next.authStatus == AuthStatus.authenticated) {
        context.go('/');
      }
    });
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FF),
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
                    Header(
                      imagePath: 'assets/imagenes/san-miguel.png',
                      title: 'Fundación de niños especiales',
                      subtitle: '"SAN MIGUEL" FUNESAMI',
                      item: 'Verificación de Dos Factores',
                    ),
                    const SizedBox(height: 32),

                    const Text(
                      'Hemos enviado un código de verificación a su número de teléfono',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '****${twoFactorState.phoneNumber.substring(twoFactorState.phoneNumber.length - 4)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Campo de código de verificación
                    TextField(
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      onChanged: twoFactorNotifier.onCodeChanged,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Código de Verificación',
                        labelStyle: const TextStyle(color: Color(0xFF1976D2)),
                        hintText: '123456',
                        prefixIcon: const Icon(Icons.security,
                            color: Color(0xFF1976D2)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Color(0xFF1976D2)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Color(0xFF1976D2), width: 2),
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 24,
                        letterSpacing: 8,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Contador de reenvío
                    if (twoFactorState.canResend)
                      TextButton(
                        onPressed: twoFactorNotifier.resendCode,
                        child: const Text(
                          'Reenviar código',
                          style: TextStyle(
                            color: Color(0xFF1976D2),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    else
                      Text(
                        'Puede solicitar un nuevo código en ${twoFactorState.resendCountdown} segundos',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),

                    const SizedBox(height: 32),

                    // Botón de verificación
                    ElevatedButton(
                      onPressed: twoFactorState.isLoading
                          ? null
                          : () async {
                              await twoFactorNotifier.verifyCode();
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1976D2),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                      child: twoFactorState.isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Verificar Código',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
