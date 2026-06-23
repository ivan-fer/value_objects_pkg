import 'package:fpdart/fpdart.dart';
import 'package:value_objects_pkg/src/core/value_failure.dart';
import 'package:value_objects_pkg/src/core/value_object.dart';
import 'package:value_objects_pkg/src/numbers/value_numbers.dart';

// ---------------------------------------------------------------------------
// Validation Functions
// ---------------------------------------------------------------------------

/// Valida que la latitud esté entre -90.0 y 90.0 grados.
Either<ValueFailure, double> validateLatitude(double input) {
  if (input < -90.0 || input > 90.0) {
    return left(
      ValueFailure.numOutRange(failedValue: input, min: -90.0, max: 90.0),
    );
  }
  return right(input);
}

/// Valida que la longitud esté entre -180.0 y 180.0 grados.
Either<ValueFailure, double> validateLongitude(double input) {
  if (input < -180.0 || input > 180.0) {
    return left(
      ValueFailure.numOutRange(failedValue: input, min: -180.0, max: 180.0),
    );
  }
  return right(input);
}

// ---------------------------------------------------------------------------
// Implementations
// ---------------------------------------------------------------------------

/// Representa la Latitud geográfica (-90.0 a 90.0).
class ValueLatitude extends ValueObject<double> {
  @override
  final Either<ValueFailure, double> value;

  @override
  final CustomValidate<double>? customValidate;

  factory ValueLatitude(
    String input, {
    CustomValidate<double>? customValidate,
  }) {
    final result = parseNumeric<double>(input).flatMap(validateLatitude);
    return ValueLatitude._(result, customValidate: customValidate);
  }

  const ValueLatitude._(this.value, {this.customValidate});
}

/// Representa la Longitud geográfica (-180.0 a 180.0).
class ValueLongitude extends ValueObject<double> {
  @override
  final Either<ValueFailure, double> value;

  @override
  final CustomValidate<double>? customValidate;

  factory ValueLongitude(
    String input, {
    CustomValidate<double>? customValidate,
  }) {
    final result = parseNumeric<double>(input).flatMap(validateLongitude);
    return ValueLongitude._(result, customValidate: customValidate);
  }

  const ValueLongitude._(this.value, {this.customValidate});
}
