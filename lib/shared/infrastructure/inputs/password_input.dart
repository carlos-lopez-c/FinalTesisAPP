import 'package:formz/formz.dart';

enum PasswordError { empty, length, format, mismatch }

class Password extends FormzInput<String, PasswordError> {
  static final RegExp passwordRegExp = RegExp(
    r'(?:(?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$',
  );

  const Password.pure() : super.pure('');

  const Password.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == PasswordError.empty) return 'El campo es requerido';
    if (displayError == PasswordError.length) return 'Mínimo 12 caracteres';
    if (displayError == PasswordError.format) {
      return 'Debe de tener Mayúscula, letras, un número y un caracter especial';
    }
    if (displayError == PasswordError.mismatch) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  @override
  PasswordError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return PasswordError.empty;
    if (value.length < 11) return PasswordError.length;
    // if (!passwordRegExp.hasMatch(value)) return PasswordError.format;

    return null;
  }
}
