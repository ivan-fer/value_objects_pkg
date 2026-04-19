import 'package:fpdart/fpdart.dart';

import 'package:value_objects_pkg/src/core/value_failure.dart';
import 'package:value_objects_pkg/src/core/value_object.dart';

// ---------------------------------------------------------------------------
// Validation Functions
// ---------------------------------------------------------------------------

/// Se encarga exclusivamente de transformar un String a un número (int, double o num)
Either<ValueFailure, T> parseNumeric<T extends num>(String input) {
  final trimmed = input.trim();
  if (trimmed.isEmpty) {
    return left(const ValueFailure.strEmpty());
  }

  final sanitized = trimmed.replaceAll(',', '.');
  num? parsed;

  if (T == int) {
    parsed = int.tryParse(sanitized);
  } else if (T == double) {
    parsed = double.tryParse(sanitized);
  } else {
    parsed = num.tryParse(sanitized);
  }

  if (parsed == null) {
    return left(ValueFailure.notANumber(failedValue: input));
  }

  return right(parsed as T);
}

/// Valida límites mínimos genéricos.
Either<ValueFailure, T> validateMin<T extends num>(
  T value,
  T min, {
  bool strict = false,
}) {
  final isInvalid = strict ? value <= min : value < min;
  if (isInvalid) {
    return left(ValueFailure.numOutMin(failedValue: value, minAllow: min));
  }
  return right(value);
}

/// Valida límites máximos genéricos.
Either<ValueFailure, T> validateMax<T extends num>(T value, T max) {
  if (value > max) {
    return left(ValueFailure.numOutMax(failedValue: value, maxAllow: max));
  }
  return right(value);
}

/// Garantiza que un valor sea estrictamente mayor a 0.
Either<ValueFailure, T> validatePositive<T extends num>(T value) {
  if (value <= 0) {
    return left(ValueFailure.numOutMin(failedValue: value, minAllow: 0));
  }
  return right(value);
}

/// Garantiza que un valor sea mayor o igual a 0.
Either<ValueFailure, T> validateNonNegative<T extends num>(T value) {
  if (value < 0) {
    return left(ValueFailure.numOutMin(failedValue: value, minAllow: 0));
  }
  return right(value);
}

// ---------------------------------------------------------------------------
// Base Classes
// ---------------------------------------------------------------------------

/// Clase base abstracta para ValueObjects numéricos.
abstract class ValueNumeric<T extends num> extends ValueObject<T> {
  @override
  final Either<ValueFailure, T> value;

  const ValueNumeric(this.value);

  @override
  String? validate() => value.failureMessage;
}

/// Clase base abstracta para ValueObjects numéricos opcionales.
abstract class ValueOptionNumeric<T extends num>
    extends ValueObject<Option<T>> {
  @override
  final Either<ValueFailure, Option<T>> value;

  const ValueOptionNumeric(this.value);

  @override
  String? validate() => value.failureMessage;
}

// ---------------------------------------------------------------------------
// Implementations
// ---------------------------------------------------------------------------

/// Numeric value (int or double) with optional min/max bounds.
/// Custom validation function can be provided via [customValidate].
class ValueNumber extends ValueNumeric<num> {
  final num? min;
  final num? max;
  final String? Function(Either<ValueFailure, num>)? fnValidate;

  factory ValueNumber(
    String input, {
    num? min,
    num? max,
    String? Function(Either<ValueFailure, num>)? customValidate,
  }) {
    final result = parseNumeric<num>(input)
        .flatMap((v) => min != null ? validateMin(v, min) : right(v))
        .flatMap((v) => max != null ? validateMax(v, max) : right(v));
    return ValueNumber._(
      result,
      min: min,
      max: max,
      fnValidate: customValidate,
    );
  }

  const ValueNumber._(super.value, {this.min, this.max, this.fnValidate});

  @override
  String? validate() => fnValidate?.call(value) ?? super.validate();
}

/// Manage an optional numeric value.
class ValueOptionNumber extends ValueOptionNumeric<num> {
  final num? min;
  final num? max;
  final String? Function(Either<ValueFailure, Option<num>>)? fnValidate;

  /// Returns 0 if failure or none.
  num get orZero =>
      value.fold((failure) => 0, (option) => option.getOrElse(() => 0.0));

  factory ValueOptionNumber(
    String? input, {
    num? min,
    num? max,
    String? Function(Either<ValueFailure, Option<num>>)? customValidate,
  }) {
    if (input == null || input.trim().isEmpty) {
      return ValueOptionNumber._(
        right(const None()),
        min: min,
        max: max,
        fnValidate: customValidate,
      );
    }
    final result = parseNumeric<num>(input)
        .flatMap((v) => min != null ? validateMin(v, min) : right(v))
        .flatMap((v) => max != null ? validateMax(v, max) : right(v))
        .map(some);
    return ValueOptionNumber._(
      result,
      min: min,
      max: max,
      fnValidate: customValidate,
    );
  }

