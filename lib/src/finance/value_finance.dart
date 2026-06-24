import 'package:fpdart/fpdart.dart';
import 'package:value_objects_pkg/src/core/value_failure.dart';
import 'package:value_objects_pkg/src/core/value_object.dart';
import 'package:value_objects_pkg/src/numbers/value_numbers.dart';

/// Categorías estándar de puntaje de crédito (FICO).
enum CreditScoreCategory {
  poor('Poor'),
  fair('Fair'),
  good('Good'),
  veryGood('Very Good'),
  excellent('Excellent'),
  invalid('Invalid');

  final String label;
  const CreditScoreCategory(this.label);
}

extension CreditScoreCategoryX on CreditScoreCategory {
  /// Devuelve el valor ARGB (int) del color representativo para cada categoría.
  /// En Flutter puedes usarlo como: Color(category.colorValue)
  int get colorValue => switch (this) {
    CreditScoreCategory.poor => 0xFFF44336, // Colors.red
    CreditScoreCategory.fair => 0xFFFF9800, // Colors.orange
    CreditScoreCategory.good => 0xFFFFC107, // Colors.amber
    CreditScoreCategory.veryGood => 0xFF8BC34A, // Colors.lightGreen
    CreditScoreCategory.excellent => 0xFF4CAF50, // Colors.green
    CreditScoreCategory.invalid => 0xFF9E9E9E, // Colors.grey
  };

  /// Provee una recomendación de acción basada en la categoría.
  String get recommendation => switch (this) {
    CreditScoreCategory.poor =>
      'Focus on improving your score before applying for a mortgage.',
    CreditScoreCategory.fair =>
      'You may qualify for some loans, but expect higher interest rates.',
    CreditScoreCategory.good =>
      'Good score. You will qualify for most conventional loans.',
    CreditScoreCategory.veryGood =>
      'Very good score. You can expect favorable mortgage terms.',
    CreditScoreCategory.excellent =>
      'Excellent! You qualify for the best available interest rates.',
    CreditScoreCategory.invalid =>
      'Please enter a valid credit score to see recommendations.',
  };
}

/// Categorías de salud financiera para el Debt-to-Income ratio (DTI).
enum DTICategory {
  excellent('Excellent'),
  good('Good'),
  highRisk('High Risk'),
  invalid('Invalid');

  final String label;
  const DTICategory(this.label);
}

extension DTICategoryX on DTICategory {
  /// Devuelve el valor ARGB (int) del color representativo para la categoría del DTI.
  /// En Flutter puedes usarlo como: Color(category.colorValue)
  int get colorValue => switch (this) {
    DTICategory.excellent => 0xFF4CAF50, // Colors.green
    DTICategory.good => 0xFF8BC34A, // Colors.lightGreen
    DTICategory.highRisk => 0xFFF44336, // Colors.red
    DTICategory.invalid => 0xFF9E9E9E, // Colors.grey
  };
}

/// Representa una tasa de interés (ej. 7.5%).
/// Generalmente restringida entre 0 y 100 para préstamos hipotecarios.
class ValueInterestRate extends ValueObject<double> {
  @override
  final Either<ValueFailure, double> value;

  @override
  final CustomValidate<double>? customValidate;

  factory ValueInterestRate(
    String input, {
    double max = 100.0,
    CustomValidate<double>? customValidate,
  }) {
    final result = parseNumeric<double>(
      input,
    ).flatMap((v) => validateMin(v, 0.0)).flatMap((v) => validateMax(v, max));
    return ValueInterestRate._(result, customValidate: customValidate);
  }

  const ValueInterestRate._(this.value, {this.customValidate});

  /// Devuelve el valor decimal para cálculos (ej. 5.0 -> 0.05).
  double get asFraction => value.getOrElse((_) => 0.0) / 100;
}

/// Representa un puntaje de crédito (Credit Score).
/// El rango estándar (FICO) es de 300 a 850.
class ValueCreditScore extends ValueObject<int> {
  @override
  final Either<ValueFailure, int> value;

  @override
  final CustomValidate<int>? customValidate;

  factory ValueCreditScore(
    String input, {
    CustomValidate<int>? customValidate,
  }) {
    final result = parseNumeric<int>(
      input,
    ).flatMap((v) => validateMin(v, 300)).flatMap((v) => validateMax(v, 850));
    return ValueCreditScore._(result, customValidate: customValidate);
  }

