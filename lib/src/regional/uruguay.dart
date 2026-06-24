import 'package:fpdart/fpdart.dart';

import 'package:value_objects_pkg/src/core/value_failure.dart';
import 'package:value_objects_pkg/src/core/value_object.dart';
import 'package:value_objects_pkg/src/text/value_text.dart';

// ---------------------------------------------------------------------------
// Value Objects específicos de Uruguay
// ---------------------------------------------------------------------------

/// Valida una cédula de identidad uruguaya verificando su dígito de control.
///
/// Acepta el número con o sin puntos/guiones (por ejemplo `1.234.567-2` o
/// `12345672`). El valor almacenado siempre son solo los dígitos, normalizado
/// a 8 caracteres con ceros a la izquierda.
class ValueCedula extends ValueText {
  factory ValueCedula(String input, {CustomValidate<String>? customValidate}) {
    return ValueCedula._(
      _validateCedula(input),
      customValidate: customValidate,
    );
  }

  const ValueCedula._(super.value, {super.customValidate});
}

/// Valida un RUT (Registro Único Tributario) uruguayo de la DGI.
///
/// Acepta el número con o sin puntos/guiones. Debe tener 12 dígitos e incluir
/// un dígito verificador válido. El valor almacenado son solo los dígitos.
class ValueRut extends ValueText {
  factory ValueRut(String input, {CustomValidate<String>? customValidate}) {
    return ValueRut._(_validateRut(input), customValidate: customValidate);
  }

  const ValueRut._(super.value, {super.customValidate});
}

// ---------------------------------------------------------------------------
// Versiones Opcionales
// ---------------------------------------------------------------------------

class ValueOptionCedula extends ValueOptionText {
  factory ValueOptionCedula(
    String? input, {
    CustomValidate<Option<String>>? customValidate,
  }) {
    return ValueOptionCedula._(
      ValueOptionText.validator(input, (s) => ValueCedula(s)),
      customValidate: customValidate,
    );
  }
  const ValueOptionCedula._(super.value, {super.customValidate});
}

class ValueOptionRut extends ValueOptionText {
  factory ValueOptionRut(
    String? input, {
    CustomValidate<Option<String>>? customValidate,
  }) {
    return ValueOptionRut._(
      ValueOptionText.validator(input, (s) => ValueRut(s)),
      customValidate: customValidate,
    );
  }
  const ValueOptionRut._(super.value, {super.customValidate});
}

// ---------------------------------------------------------------------------
// Funciones de Validación Privadas
// ---------------------------------------------------------------------------

/// Valida una cédula de identidad uruguaya.
///
/// Limpia separadores comunes (puntos, guiones y espacios), comprueba que el
/// resto sean únicamente dígitos con una longitud razonable (7 u 8) y verifica
/// el dígito de control mediante el algoritmo oficial. Devuelve la cédula
/// normalizada a 8 dígitos con ceros a la izquierda.
Either<ValueFailure, String> _validateCedula(String input) {
  if (input.trim().isEmpty) {
    return left(const ValueFailure.strEmpty(nameObject: 'Cédula'));
  }

  // Quitamos separadores visuales habituales: puntos, guiones y espacios.
  final digits = input.replaceAll(RegExp(r'[.\-\s]'), '');

  if (digits.contains(RegExp(r'[^0-9]'))) {
    return left(
      const ValueFailure.strInvalidChars(
        nameObject: 'Cédula',
        message: 'La cédula solo puede contener dígitos',
      ),
    );
  }

  // Una cédula uruguaya tiene 7 u 8 dígitos (incluyendo el verificador).
  if (digits.length < 7 || digits.length > 8) {
    return left(
      ValueFailure.strOutRange(
        nameObject: 'Cédula',
        min: 7,
        max: 8,
        message: 'La cédula debe tener 7 u 8 dígitos',
      ),
    );
  }

  // Normalizamos a 8 dígitos para separar cuerpo y dígito verificador.
  final normalized = digits.padLeft(8, '0');
  final body = normalized.substring(0, 7);
  final checkDigit = int.parse(normalized.substring(7));

  if (_cedulaCheckDigit(body) != checkDigit) {
    return left(
      const ValueFailure.invalid(
        nameObject: 'Cédula',
        message: 'El dígito verificador de la cédula no es válido',
      ),
    );
  }

  return right(normalized);
}

/// Calcula el dígito verificador de una cédula uruguaya a partir de sus
/// 7 dígitos de cuerpo, usando los pesos oficiales `2 9 8 7 6 3 4`.
int _cedulaCheckDigit(String body) {
  const weights = [2, 9, 8, 7, 6, 3, 4];
  var sum = 0;
  for (var i = 0; i < 7; i++) {
    sum += (weights[i] * int.parse(body[i])) % 10;
  }
  final remainder = sum % 10;
  return remainder == 0 ? 0 : 10 - remainder;
}

/// Valida un RUT uruguayo (DGI).
///
/// Limpia separadores comunes, comprueba que sean exactamente 12 dígitos y
/// verifica el dígito de control con los pesos oficiales y módulo 11.
Either<ValueFailure, String> _validateRut(String input) {
  if (input.trim().isEmpty) {
    return left(const ValueFailure.strEmpty(nameObject: 'RUT'));
  }

  final digits = input.replaceAll(RegExp(r'[.\-\s]'), '');

  if (digits.contains(RegExp(r'[^0-9]'))) {
    return left(
      const ValueFailure.strInvalidChars(
        nameObject: 'RUT',
        message: 'El RUT solo puede contener dígitos',
      ),
    );
  }

  // El RUT uruguayo tiene exactamente 12 dígitos (incluyendo el verificador).
  if (digits.length != 12) {
    return left(
      const ValueFailure.strInvalidChars(
        nameObject: 'RUT',
        message: 'El RUT debe tener 12 dígitos',
      ),
    );
  }

  final body = digits.substring(0, 11);
  final checkDigit = int.parse(digits.substring(11));

  if (_rutCheckDigit(body) != checkDigit) {
    return left(
      const ValueFailure.invalid(
        nameObject: 'RUT',
        message: 'El dígito verificador del RUT no es válido',
      ),
    );
  }

  return right(digits);
}

/// Calcula el dígito verificador de un RUT uruguayo a partir de sus 11 dígitos
/// de cuerpo, usando los pesos `4 3 2 9 8 7 6 5 4 3 2` y módulo 11.
int _rutCheckDigit(String body) {
  const weights = [4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
  var sum = 0;
  for (var i = 0; i < 11; i++) {
    sum += weights[i] * int.parse(body[i]);
  }
  final dv = 11 - (sum % 11);
  if (dv == 11) return 0;
  return dv;
}
