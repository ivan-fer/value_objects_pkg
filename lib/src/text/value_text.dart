import 'package:fpdart/fpdart.dart';
import 'package:value_objects_pkg/src/core/value_failure.dart';
import 'package:value_objects_pkg/src/core/value_object.dart';

// ---------------------------------------------------------------------------
// Validation Functions
// ---------------------------------------------------------------------------

/// Valida que el texto no esté vacío. Además recorta espacios en blanco.
Either<ValueFailure, String> validateNotEmpty(String input) {
  final trimmed = input.trim();
  if (trimmed.isEmpty) {
    return left(const ValueFailure.strEmpty());
  }
  return right(trimmed);
}

/// Valida la longitud máxima del texto.
Either<ValueFailure, String> validateMaxLength(String input, int max) {
  if (input.length > max) {
    return left(ValueFailure.strMaxLength(maxAllow: max, total: input.length));
  }
  return right(input);
}

/// Valida que el texto no contenga saltos de línea.
Either<ValueFailure, String> validateSingleLine(String input) {
  if (input.contains('\n')) {
    return left(const ValueFailure.strMultiline());
  }
  return right(input);
}

/// Valida que el texto sea un formato URL absoluto o un path local válido.
Either<ValueFailure, Uri> validateUrlFormat(String input) {
  if (input.startsWith('assets/') || input.startsWith('packages/')) {
    return right(Uri(path: input));
  }

  final uri = Uri.tryParse(input);
  if (uri == null) {
    return left(
      const ValueFailure.strInvalidChars(
        nameObject: 'URL',
        message: 'The URL format is not valid.',
      ),
    );
  }

  if (uri.isAbsolute && (uri.scheme == 'http' || uri.scheme == 'https')) {
    return right(uri);
  }

  return left(
    const ValueFailure.strInvalidChars(
      nameObject: 'URL',
      message: 'The URL must be a valid http(s) URL or a local asset path.',
    ),
  );
}

/// Valida la longitud mínima del texto.
Either<ValueFailure, String> validateMinLength(String input, int min) {
  if (input.length < min) {
    return left(ValueFailure.strMinLength(minAllow: min, total: input.length));
  }
  return right(input);
}

/// Valida que el texto solo contenga caracteres alfabéticos.
Either<ValueFailure, String> validateOnlyAlphabetical(String input) {
  if (input.contains(RegExp(r'[^a-zA-Z]'))) {
    return left(const ValueFailure.invalid());
  }
  return right(input);
}

/// Valida si un texto contiene una subcadena específica.
Either<ValueFailure, String> validateContainsSubstring(
  String input,
  String substring, {
  bool caseSensitive = false,
}) {
  final isValid = caseSensitive
      ? input.contains(substring)
      : input.toLowerCase().contains(substring.toLowerCase());
  if (!isValid) return left(const ValueFailure.strNotContains());
  return right(input);
}

/// Valida si un texto comienza con un prefijo específico.
Either<ValueFailure, String> validateStartsWith(
  String input,
  String prefix, {
  bool caseSensitive = false,
}) {
  final isValid = caseSensitive
      ? input.startsWith(prefix)
      : input.toLowerCase().startsWith(prefix.toLowerCase());
  if (!isValid) return left(const ValueFailure.strNotStartsWith());
  return right(input);
}

/// Valida que el texto sea un nombre personal válido.
Either<ValueFailure, String> validatePersonalName(String input) {
  final nameRegex = RegExp(r"^[a-zA-ZÀ-ÿ\s'-]+$");
  if (!nameRegex.hasMatch(input)) {
    return left(
      const ValueFailure.strInvalidChars(nameObject: 'Personal Name'),
    );
  }
  return validateSingleLine(input);
}

/// Valida la complejidad de una contraseña.
Either<ValueFailure, String> validatePassword(String input) {
  const minLength = 8;
  const maxLength = 64;

  if (input.length < minLength || input.length > maxLength) {
    return left(
      ValueFailure.strOutRange(
        nameObject: 'Password',
        min: minLength,
        max: maxLength,
      ),
    );
  }
  if (!input.contains(RegExp(r'[A-Z]'))) {
    return left(
      const ValueFailure.strInvalidChars(
        message: 'Must contain at least one uppercase letter.',
      ),
    );
  }
  if (!input.contains(RegExp(r'[a-z]'))) {
    return left(
      const ValueFailure.strInvalidChars(
        message: 'Must contain at least one lowercase letter.',
      ),
    );
  }
  if (!input.contains(RegExp(r'[0-9]'))) {
    return left(
      const ValueFailure.strInvalidChars(
        message: 'Must contain at least one number.',
      ),
    );
  }
  if (!input.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    return left(
      const ValueFailure.strInvalidChars(
        message: 'Must contain at least one special character.',
      ),
    );
  }
  return right(input);
}

