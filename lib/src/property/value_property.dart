import 'package:fpdart/fpdart.dart';
import 'package:value_objects_pkg/src/core/value_failure.dart';
import 'package:value_objects_pkg/src/core/value_object.dart';
import 'package:value_objects_pkg/src/numbers/value_numbers.dart';

/// Representa la superficie construida en pies cuadrados (Square Feet).
/// Es un valor numérico siempre no negativo.
class ValueSqFt extends ValueObject<double> {
  @override
  final Either<ValueFailure, double> value;

  @override
  final CustomValidate<double>? customValidate;

  factory ValueSqFt(
    String input, {
    double? max,
    CustomValidate<double>? customValidate,
  }) {
    final result = parseNumeric<double>(input)
        .flatMap((v) => validateMin(v, 0.0))
        .flatMap((v) => max != null ? validateMax(v, max) : right(v));
    return ValueSqFt._(result, customValidate: customValidate);
  }

  const ValueSqFt._(this.value, {this.customValidate});

  /// Convierte la superficie a Acres (1 Acre = 43,560 SqFt).
  double get toAcres => value.getOrElse((_) => 0.0) / 43560;
}

/// Representa el tamaño del lote (Lot Size) en Acres.
class ValueAcres extends ValueObject<double> {
  @override
  final Either<ValueFailure, double> value;

  @override
  final CustomValidate<double>? customValidate;

  factory ValueAcres(
    String input, {
    double? max,
    CustomValidate<double>? customValidate,
  }) {
    final result = parseNumeric<double>(input)
        .flatMap((v) => validateMin(v, 0.0))
        .flatMap((v) => max != null ? validateMax(v, max) : right(v));
    return ValueAcres._(result, customValidate: customValidate);
  }

  const ValueAcres._(this.value, {this.customValidate});

  /// Convierte los Acres a pies cuadrados.
  double get toSqFt => value.getOrElse((_) => 0.0) * 43560;
}

class ValueOptionAcres extends ValueObject<Option<double>> {
  @override
  final Either<ValueFailure, Option<double>> value;

  @override
  final CustomValidate<Option<double>>? customValidate;

  factory ValueOptionAcres(
    String? input, {
    double? max,
    CustomValidate<Option<double>>? customValidate,
  }) {
    if (input == null || input.trim().isEmpty) {
      return ValueOptionAcres._(right(none()), customValidate: customValidate);
    }
    final result = parseNumeric<double>(input)
        .flatMap((v) => validateMin(v, 0.0))
        .flatMap((v) => max != null ? validateMax(v, max) : right(v))
        .map(some);
    return ValueOptionAcres._(result, customValidate: customValidate);
  }

  const ValueOptionAcres._(this.value, {this.customValidate});
}

/// Gestiona el año de construcción de la propiedad.
/// Valida que sea un año razonable (desde el año 1000 hasta el futuro cercano).
class ValueYearBuilt extends ValueObject<int> {
  @override
  final Either<ValueFailure, int> value;

  @override
  final CustomValidate<int>? customValidate;

  factory ValueYearBuilt(String input, {CustomValidate<int>? customValidate}) {
    final currentYear = DateTime.now().year;
    final result = parseNumeric<int>(input)
        .flatMap((v) => validateMin(v, 1000))
        .flatMap((v) => validateMax(v, currentYear + 10));
    return ValueYearBuilt._(result, customValidate: customValidate);
  }

  const ValueYearBuilt._(this.value, {this.customValidate});
}
