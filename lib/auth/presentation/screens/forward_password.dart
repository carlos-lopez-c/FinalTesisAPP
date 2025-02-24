import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h_c_1/auth/presentation/providers/password_reset_provider.dart';
import '../Widgets/CustomCard.dart';
import '/../shared/header.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forgotPasswordNotifier = ref.watch(passwordResetProvider.notifier);
    final forgotPasswordState = ref.watch(passwordResetProvider);
    return CustomCard(
      child: Column(
        children: [
          Header(
            imagePath: 'assets/imagenes/san-miguel.png',
            title: 'Fundación de niños especiales',
            subtitle: '"SAN MIGUEL" FUNESAMI',
            item: 'Recuperar Contraseña',
          ),

          TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: forgotPasswordNotifier.onEmailChanged,
            decoration: InputDecoration(
              labelText: 'Correo Electrónico',
              labelStyle:
                  const TextStyle(color: Colors.lightBlue), // Etiqueta celeste
              hintText: 'ejemplo@correo.com',
              prefixIcon: const Icon(Icons.email,
                  color: Colors.lightBlue), // Ícono celeste
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.lightBlue), // Línea inferior celeste
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.lightBlue,
                    width: 2.0), // Línea más gruesa al enfocar
              ),
              border: InputBorder.none, // Elimina el borde predeterminado
            ),
            style: const TextStyle(
                color: Colors.black), // Texto ingresado de color negro
          ),

          const SizedBox(height: 16),

          // Botón para enviar correo
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Botón de recuperar contraseña con estilo personalizado
              Material(
                elevation: 2, // Controla la intensidad de la sombra
                borderRadius: BorderRadius.circular(30), // Bordes redondeados
                child: ElevatedButton(
                  onPressed: () {
                    forgotPasswordNotifier.sendCode();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 4, 71, 103),
                    backgroundColor: Colors.white, // Color del texto (morado)
                    side: BorderSide(
                      color: const Color.fromARGB(255, 141, 183, 203),
                      width: 1.5, // Borde color azul
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30), // Bordes redondeados
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15, // Tamaño interno del botón
                    ),
                  ),
                  child: const Text('Recuperar Contraseña'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
