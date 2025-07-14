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
      backgroundColor: const Color(0xFFF5F8FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1976D2),
        elevation: 0,
        title: const Text('Cambiar Contraseña',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Encabezado con icono médico
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: const Icon(Icons.medical_services_rounded,
                          size: 48, color: Color(0xFF1976D2)),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Actualiza tu contraseña',
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1976D2)),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Por seguridad, utiliza una contraseña robusta y única.',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // Antigua contraseña
                _PasswordField(
                  label: 'Antigua Contraseña',
                  onChanged: ref
                      .read(formChangePasswordProvider.notifier)
                      .onOldPasswordChanged,
                  errorText: formChangePassword.isFormPosted
                      ? formChangePassword.oldPassword.errorMessage
                      : null,
                  isVisible: formChangePassword.oldPasswordVisible,
                  onVisibilityToggle: ref
                      .read(formChangePasswordProvider.notifier)
                      .onOldPasswordVisibilityChanged,
                ),
                const SizedBox(height: 20),
                // Nueva contraseña
                _PasswordField(
                  label: 'Nueva Contraseña',
                  onChanged: ref
                      .read(formChangePasswordProvider.notifier)
                      .onNewPasswordChanged,
                  errorText: formChangePassword.isFormPosted
                      ? formChangePassword.newPassword.errorMessage
                      : null,
                  isVisible: formChangePassword.newPasswordVisible,
                  onVisibilityToggle: ref
                      .read(formChangePasswordProvider.notifier)
                      .onNewPasswordVisibilityChanged,
                ),
                const SizedBox(height: 20),
                // Confirmar contraseña
                _PasswordField(
                  label: 'Confirmar Contraseña',
                  onChanged: ref
                      .read(formChangePasswordProvider.notifier)
                      .onConfirmPasswordChanged,
                  errorText: formChangePassword.isFormPosted
                      ? (formChangePassword.errorMessage ??
                          formChangePassword.confirmPassword.errorMessage)
                      : null,
                  isVisible: formChangePassword.confirmPasswordVisible,
                  onVisibilityToggle: ref
                      .read(formChangePasswordProvider.notifier)
                      .onConfirmPasswordVisibilityChanged,
                ),
                const SizedBox(height: 8),
                // Ayuda sobre requisitos de contraseña
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'La nueva contraseña debe tener al menos 12 caracteres, incluir mayúsculas, minúsculas, números y un carácter especial.',
                    style: TextStyle(fontSize: 14, color: Color(0xFF1976D2)),
                  ),
                ),
                const SizedBox(height: 12),
                // Botón de cambiar contraseña
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: auth.isLoading
                        ? null
                        : () {
                            ref
                                .read(formChangePasswordProvider.notifier)
                                .onFormSubmit();
                          },
                    icon: auth.isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : const Icon(Icons.lock_reset, color: Colors.white),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        'Cambiar Contraseña',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1976D2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget reutilizable para campos de contraseña
class _PasswordField extends StatelessWidget {
  final String label;
  final void Function(String) onChanged;
  final String? errorText;
  final bool isVisible;
  final VoidCallback onVisibilityToggle;

  const _PasswordField({
    required this.label,
    required this.onChanged,
    required this.errorText,
    required this.isVisible,
    required this.onVisibilityToggle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      obscureText: !isVisible,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF1976D2)),
        prefixIcon: const Icon(Icons.lock, color: Color(0xFF1976D2)),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: const Color(0xFF1976D2),
          ),
          onPressed: onVisibilityToggle,
        ),
        errorText: errorText,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF1976D2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF1976D2), width: 2),
        ),
      ),
      style: const TextStyle(color: Colors.black87, fontSize: 16),
    );
  }
}