  const ValueOptionNumber._(super.value, {this.min, this.max, this.fnValidate});

  @override
  String? validate() => fnValidate?.call(value) ?? super.validate();
}

/// Numeric value (num) >= 0.
class ValueNonNegativeNumber extends ValueNumeric<num> {
  final num? max;

  factory ValueNonNegativeNumber(String input, {num? max}) {
    final result = parseNumeric<num>(input)
        .flatMap(validateNonNegative)
        .flatMap((v) => max != null ? validateMax(v, max) : right(v));
    return ValueNonNegativeNumber._(result, max: max);
  }

  const ValueNonNegativeNumber._(super.value, {this.max});
}

/// Numeric value (num) > 0.
class ValuePositiveNumber extends ValueNumeric<num> {
  final num? max;

  factory ValuePositiveNumber(String input, {num? max}) {
    final result = parseNumeric<num>(input)
        .flatMap(validatePositive)
        .flatMap((v) => max != null ? validateMax(v, max) : right(v));
    return ValuePositiveNumber._(result, max: max);
  }

  const ValuePositiveNumber._(super.value, {this.max});
}

/// Integer with optional min/max bounds.
class ValueInt extends ValueNumeric<int> {
  final int? min;
  final int? max;

  factory ValueInt(String input, {int? min, int? max}) {
    final result = parseNumeric<int>(input)
        .flatMap((v) => min != null ? validateMin(v, min) : right(v))
        .flatMap((v) => max != null ? validateMax(v, max) : right(v));
    return ValueInt._(result, min: min, max: max);
  }

  const ValueInt._(super.value, {this.min, this.max});
}

/// Manage an optional integer value.
class ValueOptionInt extends ValueOptionNumeric<int> {
  final int? min;
  final int? max;

  factory ValueOptionInt(String? input, {int? min, int? max}) {
    if (input == null || input.trim().isEmpty) {
      return ValueOptionInt._(right(const None()), min: min, max: max);
    }
    final result = parseNumeric<int>(input)
        .flatMap((v) => min != null ? validateMin(v, min) : right(v))
        .flatMap((v) => max != null ? validateMax(v, max) : right(v))
        .map(some);
    return ValueOptionInt._(result, min: min, max: max);
  }

  const ValueOptionInt._(super.value, {this.min, this.max});
}

/// Integer >= 0. Use for counts that can be zero (bedrooms, parking spaces, etc.)
class ValueNonNegativeInt extends ValueNumeric<int> {
  final String? Function(Either<ValueFailure, int>)? fnValidate;

  factory ValueNonNegativeInt(
    String input, {
    String? Function(Either<ValueFailure, int>)? customValidate,
  }) {
    final result = parseNumeric<int>(input).flatMap(validateNonNegative);
    return ValueNonNegativeInt._(result, fnValidate: customValidate);
  }

  const ValueNonNegativeInt._(super.value, {this.fnValidate});

  @override
  String? validate() => fnValidate?.call(value) ?? super.validate();
}

/// Optional Integer >= 0. Use for optional counts.
class ValueOptionNonNegativeInt extends ValueOptionNumeric<int> {
  final String? Function(Either<ValueFailure, Option<int>>)? fnValidate;

  factory ValueOptionNonNegativeInt(
    String? input, {
    String? Function(Either<ValueFailure, Option<int>>)? customValidate,
  }) {
    if (input == null || input.trim().isEmpty) {
      return ValueOptionNonNegativeInt._(
        right(const None()),
        fnValidate: customValidate,
      );
    }
    final result = parseNumeric<int>(
      input,
    ).flatMap(validateNonNegative).map(some);
    return ValueOptionNonNegativeInt._(result, fnValidate: customValidate);
  }

  const ValueOptionNonNegativeInt._(super.value, {this.fnValidate});

  @override
  String? validate() => fnValidate?.call(value) ?? super.validate();
}

/// Integer > 0. Use for counts that must be at least 1 (units, mortgage term, etc.)
class ValuePositiveInt extends ValueNumeric<int> {
  final int? max;
  final String? Function(Either<ValueFailure, int>)? fnValidate;

  factory ValuePositiveInt(
    String input, {
    int? max,
    String? Function(Either<ValueFailure, int>)? customValidate,
  }) {
    final result = parseNumeric<int>(input)
        .flatMap(validatePositive)
        .flatMap((v) => max != null ? validateMax(v, max) : right(v));
    return ValuePositiveInt._(result, max: max, fnValidate: customValidate);
  }

