import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import 'package:value_objects_pkg/src/core/value_failure.dart';
import 'package:value_objects_pkg/src/core/value_object.dart';
import 'package:value_objects_pkg/src/text/value_text.dart';

/// Value Object para identificadores únicos (UUID por defecto).
class UniqueId extends ValueObject<String> {
  @override
  final Either<ValueFailure, String> value;

  factory UniqueId() => UniqueId._(right(const Uuid().v4()));

  factory UniqueId.fromUniqueString(String uniqueId) =>
      UniqueId._(validateUniqueId(uniqueId));

  const UniqueId._(this.value);

  @override
  String? validate() => value.failureMessage;

  static Either<ValueFailure, String> validateUniqueId(String input) {
    if (input.isEmpty) {
      return left(const ValueFailure.strEmpty());
    }
    return right(input);
  }
}

// ---------------------------------------------------------------------------
// Identidades de Usuario
// ---------------------------------------------------------------------------

/// Gestiona nombres de personas. Valida caracteres alfabéticos y acentos.
class ValueName extends ValueText {
  factory ValueName(String input) {
    return ValueName._(_validatePersonalName(input));
  }

  const ValueName._(super.value);
}

/// Gestiona apellidos de personas. Usa la misma lógica que [ValueName].
class ValueLastName extends ValueText {
  factory ValueLastName(String input) {
    return ValueLastName._(_validatePersonalName(input));
  }

  const ValueLastName._(super.value);
}

/// Valida direcciones de correo electrónico mediante expresiones regulares.
class ValueEmailAddress extends ValueText {
  factory ValueEmailAddress(String input) {
    return ValueEmailAddress._(_validateEmail(input));
  }

  const ValueEmailAddress._(super.value);

  static Either<ValueFailure, String> _validateEmail(String input) {
    const emailRegex =
        r"""^[a-zA-Z0-9.!*+\-/=?^_`{|}~]+@[a-zA-Z0-9]+(?:\.[a-zA-Z0-9]+)*\.[a-zA-Z]{2,}$""";
    if (RegExp(emailRegex).hasMatch(input)) {
      return right(input);
    } else {
      return left(
        const ValueFailure.strInvalidChars(message: 'Invalid email format'),
      );
    }
  }
}

/// Gestiona contraseñas con validación de complejidad:
/// - Mínimo 8 caracteres.
/// - Al menos una mayúscula, una minúscula, un número y un carácter especial.
class ValuePassword extends ValueText {
  factory ValuePassword(String input) {
    return ValuePassword._(_validatePassword(input));
  }

  const ValuePassword._(super.value);
}

/// Valida que una contraseña de confirmación coincida exactamente con la original.
class ValuePasswordConfirm extends ValueText {
  factory ValuePasswordConfirm(String input, String original) {
    if (input != original) {
      return ValuePasswordConfirm._(
        left(const ValueFailure.invalid(message: 'Passwords do not match')),
      );
    }
    return ValuePasswordConfirm._(right(input));
  }

  const ValuePasswordConfirm._(super.value);
}

// ---------------------------------------------------------------------------
// Versiones Opcionales
// ---------------------------------------------------------------------------

class ValueOptionName extends ValueOptionText {
  factory ValueOptionName(String? input) {
    return ValueOptionName._(
      ValueOptionText.validator(input, (s) => ValueName(s)),
    );
  }
  const ValueOptionName._(super.value);
}

class ValueOptionLastName extends ValueOptionText {
  factory ValueOptionLastName(String? input) {
    return ValueOptionLastName._(
      ValueOptionText.validator(input, (s) => ValueLastName(s)),
    );
  }
  const ValueOptionLastName._(super.value);
}

class ValueOptionEmailAddress extends ValueOptionText {
  factory ValueOptionEmailAddress(String? input) {
    return ValueOptionEmailAddress._(
      ValueOptionText.validator(input, (s) => ValueEmailAddress(s)),
    );
  }
  const ValueOptionEmailAddress._(super.value);
}

// ---------------------------------------------------------------------------
// Funciones de Validación Privadas
// ---------------------------------------------------------------------------

/// Valida nombres personales: solo letras, acentos, espacios y guiones.
/// Rechaza strings vacíos o que solo contienen espacios.
Either<ValueFailure, String> _validatePersonalName(String input) {
  // Rechaza si está vacío o solo espacios
  if (input.isEmpty || input.trim().isEmpty) {
    return left(const ValueFailure.strEmpty());
  }

  // Usa la validación de value_text.dart
  return validatePersonalName(input);
}

/// Valida contraseñas con requisitos de complejidad (8-64 caracteres).
Either<ValueFailure, String> _validatePassword(String input) {
  // Rechaza si está fuera del rango 8-64
  if (input.length < 8 || input.length > 64) {
    return left(
      ValueFailure.strOutRange(
        min: 8,
        max: 64,
        message: 'Password must be between 8 and 64 characters',
      ),
    );
  }

  // Usa la validación de value_text.dart
  return validatePassword(input);
}
