import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/auth/presentation/providers/login_provider.dart';

class LoginForm extends ConsumerWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(formularioProvider);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Campo de correo electrónico
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: TextFormField(
              onChanged: ref.read(formularioProvider.notifier).onEmailChanged,
              keyboardType: TextInputType.emailAddress,
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
                errorText: loginForm.isFormPosted
                    ? loginForm.email.errorMessage
                    : null,
                labelText: 'Correo Electrónico',
                labelStyle: const TextStyle(color: Color(0xFF1976D2)),
                hintText: 'ejemplo@gmail.com',
                prefixIcon: const Icon(Icons.email, color: Color(0xFF1976D2)),
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
                  return 'Por favor, ingrese su correo electrónico.';
                }
                final RegExp regex = RegExp(r'^[a-zA-Z0-9._%+-]+@');
                if (!regex.hasMatch(value)) {
                  return 'El correo no cumple con el formato correcto.';
                }
                return null;
              },
            ),
          ),

          // Campo de contraseña
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: TextFormField(
              onChanged:
                  ref.read(formularioProvider.notifier).onPasswordChanged,
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
                errorText: loginForm.isFormPosted
                    ? loginForm.password.errorMessage
                    : null,
                labelText: 'Contraseña',
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

          // Botón de iniciar sesión
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
                try {
                  await ref.read(formularioProvider.notifier).onFormSubmit();
                } catch (e) {
                  print("Error: $e");
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Por favor, corrija los errores.'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1976D2),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
            ),
            child: loginForm.isPosting
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    'Iniciar Sesión',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