// ---------------------------------------------------------------------------
// Base Classes
// ---------------------------------------------------------------------------

/// Abstract base class for all text-type ValueObjects.
/// Centralizes validation logic and error messages.
abstract class ValueText extends ValueObject<String> {
  @override
  final Either<ValueFailure, String> value;

  @override
  final CustomValidate<String>? customValidate;

  const ValueText(this.value, {this.customValidate});
}

// ---------------------------------------------------------------------------
// Implementations
// ---------------------------------------------------------------------------

/// Manage a text in a single line, non empty & with a max length
class ValueSingleLine extends ValueText {
  final int max;

  factory ValueSingleLine(
    String input, {
    int max = 125,
    CustomValidate<String>? customValidate,
  }) {
    final result = validateNotEmpty(
      input,
    ).flatMap((s) => validateMaxLength(s, max)).flatMap(validateSingleLine);
    return ValueSingleLine._(result, max: max, customValidate: customValidate);
  }

  const ValueSingleLine._(super.value, {this.max = 125, super.customValidate});
}

/// Manage a text that can have multiple lines, non empty & with a max length
class ValueMultipleLine extends ValueText {
  final int max;

  factory ValueMultipleLine(
    String input, {
    int max = 600,
    CustomValidate<String>? customValidate,
  }) {
    final result = validateNotEmpty(
      input,
    ).flatMap((s) => validateMaxLength(s, max));
    return ValueMultipleLine._(
      result,
      max: max,
      customValidate: customValidate,
    );
  }

  const ValueMultipleLine._(super.value, {this.max = 600, super.customValidate});
}

// ---------------------------------------------------------------------------
// Optional Texts
// ---------------------------------------------------------------------------

/// Clase base abstracta para ValueObjects de texto opcionales.
abstract class ValueOptionText<T extends ValueText>
    extends ValueObject<Option<String>> {
  @override
  final Either<ValueFailure, Option<String>> value;

  @override
  final CustomValidate<Option<String>>? customValidate;

  const ValueOptionText(this.value, {this.customValidate});

  static Either<ValueFailure, Option<String>> validator<T extends ValueText>(
    String? input,
    T Function(String) factory,
  ) {
    if (input == null || input.isEmpty) return right(none());
    return factory(input).value.fold((l) => left(l), (r) => right(some(r)));
  }
}

/// Manage an optional text. If exist, it behave as a [ValueSingleLine]
class ValueOptionSingleLine extends ValueOptionText {
  factory ValueOptionSingleLine(
    String? input, {
    int max = 125,
    CustomValidate<Option<String>>? customValidate,
  }) {
    return ValueOptionSingleLine._(
      ValueOptionText.validator(input, (s) => ValueSingleLine(s, max: max)),
      customValidate: customValidate,
    );
  }
  const ValueOptionSingleLine._(super.value, {super.customValidate});
}

/// Manage an optional text. If exist, it behave as a [ValueMultipleLine]
class ValueOptionMultipleLine extends ValueOptionText {
  factory ValueOptionMultipleLine(
    String? input, {
    int max = 600,
    CustomValidate<Option<String>>? customValidate,
  }) {
    return ValueOptionMultipleLine._(
      ValueOptionText.validator(input, (s) => ValueMultipleLine(s, max: max)),
      customValidate: customValidate,
    );
  }
  const ValueOptionMultipleLine._(super.value, {super.customValidate});
}

// ---------------------------------------------------------------------------
// URL
// ---------------------------------------------------------------------------

/// ValueObject to handle URLs.
/// Validates that the text is a well-formed absolute URL.
class ValueUrl extends ValueObject<Uri> {
  @override
  final Either<ValueFailure, Uri> value;

  @override
  final CustomValidate<Uri>? customValidate;

  factory ValueUrl(String input, {CustomValidate<Uri>? customValidate}) {
    final result = validateNotEmpty(input).flatMap(validateUrlFormat);
    return ValueUrl._(result, customValidate: customValidate);
  }

  const ValueUrl._(this.value, {this.customValidate});
}

class ValueOptionUrl extends ValueObject<Option<Uri>> {
  @override
  final Either<ValueFailure, Option<Uri>> value;

  @override
  final CustomValidate<Option<Uri>>? customValidate;

  factory ValueOptionUrl(
    String? input, {
    CustomValidate<Option<Uri>>? customValidate,
  }) {
    if (input == null || input.trim().isEmpty) {
      return ValueOptionUrl._(right(none()), customValidate: customValidate);
    }
    return ValueOptionUrl._(
      ValueUrl(input).value.map(some),
      customValidate: customValidate,
    );
  }

  const ValueOptionUrl._(this.value, {this.customValidate});

  /// return the string value or empty string if is none or failure
  String get orEmpty => value.fold(
    (f) => '',
    (r) => r.fold(() => '', (s) => s.isAbsolute ? s.toString() : s.path),
  );
}
