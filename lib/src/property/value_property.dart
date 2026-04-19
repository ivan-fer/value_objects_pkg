import 'package:fpdart/fpdart.dart';
import 'package:value_objects_pkg/src/core/value_failure.dart';
import 'package:value_objects_pkg/src/core/value_object.dart';
import 'package:value_objects_pkg/src/numbers/value_numbers.dart';

/// Representa la superficie construida en pies cuadrados (Square Feet).
/// Es un valor numérico siempre no negativo.
class ValueSqFt extends ValueObject<double> {
  @override
  final Either<ValueFailure, double> value;

  factory ValueSqFt(String input, {double? max}) {
    final result = parseNumeric<double>(input)
        .flatMap((v) => validateMin(v, 0.0))
        .flatMap((v) => max != null ? validateMax(v, max) : right(v));
    return ValueSqFt._(result);
  }

  const ValueSqFt._(this.value);

  /// Convierte la superficie a Acres (1 Acre = 43,560 SqFt).
  double get toAcres => value.getOrElse((_) => 0.0) / 43560;

  @override
  String? validate() => value.failureMessage;
}

/// Representa el tamaño del lote (Lot Size) en Acres.
class ValueAcres extends ValueObject<double> {
  @override
  final Either<ValueFailure, double> value;

  factory ValueAcres(String input, {double? max}) {
    final result = parseNumeric<double>(input)
        .flatMap((v) => validateMin(v, 0.0))
        .flatMap((v) => max != null ? validateMax(v, max) : right(v));
    return ValueAcres._(result);
  }

  const ValueAcres._(this.value);

  /// Convierte los Acres a pies cuadrados.
  double get toSqFt => value.getOrElse((_) => 0.0) * 43560;

  @override
  String? validate() => value.failureMessage;
}

class ValueOptionAcres extends ValueObject<Option<double>> {
  @override
  final Either<ValueFailure, Option<double>> value;

  factory ValueOptionAcres(String? input, {double? max}) {
    if (input == null || input.trim().isEmpty) {
      return ValueOptionAcres._(right(none()));
    }
    final result = parseNumeric<double>(input)
        .flatMap((v) => validateMin(v, 0.0))
        .flatMap((v) => max != null ? validateMax(v, max) : right(v))
        .map(some);
    return ValueOptionAcres._(result);
  }

  const ValueOptionAcres._(this.value);

  @override
  String? validate() => value.failureMessage;
}

/// Gestiona el año de construcción de la propiedad.
/// Valida que sea un año razonable (desde el año 1000 hasta el futuro cercano).
class ValueYearBuilt extends ValueObject<int> {
  @override
  final Either<ValueFailure, int> value;

  factory ValueYearBuilt(String input) {
    final currentYear = DateTime.now().year;
    final result = parseNumeric<int>(input)
        .flatMap((v) => validateMin(v, 1000))
        .flatMap((v) => validateMax(v, currentYear + 10));
    return ValueYearBuilt._(result);
  }

  const ValueYearBuilt._(this.value);

  @override
  String? validate() => value.failureMessage;
}