  const ValuePositiveInt._(super.value, {this.max, this.fnValidate});

  @override
  String? validate() => fnValidate?.call(value) ?? super.validate();
}

/// Optional integer > 0. If exists, must be equal to a ValuePositiveInt.
class ValueOptionPositiveInt extends ValueOptionNumeric<int> {
  final int? max;
  final String? Function(Either<ValueFailure, Option<int>>)? fnValidate;

  factory ValueOptionPositiveInt(
    String? input, {
    int? max,
    String? Function(Either<ValueFailure, Option<int>>)? customValidate,
  }) {
    if (input == null || input.trim().isEmpty) {
      return ValueOptionPositiveInt._(
        right(const None()),
        max: max,
        fnValidate: customValidate,
      );
    }
    final result = parseNumeric<int>(input)
        .flatMap(validatePositive)
        .flatMap((v) => max != null ? validateMax(v, max) : right(v))
        .map(some);
    return ValueOptionPositiveInt._(
      result,
      max: max,
      fnValidate: customValidate,
    );
  }

  const ValueOptionPositiveInt._(super.value, {this.max, this.fnValidate});

  @override
  String? validate() => fnValidate?.call(value) ?? super.validate();
}

/// Double (decimal) with optional min/max bounds.
class ValueDecimal extends ValueNumeric<double> {
  final double? min;
  final double? max;

  factory ValueDecimal(String input, {double? min, double? max}) {
    final result = parseNumeric<double>(input)
        .flatMap((v) => min != null ? validateMin(v, min) : right(v))
        .flatMap((v) => max != null ? validateMax(v, max) : right(v));
    return ValueDecimal._(result, min: min, max: max);
  }

  const ValueDecimal._(super.value, {this.min, this.max});
}

/// Double >= 0. Suitable for monetary amounts.
class ValueNonNegativeDecimal extends ValueNumeric<double> {
  final double? max;

  factory ValueNonNegativeDecimal(String input, {double? max}) {
    final result = parseNumeric<double>(input)
        .flatMap(validateNonNegative)
        .flatMap((v) => max != null ? validateMax(v, max) : right(v));
    return ValueNonNegativeDecimal._(result, max: max);
  }

  const ValueNonNegativeDecimal._(super.value, {this.max});
}

/// Double > 0. Suitable for costs that cannot be free.
class ValuePositiveDecimal extends ValueNumeric<double> {
  final double? max;

  factory ValuePositiveDecimal(String input, {double? max}) {
    final result = parseNumeric<double>(input)
        .flatMap(validatePositive)
        .flatMap((v) => max != null ? validateMax(v, max) : right(v));
    return ValuePositiveDecimal._(result, max: max);
  }

  const ValuePositiveDecimal._(super.value, {this.max});
}

/// Double >= 0 and <= 100. Use for percentage fields.
class ValuePercentage extends ValueNumeric<double> {
  factory ValuePercentage(String input) {
    final result = parseNumeric<double>(
      input,
    ).flatMap((v) => validateMin(v, 0.0)).flatMap((v) => validateMax(v, 100.0));
    return ValuePercentage._(result);
  }

  const ValuePercentage._(super.value);

  /// Devuelve el valor decimal para cálculos (ej. 5.0 -> 0.05).
  double get asFraction => value.getOrElse((_) => 0.0) / 100;
}

class ValueOptionPercentage extends ValueOptionNumeric<double> {
  factory ValueOptionPercentage(String? input) {
    if (input == null || input.trim().isEmpty) {
      return ValueOptionPercentage._(right(const None()));
    }
    final result = parseNumeric<double>(input)
        .flatMap((v) => validateMin(v, 0.0))
        .flatMap((v) => validateMax(v, 100.0))
        .map(some);
    return ValueOptionPercentage._(result);
  }

  const ValueOptionPercentage._(super.value);

  /// Devuelve el valor decimal para cálculos (ej. 5.0 -> 0.05). Si no existe o hay error, devuelve 0.
  double get asFraction =>
      value.fold((_) => 0.0, (option) => option.getOrElse(() => 0.0)) / 100;
}

class ValueOptionDecimal extends ValueOptionNumeric<double> {
  final double? min;
  final double? max;

  factory ValueOptionDecimal(String? input, {double? min, double? max}) {
    if (input == null || input.trim().isEmpty) {
      return ValueOptionDecimal._(right(const None()), min: min, max: max);
    }
    final result = parseNumeric<double>(input)
        .flatMap((v) => min != null ? validateMin(v, min) : right(v))
        .flatMap((v) => max != null ? validateMax(v, max) : right(v))
        .map(some);
    return ValueOptionDecimal._(result, min: min, max: max);
  }

  const ValueOptionDecimal._(super.value, {this.min, this.max});
}
