import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

import 'errors.dart';
import 'value_failure.dart';

extension ValueFailureEitherX<T> on Either<ValueFailure, T> {
  String? get failureMessage =>
      fold((failure) => failure.errorMessage, (_) => null);
}

/// Validator function used in Form Fields & passing in value objects.
/// A function that return null if a ValueObject
/// is valid or a failure text if not.
typedef CustomValidate = String? Function<T>(Either<ValueFailure, T>)?;

//
// Common methods for all ValueObjects:
//
// orCrash: useful for reading values
//
// failureOrOption: used to work with options in validations
// validateIf: has the same use as failureOption but allows adding a
//             condition on whether to validate or not
// isValid: useful to know if the object is in a valid state
//
// ----------------------------------------------------------
// The following are defined in extensions:
//
// orNull: useful for initializing ui components
// orElse: useful for reading values where a default is necessary.
//         works with optional values too and returns the value inside the option.
// orDefault: useful for reading values where a default is necessary.
//            returns the default value if invalid, works with optional values
//            too and returns the value inside the option or the default if is none.
//
// The following are defined in subclasses:
//
// orEmpty: useful for text or collection values. returns an empty string or empty collection
// orZero: useful for numeric values, returns 0 if invalid

@immutable
abstract class ValueObject<T> {
  const ValueObject();

  Either<ValueFailure, T> get value;

  /// Return the value or throw a fatal exception.
  /// Throws [UnexpectedValueError] containing the [ValueFailure]
  T get orCrash => value.getOrElse((f) => throw UnexpectedValueError(f));

  /// Return an option with a failure or none
  Option<ValueFailure> failureOption() => value.getLeft();

  /// Returns the [failureOption] only if the [condition] is true.
  /// Useful for conditional validations.
  Option<ValueFailure> validateIf(bool condition) {
    return condition ? failureOption() : none();
  }

  /// check if this object is valid or not
  bool get isValid => value.isRight();

  /// Get info about an error, if any, or null if this object is valid
  String? validate();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ValueObject<T> &&
          runtimeType == other.runtimeType &&
          other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => '$value';
}
