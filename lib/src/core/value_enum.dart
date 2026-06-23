import 'package:fpdart/fpdart.dart';

import 'value_failure.dart';
import 'value_object.dart';

// ---------------------------------------------------------------------------
// Validation Functions
// ---------------------------------------------------------------------------

/// Valida que el enumerador no esté en su estado por defecto/vacío.
Either<ValueFailure, T> validateEnumNotNone<T extends IEnumWithNone>(
  T input, {
  String? errorMessage,
}) {
  if (input.isNone) {
    return left(ValueFailure.enumIsNone(message: errorMessage ?? ''));
  }
  return right(input);
}

// ---------------------------------------------------------------------------
// Base Interfaces
// ---------------------------------------------------------------------------

/// An interface that enumerations with a 'none' or null state must implement.
/// This allows them to be used by the generic [ValueEnum].
abstract class IEnumWithNone {
  bool get isNone;
  String toDisplayString();
}

// ---------------------------------------------------------------------------
// Implementations
// ---------------------------------------------------------------------------

/// A generic [ValueObject] to handle enums implementing [IEnumWithNone].
///
/// Validates that the enum value is not in the 'none' state.
class ValueEnum<T extends IEnumWithNone> extends ValueObject<T> {
  @override
  final Either<ValueFailure, T> value;

  @override
  final CustomValidate<T>? customValidate;

  factory ValueEnum(
    T input, {
    String? errorMessage,
    CustomValidate<T>? customValidate,
  }) {
    final result = validateEnumNotNone(input, errorMessage: errorMessage);
    return ValueEnum._(result, customValidate: customValidate);
  }

  const ValueEnum._(this.value, {this.customValidate});
}