  const ValueCreditScore._(this.value, {this.customValidate});

  /// Retorna la categoría del puntaje basado en los rangos estándar de FICO.
  CreditScoreCategory get category {
    return value.fold((_) => CreditScoreCategory.invalid, (score) {
      if (score >= 800) return CreditScoreCategory.excellent;
      if (score >= 740) return CreditScoreCategory.veryGood;
      if (score >= 670) return CreditScoreCategory.good;
      if (score >= 580) return CreditScoreCategory.fair;
      return CreditScoreCategory.poor;
    });
  }

  /// Shortcut para obtener la recomendación basada en la categoría actual.
  String get recommendation => category.recommendation;
}

/// Gestiona montos monetarios vinculados a una moneda específica.
/// El estado interno es un Record que guarda el monto y el símbolo/código.
class ValueMoney extends ValueObject<(double, String)>
    implements Comparable<ValueMoney> {
  @override
  final Either<ValueFailure, (double, String)> value;

  @override
  final CustomValidate<(double, String)>? customValidate;

  factory ValueMoney(
    String input, {
    String symbol = '\$',
    double min = 0.0,
    double? max,
    CustomValidate<(double, String)>? customValidate,
  }) {
    final result = parseNumeric<double>(input)
        .flatMap((v) => validateMin(v, min))
        .flatMap((v) => max != null ? validateMax(v, max) : right(v));
    return ValueMoney._(
      result.map((amount) => (amount, symbol)),
      customValidate: customValidate,
    );
  }

  const ValueMoney._(this.value, {this.customValidate});

  /// Crea un objeto con valor cero.
  factory ValueMoney.zero({String symbol = '\$'}) =>
      ValueMoney._(right((0.0, symbol)));

  /// Helpers para acceder a los datos del Record.
  double get amount => value.getOrElse((_) => (0.0, '')).$1;
  String get symbol => value.getOrElse((_) => (0.0, '')).$2;

  /// Suma una lista de [ValueMoney].
  ///
  /// Si la lista está vacía, devuelve cero con el [defaultSymbol].
  /// Si hay discrepancia de monedas o valores inválidos en la lista,
  /// el resultado contendrá el primer fallo encontrado.
  static ValueMoney sum(List<ValueMoney> items, {String defaultSymbol = '\$'}) {
    if (items.isEmpty) return ValueMoney.zero(symbol: defaultSymbol);

    return items.reduce((acc, item) => acc + item);
  }

  /// Calcula el promedio de una lista de [ValueMoney].
  ///
  /// Si la lista está vacía, devuelve cero.
  /// Si hay fallos en la lista o discrepancia de monedas, devuelve el fallo.
  static ValueMoney avg(List<ValueMoney> items, {String defaultSymbol = '\$'}) {
    if (items.isEmpty) return ValueMoney.zero(symbol: defaultSymbol);

    final total = sum(items, defaultSymbol: defaultSymbol);
    return total * (1 / items.length);
  }

  /// Suma dos montos de dinero validando que tengan el mismo símbolo.
  /// Si los símbolos no coinciden o alguno de los valores es inválido,
  /// retorna un [ValueMoney] con el fallo correspondiente.
  ValueMoney operator +(ValueMoney other) {
    return ValueMoney._(
      value.flatMap(
        (v1) => other.value.flatMap((v2) {
          if (v1.$2 != v2.$2) {
            return left(
              ValueFailure.invalid(
                message: 'Currency mismatch: cannot add ${v1.$2} and ${v2.$2}',
              ),
            );
          }
          return right((v1.$1 + v2.$1, v1.$2));
        }),
      ),
    );
  }

  /// Resta dos montos de dinero validando el símbolo.
  /// Por defecto permite resultados negativos.
  ValueMoney operator -(ValueMoney other) =>
      subtract(other, allowNegative: true);

  /// Resta dos montos de dinero con control opcional sobre resultados negativos.
  /// Si [allowNegative] es false y el resultado es menor a 0, retorna un [ValueFailure.numOutMin].
  ValueMoney subtract(ValueMoney other, {bool allowNegative = true}) {
    return ValueMoney._(
      value.flatMap(
        (v1) => other.value.flatMap((v2) {
          if (v1.$2 != v2.$2) {
            return left(
              ValueFailure.invalid(
                message:
                    'Currency mismatch: cannot subtract ${v2.$2} from ${v1.$2}',
              ),
            );
          }
          final result = v1.$1 - v2.$1;
          if (!allowNegative && result < 0) {
            return left(
              ValueFailure.numOutMin(failedValue: result, minAllow: 0),
            );
          }
          return right((result, v1.$2));
        }),
      ),
    );
  }

  /// Multiplica el monto por un [ValuePercentage].
  /// Útil para calcular comisiones, impuestos o participaciones.
  ///
  /// Si el porcentaje o el dinero son inválidos, el resultado hereda el fallo.
  ValueMoney multiplyByPercentage(ValuePercentage percentage) {
    return ValueMoney._(
      value.flatMap(
        (m) => percentage.value.map((p) => (m.$1 * (p / 100), m.$2)),
      ),
    );
  }

  /// Multiplica el monto por un factor numérico simple.
  ValueMoney operator *(num factor) {
    return ValueMoney._(value.map((v) => (v.$1 * factor, v.$2)));
  }

  /// Compara si este monto es mayor que otro.
  /// Retorna false si las monedas no coinciden o si alguno es inválido.
  bool operator >(ValueMoney other) => _compare(other, (a, b) => a > b);

  /// Compara si este monto es mayor o igual que otro.
  bool operator >=(ValueMoney other) => _compare(other, (a, b) => a >= b);

  /// Compara si este monto es menor que otro.
  bool operator <(ValueMoney other) => _compare(other, (a, b) => a < b);

  /// Compara si este monto es menor o igual que otro.
  bool operator <=(ValueMoney other) => _compare(other, (a, b) => a <= b);

  /// Helper privado para centralizar la lógica de comparación.
  /// Valida que ambos valores sean válidos y que los símbolos de moneda coincidan.
  bool _compare(ValueMoney other, bool Function(double a, double b) op) {
    return value.fold(
      (_) => false,
      (v1) => other.value.fold(
        (_) => false,
        (v2) => v1.$2 == v2.$2 && op(v1.$1, v2.$1),
      ),
    );
  }

  @override
  int compareTo(ValueMoney other) {
    return value.fold(
      // Si este es inválido, lo ponemos al principio (-1) si el otro es válido
      (f1) => other.value.isLeft() ? 0 : -1,
      (v1) => other.value.fold(
        // Si el otro es inválido, este (que es válido) va después (1)
        (f2) => 1,
        (v2) {
          // 1. Comparar símbolos de moneda para agruparlos
          final symbolComp = v1.$2.compareTo(v2.$2);
          if (symbolComp != 0) return symbolComp;
          // 2. Si es la misma moneda, comparar montos
          return v1.$1.compareTo(v2.$1);
        },
      ),
    );
  }

  @override
  String toString() => value.fold(
    (f) => 'Invalid Money: $f',
    (r) => '${r.$2}${r.$1.toStringAsFixed(2)}',
  );
}

