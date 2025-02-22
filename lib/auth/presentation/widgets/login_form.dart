import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/auth/presentation/providers/login_provider.dart';

class LoginForm extends ConsumerWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(formularioProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Campo de correo electrónico
            TextFormField(
              onChanged: ref.read(formularioProvider.notifier).onEmailChanged,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                errorStyle: const TextStyle(color: Colors.red),
                errorText: loginForm.isFormPosted
                    ? loginForm.email.errorMessage
                    : null,
                labelText: 'Correo Electrónico',
                labelStyle: const TextStyle(color: Colors.lightBlue),
                hintText: 'ejemplo@gmail.com o ejemplo@outlook.com',
                prefixIcon: const Icon(Icons.email, color: Colors.lightBlue),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlue),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlue, width: 2.0),
                ),
              ),
              style: const TextStyle(color: Colors.black),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese su correo electrónico.';
                }

                final RegExp regex = RegExp(r'^[a-zA-Z0-9._%+-]+@');
                if (!regex.hasMatch(value)) {
                  return 'El correo no cumple con el formato correcto';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Campo de contraseña
            TextFormField(
              onChanged: ref.read(formularioProvider.notifier).onPasswordChanged,
              decoration: InputDecoration(
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                errorText: loginForm.isFormPosted
                    ? loginForm.password.errorMessage
                    : null,
                labelText: 'Contraseña',
                labelStyle: const TextStyle(color: Colors.lightBlue),
                prefixIcon: const Icon(Icons.lock, color: Colors.lightBlue),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlue),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlue, width: 2.0),
                ),
              ),
              style: const TextStyle(color: Colors.black),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese su contraseña.';
                } else if (value.length < 10) {
                  return 'La contraseña debe tener al menos 10 caracteres.';
                }
                return null;
              },
              obscureText: true,
            ),
            const SizedBox(height: 16),

            // Botón de iniciar sesión
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(30),
                  child: OutlinedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        ref.read(formularioProvider.notifier).onFormSubmit();

                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Éxito'),
                              content: Text('Inicio de sesión exitoso.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Aceptar'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Por favor, corrija los errores.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          color: const Color.fromARGB(255, 141, 183, 203),
                          width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      foregroundColor: const Color.fromARGB(255, 4, 71, 103),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                    ),
                    child: const Text('Iniciar Sesión'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
