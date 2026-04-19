import 'package:distance/distance.dart';
import 'package:fpdart/fpdart.dart';

import 'package:value_objects_pkg/src/core/value_failure.dart';
import 'package:value_objects_pkg/src/core/value_object.dart';

// ---------------------------------------------------------------------------
// Validation Functions
// ---------------------------------------------------------------------------

/// Valida que una fecha se encuentre dentro de un rango específico.
Either<ValueFailure, DateTime> validateDateRange(
  DateTime input,
  DateTime min,
  DateTime max,
) {
  if (input.isBefore(min) || input.isAfter(max)) {
    return left(ValueFailure.dateOutRange(min: min, max: max));
  }
  return right(input);
}

/// Valida que una distancia no sea cero.
Either<ValueFailure, Distance> validateDistanceNotZero(Distance input) {
  if (input == Distance.zero) {
    return left(const ValueFailure.zeroValue());
  }
  return right(input);
}

/// Valida que una distancia se encuentre dentro de un rango opcional.
Either<ValueFailure, Distance> validateDistanceRange(
  Distance input, {
  Distance? min,
  Distance? max,
}) {
  if (min != null && input < min) {
    return left(
      ValueFailure.numOutRange(
        failedValue: input.inMeters,
        min: min.inMeters,
        max: max?.inMeters ?? double.infinity,
      ),
    );
  }
  if (max != null && input > max) {
    return left(
      ValueFailure.numOutRange(
        failedValue: input.inMeters,
        min: min?.inMeters ?? double.negativeInfinity,
        max: max.inMeters,
      ),
    );
  }
  return right(input);
}

/// Valida que una duración no sea cero.
Either<ValueFailure, Duration> validateDurationNotZero(Duration input) {
  if (input == Duration.zero) {
    return left(const ValueFailure.zeroValue());
  }
  return right(input);
}

/// Valida que una duración se encuentre dentro de un rango opcional.
Either<ValueFailure, Duration> validateDurationRange(
  Duration input, {
  Duration? min,
  Duration? max,
}) {
  if (min != null && input < min) {
    return left(
      ValueFailure.numOutRange(
        failedValue: input.inMilliseconds,
        min: min.inMilliseconds,
        max: max?.inMilliseconds ?? double.infinity,
      ),
    );
  }
  if (max != null && input > max) {
    return left(
      ValueFailure.numOutRange(
        failedValue: input.inMilliseconds,
        min: min?.inMilliseconds ?? double.negativeInfinity,
        max: max.inMilliseconds,
      ),
    );
  }
  return right(input);
}

// ---------------------------------------------------------------------------
// Implementations
// ---------------------------------------------------------------------------

/// Manage a [DateTime] that must be in a range
/// Default range: min 1900, max 2100
class ValueWhen extends ValueObject<DateTime> {
  @override
  final Either<ValueFailure, DateTime> value;

  factory ValueWhen(DateTime input, {DateTime? minDate, DateTime? maxDate}) {
    final defaultMinDate = minDate ?? DateTime(1900);
    final defaultMaxDate = maxDate ?? DateTime(2100);
    return ValueWhen._(
      validateDateRange(input, defaultMinDate, defaultMaxDate),
    );
  }

  const ValueWhen._(this.value);

  @override
  String? validate() => value.failureMessage;
}

/// Manage an optional [DateTime].
/// If exist, it must have between min & max dates.
class ValueOptionWhen extends ValueObject<Option<DateTime>> {
  @override
  final Either<ValueFailure, Option<DateTime>> value;

  factory ValueOptionWhen(
    DateTime? input, {
    DateTime? minDate,
    DateTime? maxDate,
  }) {
    if (input == null) return ValueOptionWhen._(right(const None()));
    return ValueOptionWhen._(
      validateDateRange(
        input,
        minDate ?? DateTime(1900),
        maxDate ?? DateTime(2100),
      ).map(some),
    );
  }

  const ValueOptionWhen._(this.value);

  @override
  String? validate() => value.failureMessage;
}

/// Gestiona fechas de nacimiento con validación de mayoría de edad (por defecto 18 años).
class ValueBirthDate extends ValueWhen {
  factory ValueBirthDate(DateTime input, {int minAge = 18}) {
    final now = DateTime.now();
    // Calculamos el límite superior (la fecha más tardía permitida para ser mayor de edad)
    final maxDate = DateTime(now.year - minAge, now.month, now.day);
    // Ponemos un límite inferior razonable (120 años atrás)
    final minDate = DateTime(now.year - 120, now.month, now.day);

    final result = validateDateRange(input, minDate, maxDate);

    return ValueBirthDate._(
      result.mapLeft(
        (f) => f.maybeMap(
          dateOutRange: (e) => e.copyWith(
            message: input.isAfter(maxDate)
                ? 'You must be at least $minAge years old'
                : 'Please enter a valid birth date',
          ),
          orElse: () => f,
        ),
      ),
    );
  }

  const ValueBirthDate._(super.value) : super._();
}

/// If min and max are provided, the distance must be in that range.
/// If distance is zero, it's invalid.
class ValueDistance extends ValueObject<Distance> {
  @override
  final Either<ValueFailure, Distance> value;

  Distance get orZero => value.getOrElse((f) => Distance.zero);

  factory ValueDistance(Distance distance, {Distance? min, Distance? max}) {
    final result = validateDistanceNotZero(
      distance,
    ).flatMap((d) => validateDistanceRange(d, min: min, max: max));
    return ValueDistance._(result);
  }

  const ValueDistance._(this.value);

  @override
  String? validate() => value.failureMessage;
}

/// If min and max are provided, the duration must be in that range.
/// If duration is zero, it's invalid.
class ValueDuration extends ValueObject<Duration> {
  @override
  final Either<ValueFailure, Duration> value;

  Duration get orZero => value.getOrElse((f) => Duration.zero);

  factory ValueDuration(Duration moment, {Duration? min, Duration? max}) {
    final result = validateDurationNotZero(
      moment,
    ).flatMap((d) => validateDurationRange(d, min: min, max: max));
    return ValueDuration._(result);
  }

  const ValueDuration._(this.value);

  @override
  String? validate() => value.failureMessage;
}