// Crear un ValueOptionMoney para campos opcionales de dinero en AcquisitionCosts.
class ValueOptionMoney extends ValueObject<Option<ValueMoney>> {
  @override
  final Either<ValueFailure, Option<ValueMoney>> value;

  @override
  final CustomValidate<Option<ValueMoney>>? customValidate;

  factory ValueOptionMoney(
    String? input, {
    String symbol = '\$',
    CustomValidate<Option<ValueMoney>>? customValidate,
  }) {
    if (input == null || input.trim().isEmpty) {
      return ValueOptionMoney._(right(none()), customValidate: customValidate);
    }
    final money = ValueMoney(input, symbol: symbol);
    return ValueOptionMoney._(
      money.value.map((m) => some(money)),
      customValidate: customValidate,
    );
  }

  factory ValueOptionMoney.none() {
    return ValueOptionMoney._(right(none()));
  }

  const ValueOptionMoney._(this.value, {this.customValidate});

  double get amount => value.fold(
    (f) => 0.0,
    (option) => option.getOrElse(() => ValueMoney.zero()).amount,
  );
  String get symbol => value.fold(
    (f) => '\$',
    (option) => option.getOrElse(() => ValueMoney.zero()).symbol,
  );
}

extension ValueMoneyIterableX on Iterable<ValueMoney> {
  /// Filtra los montos que coinciden con el símbolo de moneda especificado.
  Iterable<ValueMoney> whereCurrency(String symbol) =>
      where((m) => m.symbol == symbol);

