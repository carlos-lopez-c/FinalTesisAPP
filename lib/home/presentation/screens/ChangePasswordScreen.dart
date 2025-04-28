import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/auth/presentation/providers/auth_provider.dart';
import 'package:h_c_1/home/presentation/providers/change_password_provier.dart';

class Changepasswordscreen extends ConsumerWidget {
  const Changepasswordscreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formChangePassword = ref.watch(formChangePasswordProvider);
    final auth = ref.watch(authProvider);
    ref.listen<AuthState?>(authProvider, (previous, next) {
      if (next!.successMessage.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.successMessage),
            backgroundColor: Colors.green.shade300,
            behavior: SnackBarBehavior.fixed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
        Future.delayed(const Duration(seconds: 2), () {
          ref.read(authProvider.notifier).clearSuccess();
        });
      } else if (next.errorMessage.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage),
            backgroundColor: Colors.red.shade300,
            behavior: SnackBarBehavior.fixed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            duration: const Duration(seconds: 2),
          ),
        );

        Future.delayed(const Duration(seconds: 2), () {
          ref.read(authProvider.notifier).clearError();
        });
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cambiar Contraseña'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Cambiar contraseña',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0, left: 20, right: 20),
              child: TextFormField(
                onChanged: ref
                    .read(formChangePasswordProvider.notifier)
                    .onOldPasswordChanged,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                  ),
                  errorStyle: const TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    height: 1.5,
                    overflow: TextOverflow.visible,
                  ),
                  errorMaxLines: 3,
                  errorText: formChangePassword.isFormPosted
                      ? formChangePassword.oldPassword.errorMessage
                      : null,
                  labelText: 'Antigua Contraseña',
                  labelStyle: const TextStyle(color: Color(0xFF1976D2)),
                  prefixIcon: const Icon(Icons.lock, color: Color(0xFF1976D2)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF1976D2)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Color(0xFF1976D2), width: 2),
                  ),
                ),
                style: const TextStyle(color: Colors.black87),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese su contraseña.';
                  } else if (value.length < 12) {
                    return 'La contraseña debe tener al menos 12 caracteres.';
                  } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
                    return 'La contraseña debe contener al menos una letra mayúscula.';
                  } else if (!RegExp(r'[a-z]').hasMatch(value)) {
                    return 'La contraseña debe contener al menos una letra minúscula.';
                  } else if (!RegExp(r'\d').hasMatch(value)) {
                    return 'La contraseña debe contener al menos un número.';
                  } else if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]')
                      .hasMatch(value)) {
                    return 'La contraseña debe contener al menos un carácter especial.';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0, left: 20, right: 20),
              child: TextFormField(
                onChanged: ref
                    .read(formChangePasswordProvider.notifier)
                    .onNewPasswordChanged,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                  ),
                  errorStyle: const TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    height: 1.5,
                    overflow: TextOverflow.visible,
                  ),
                  errorMaxLines: 3,
                  errorText: formChangePassword.isFormPosted
                      ? formChangePassword.newPassword.errorMessage
                      : null,
                  labelText: 'Nueva Contraseña',
                  labelStyle: const TextStyle(color: Color(0xFF1976D2)),
                  prefixIcon: const Icon(Icons.lock, color: Color(0xFF1976D2)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF1976D2)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Color(0xFF1976D2), width: 2),
                  ),
                ),
                style: const TextStyle(color: Colors.black87),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese su contraseña.';
                  } else if (value.length < 12) {
                    return 'La contraseña debe tener al menos 12 caracteres.';
                  } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
                    return 'La contraseña debe contener al menos una letra mayúscula.';
                  } else if (!RegExp(r'[a-z]').hasMatch(value)) {
                    return 'La contraseña debe contener al menos una letra minúscula.';
                  } else if (!RegExp(r'\d').hasMatch(value)) {
                    return 'La contraseña debe contener al menos un número.';
                  } else if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]')
                      .hasMatch(value)) {
                    return 'La contraseña debe contener al menos un carácter especial.';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Acción al presionar el botón
                ref.read(formChangePasswordProvider.notifier).onFormSubmit();
              },
              // Colocar Cambiando si el estado isLoading de authprovider es true
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: auth.isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text(
                      'Cambiar Contraseña',
                      style: TextStyle(fontSize: 20),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
