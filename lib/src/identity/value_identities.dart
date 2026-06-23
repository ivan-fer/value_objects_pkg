import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import 'package:value_objects_pkg/src/core/value_failure.dart';
import 'package:value_objects_pkg/src/core/value_object.dart';
import 'package:value_objects_pkg/src/text/value_text.dart';

/// Value Object para identificadores únicos (UUID por defecto).
class UniqueId extends ValueObject<String> {
  @override
  final Either<ValueFailure, String> value;

  @override
  final CustomValidate<String>? customValidate;

  factory UniqueId() => UniqueId._(right(const Uuid().v4()));

  factory UniqueId.fromUniqueString(
    String uniqueId, {
    CustomValidate<String>? customValidate,
  }) => UniqueId._(validateUniqueId(uniqueId), customValidate: customValidate);

  const UniqueId._(this.value, {this.customValidate});

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
  factory ValueName(String input, {CustomValidate<String>? customValidate}) {
    return ValueName._(
      _validatePersonalName(input),
      customValidate: customValidate,
    );
  }

  const ValueName._(super.value, {super.customValidate});
}

/// Gestiona apellidos de personas. Usa la misma lógica que [ValueName].
class ValueLastName extends ValueText {
  factory ValueLastName(
    String input, {
    CustomValidate<String>? customValidate,
  }) {
    return ValueLastName._(
      _validatePersonalName(input),
      customValidate: customValidate,
    );
  }

  const ValueLastName._(super.value, {super.customValidate});
}

/// Valida direcciones de correo electrónico mediante expresiones regulares.
class ValueEmailAddress extends ValueText {
  factory ValueEmailAddress(
    String input, {
    CustomValidate<String>? customValidate,
  }) {
    return ValueEmailAddress._(
      _validateEmail(input),
      customValidate: customValidate,
    );
  }

  const ValueEmailAddress._(super.value, {super.customValidate});

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
  factory ValuePassword(
    String input, {
    CustomValidate<String>? customValidate,
  }) {
    return ValuePassword._(
      _validatePassword(input),
      customValidate: customValidate,
    );
  }

  const ValuePassword._(super.value, {super.customValidate});
}

/// Valida que una contraseña de confirmación coincida exactamente con la original.
class ValuePasswordConfirm extends ValueText {
  factory ValuePasswordConfirm(
    String input,
    String original, {
    CustomValidate<String>? customValidate,
  }) {
    if (input != original) {
      return ValuePasswordConfirm._(
        left(const ValueFailure.invalid(message: 'Passwords do not match')),
        customValidate: customValidate,
      );
    }
    return ValuePasswordConfirm._(right(input), customValidate: customValidate);
  }

  const ValuePasswordConfirm._(super.value, {super.customValidate});
}

/// Valida un número de teléfono con formato internacional básico.
class ValuePhoneNumber extends ValueText {
  factory ValuePhoneNumber(
    String input, {
    CustomValidate<String>? customValidate,
  }) {
    return ValuePhoneNumber._(
      _validatePhoneNumber(input),
      customValidate: customValidate,
    );
  }

  const ValuePhoneNumber._(super.value, {super.customValidate});
}

// ---------------------------------------------------------------------------
// Versiones Opcionales
// ---------------------------------------------------------------------------

class ValueOptionName extends ValueOptionText {
  factory ValueOptionName(
    String? input, {
    CustomValidate<Option<String>>? customValidate,
  }) {
    return ValueOptionName._(
      ValueOptionText.validator(input, (s) => ValueName(s)),
      customValidate: customValidate,
    );
  }
  const ValueOptionName._(super.value, {super.customValidate});
}

class ValueOptionLastName extends ValueOptionText {
  factory ValueOptionLastName(
    String? input, {
    CustomValidate<Option<String>>? customValidate,
  }) {
    return ValueOptionLastName._(
      ValueOptionText.validator(input, (s) => ValueLastName(s)),
      customValidate: customValidate,
    );
  }
  const ValueOptionLastName._(super.value, {super.customValidate});
}

class ValueOptionEmailAddress extends ValueOptionText {
  factory ValueOptionEmailAddress(
    String? input, {
    CustomValidate<Option<String>>? customValidate,
  }) {
    return ValueOptionEmailAddress._(
      ValueOptionText.validator(input, (s) => ValueEmailAddress(s)),
      customValidate: customValidate,
    );
  }
  const ValueOptionEmailAddress._(super.value, {super.customValidate});
}

class ValueOptionPhoneNumber extends ValueOptionText {
  factory ValueOptionPhoneNumber(
    String? input, {
    CustomValidate<Option<String>>? customValidate,
  }) {
    return ValueOptionPhoneNumber._(
      ValueOptionText.validator(input, (s) => ValuePhoneNumber(s)),
      customValidate: customValidate,
    );
  }
  const ValueOptionPhoneNumber._(super.value, {super.customValidate});
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

/// Valida números de teléfono (acepta '+' opcional al inicio, seguido de 7 a 15 dígitos).
Either<ValueFailure, String> _validatePhoneNumber(String input) {
  final phoneRegex = RegExp(r"^\+?[0-9]{7,15}$");
  final trimmed = input.trim().replaceAll(
    ' ',
    '',
  ); // quitamos espacios visuales
  if (!phoneRegex.hasMatch(trimmed)) {
    return left(
      const ValueFailure.strInvalidChars(
        nameObject: 'Phone Number',
        message: 'Invalid phone format',
      ),
    );
  }
  return right(trimmed);
}