  /// Calcula la suma de todos los montos en la colección.
  ValueMoney sum({String defaultSymbol = '\$'}) =>
      ValueMoney.sum(toList(), defaultSymbol: defaultSymbol);

  /// Calcula el promedio de los montos en la colección.
  ValueMoney avg({String defaultSymbol = '\$'}) =>
      ValueMoney.avg(toList(), defaultSymbol: defaultSymbol);

  /// Devuelve el monto máximo de la colección basado en el orden de [compareTo].
  /// (Agrupa por símbolo de moneda y luego por monto).
  ValueMoney maxAmount({String defaultSymbol = '\$'}) {
    if (isEmpty) return ValueMoney.zero(symbol: defaultSymbol);
    return reduce((a, b) => a.compareTo(b) >= 0 ? a : b);
  }

  /// Devuelve el monto mínimo de la colección basado en el orden de [compareTo].
  ValueMoney minAmount({String defaultSymbol = '\$'}) {
    if (isEmpty) return ValueMoney.zero(symbol: defaultSymbol);
    return reduce((a, b) => a.compareTo(b) <= 0 ? a : b);
  }
}

/// Representa el Retorno de Inversión (ROI).
/// A diferencia de InterestRate, el ROI puede ser negativo (pérdidas).
class ValueROI extends ValueObject<double> {
  @override
  final Either<ValueFailure, double> value;

  @override
  final CustomValidate<double>? customValidate;

  factory ValueROI(String input, {CustomValidate<double>? customValidate}) {
    // No ponemos límite superior ni inferior estricto,
    // solo validamos que sea un número.
    return ValueROI._(
      parseNumeric<double>(input),
      customValidate: customValidate,
    );
  }

  const ValueROI._(this.value, {this.customValidate});
}

/// Representa la relación Deuda-Ingreso (Debt-to-Income ratio).
class ValueDTI extends ValueObject<double> {
  @override
  final Either<ValueFailure, double> value;

  @override
  final CustomValidate<double>? customValidate;

  factory ValueDTI(String input, {CustomValidate<double>? customValidate}) {
    // El DTI es un porcentaje. Aunque usualmente es < 100, técnicamente
    // puede ser mayor si la deuda supera al ingreso. Validamos min 0.
    final result = parseNumeric<double>(
      input,
    ).flatMap((v) => validateMin(v, 0.0));
    return ValueDTI._(result, customValidate: customValidate);
  }

  /// Calcula el DTI a partir de la deuda mensual total y el ingreso bruto mensual.
  ///
  /// DTI = (Deuda Total Mensual / Ingreso Bruto Mensual) * 100
  factory ValueDTI.calculate(ValueMoney totalDebt, ValueMoney grossIncome) {
    return ValueDTI._(
      totalDebt.value.flatMap(
        (debt) => grossIncome.value.flatMap((income) {
          if (income.$1 <= 0) {
            return left(
              const ValueFailure.invalid(
                message:
                    'Gross income must be greater than zero to calculate DTI',
              ),
            );
          }
          if (debt.$2 != income.$2) {
            return left(
              ValueFailure.invalid(
                message:
                    'Currency mismatch: debt (${debt.$2}) and income (${income.$2})',
              ),
            );
          }
          return right((debt.$1 / income.$1) * 100);
        }),
      ),
    );
  }

  const ValueDTI._(this.value, {this.customValidate});

  /// Devuelve el valor decimal para cálculos (ej. 36.0 -> 0.36).
  double get asFraction => value.getOrElse((_) => 0.0) / 100;

  /// Indica si el ratio es excelente (<= 36%).
  bool get isExcellent => value.getOrElse((_) => 100.0) <= 36.0;

  /// Indica si el ratio es aceptable para la mayoría de prestamistas (<= 43%).
  bool get isAcceptable => value.getOrElse((_) => 100.0) <= 43.0;

  /// Retorna la categoría del DTI basada en estándares de la industria crediticia.
  DTICategory get category {
    return value.fold((_) => DTICategory.invalid, (ratio) {
      if (ratio <= 36.0) return DTICategory.excellent;
      if (ratio <= 43.0) return DTICategory.good;
      return DTICategory.highRisk;
    });
  }

  /// Retorna el mensaje de estado descriptivo (ej: "High Risk", "Good").
  String get statusMessage => category.label;
}

/// Representa un IBAN (International Bank Account Number) según ISO 13616.
///
/// Acepta el número con o sin espacios y en cualquier capitalización. Valida la
/// estructura básica (2 letras de país, 2 dígitos de control y hasta 30
/// caracteres alfanuméricos) y el checksum módulo 97. El valor almacenado es el
/// IBAN normalizado: en mayúsculas y sin espacios.
class ValueIban extends ValueObject<String> {
  @override
  final Either<ValueFailure, String> value;

  @override
  final CustomValidate<String>? customValidate;

  factory ValueIban(String input, {CustomValidate<String>? customValidate}) {
    return ValueIban._(_validateIban(input), customValidate: customValidate);
  }

  const ValueIban._(this.value, {this.customValidate});

  /// Devuelve el IBAN agrupado en bloques de 4 caracteres (ej. para mostrar en
  /// UI: `ES91 2100 0418 4502 0005 1332`), o string vacío si es inválido.
  String get formatted => value.fold((_) => '', (iban) {
    final groups = <String>[];
    for (var i = 0; i < iban.length; i += 4) {
      groups.add(iban.substring(i, i + 4 > iban.length ? iban.length : i + 4));
    }
    return groups.join(' ');
  });

  /// Devuelve el código de país (2 letras) del IBAN, o string vacío si es inválido.
  String get countryCode =>
      value.fold((_) => '', (iban) => iban.substring(0, 2));
}

class ValueOptionIban extends ValueObject<Option<String>> {
  @override
  final Either<ValueFailure, Option<String>> value;

  @override
  final CustomValidate<Option<String>>? customValidate;

  factory ValueOptionIban(
    String? input, {
    CustomValidate<Option<String>>? customValidate,
  }) {
    if (input == null || input.trim().isEmpty) {
      return ValueOptionIban._(right(none()), customValidate: customValidate);
    }
    return ValueOptionIban._(
      _validateIban(input).map(some),
      customValidate: customValidate,
    );
  }

  const ValueOptionIban._(this.value, {this.customValidate});

  /// Devuelve el IBAN normalizado o string vacío si es none o inválido.
  String get orEmpty =>
      value.fold((_) => '', (opt) => opt.getOrElse(() => ''));
}

/// Valida un IBAN según ISO 13616 (formato + checksum módulo 97).
///
/// Normaliza el valor (mayúsculas, sin espacios) antes de validar.
Either<ValueFailure, String> _validateIban(String input) {
  final iban = input.replaceAll(RegExp(r'\s'), '').toUpperCase();

  if (iban.isEmpty) {
    return left(const ValueFailure.strEmpty(nameObject: 'IBAN'));
  }

  // Estructura: 2 letras (país) + 2 dígitos (control) + 1-30 alfanuméricos.
  final ibanRegex = RegExp(r'^[A-Z]{2}[0-9]{2}[A-Z0-9]{1,30}$');
  if (!ibanRegex.hasMatch(iban)) {
    return left(
      const ValueFailure.strInvalidChars(
        nameObject: 'IBAN',
        message: 'El formato del IBAN no es válido',
      ),
    );
  }

  if (!_isValidIbanChecksum(iban)) {
    return left(
      const ValueFailure.invalid(
        nameObject: 'IBAN',
        message: 'El dígito de control del IBAN no es válido',
      ),
    );
  }

  return right(iban);
}

/// Verifica el checksum módulo 97 de un IBAN ya normalizado.
///
/// Mueve los 4 primeros caracteres al final, convierte cada letra a dos dígitos
/// (A=10 … Z=35) y comprueba que el número resultante sea congruente con 1 mód 97.
bool _isValidIbanChecksum(String iban) {
  final rearranged = iban.substring(4) + iban.substring(0, 4);

  // Calculamos el módulo de forma incremental para evitar enteros enormes.
  var remainder = 0;
  for (final char in rearranged.split('')) {
    // 0-9 -> "0".."9"; A-Z -> "10".."35".
    final chunk = RegExp(r'[0-9]').hasMatch(char)
        ? char
        : (char.codeUnitAt(0) - 'A'.codeUnitAt(0) + 10).toString();
    for (final digit in chunk.split('')) {
      remainder = (remainder * 10 + int.parse(digit)) % 97;
    }
  }

  return remainder == 1;
}
