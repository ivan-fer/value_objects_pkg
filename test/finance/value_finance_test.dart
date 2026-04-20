import 'package:flutter_test/flutter_test.dart';
import 'package:value_objects_pkg/src/finance/value_finance.dart';
import 'package:value_objects_pkg/src/numbers/value_numbers.dart';

void main() {
  group('Credit Score Categories', () {
    test('CreditScoreCategory debe tener label correcto', () {
      expect(CreditScoreCategory.poor.label, 'Poor');
      expect(CreditScoreCategory.excellent.label, 'Excellent');
    });

    test('colorValue debe retornar color ARGB válido', () {
      expect(CreditScoreCategory.poor.colorValue, 0xFFF44336);
      expect(CreditScoreCategory.excellent.colorValue, 0xFF4CAF50);
      expect(CreditScoreCategory.invalid.colorValue, 0xFF9E9E9E);
    });

    test('recommendation debe tener mensaje apropiado', () {
      expect(CreditScoreCategory.poor.recommendation, contains('improving'));
      expect(
        CreditScoreCategory.excellent.recommendation,
        contains('best available'),
      );
    });
  });

  group('DTI Categories', () {
    test('DTICategory debe tener label correcto', () {
      expect(DTICategory.excellent.label, 'Excellent');
      expect(DTICategory.highRisk.label, 'High Risk');
    });

    test('colorValue debe retornar color ARGB válido', () {
      expect(DTICategory.excellent.colorValue, 0xFF4CAF50);
      expect(DTICategory.highRisk.colorValue, 0xFFF44336);
    });
  });

  group('ValueInterestRate', () {
    test('debe validar una tasa de interés válida', () {
      final vo = ValueInterestRate('7.5');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 7.5);
    });

    test('debe aceptar tasa de 0%', () {
      final vo = ValueInterestRate('0');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 0.0);
    });

    test('debe aceptar tasa de 100%', () {
      final vo = ValueInterestRate('100');
      expect(vo.isValid, isTrue);
    });

    test('debe rechazar tasa negativa', () {
      final vo = ValueInterestRate('-5');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar tasa mayor a 100%', () {
      final vo = ValueInterestRate('150');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar string vacío', () {
      final vo = ValueInterestRate('');
      expect(vo.isValid, isFalse);
    });

    test('debe respetar máximo personalizado', () {
      final voValid = ValueInterestRate('8', max: 10.0);
      expect(voValid.isValid, isTrue);

      final voInvalid = ValueInterestRate('15', max: 10.0);
      expect(voInvalid.isValid, isFalse);
    });

    test('debe convertir a fracción correctamente', () {
      final vo = ValueInterestRate('5');
      expect(vo.asFraction, 0.05);

      final vo2 = ValueInterestRate('7.5');
      expect(vo2.asFraction, 0.075);
    });

    test('debe retornar 0 como fracción si hay error', () {
      final vo = ValueInterestRate('invalid');
      expect(vo.asFraction, 0.0);
    });
  });

  group('ValueCreditScore', () {
    test('debe validar un puntaje válido', () {
      final vo = ValueCreditScore('700');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 700);
    });

    test('debe aceptar mínimo 300', () {
      final vo = ValueCreditScore('300');
      expect(vo.isValid, isTrue);
    });

    test('debe aceptar máximo 850', () {
      final vo = ValueCreditScore('850');
      expect(vo.isValid, isTrue);
    });

    test('debe rechazar menor a 300', () {
      final vo = ValueCreditScore('299');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar mayor a 850', () {
      final vo = ValueCreditScore('851');
      expect(vo.isValid, isFalse);
    });

    test('debe categorizar como poor (< 580)', () {
      final vo = ValueCreditScore('500');
      expect(vo.category, CreditScoreCategory.poor);
    });

    test('debe categorizar como fair (580-669)', () {
      final vo = ValueCreditScore('600');
      expect(vo.category, CreditScoreCategory.fair);
    });

    test('debe categorizar como good (670-739)', () {
      final vo = ValueCreditScore('700');
      expect(vo.category, CreditScoreCategory.good);
    });

    test('debe categorizar como veryGood (740-799)', () {
      final vo = ValueCreditScore('750');
      expect(vo.category, CreditScoreCategory.veryGood);
    });

    test('debe categorizar como excellent (>= 800)', () {
      final vo = ValueCreditScore('820');
      expect(vo.category, CreditScoreCategory.excellent);
    });

    test('debe retornar invalid si hay error', () {
      final vo = ValueCreditScore('invalid');
      expect(vo.category, CreditScoreCategory.invalid);
    });

    test('debe retornar recomendación basada en categoría', () {
      final voExcellent = ValueCreditScore('800');
      expect(voExcellent.recommendation, contains('best'));

      final voPoor = ValueCreditScore('500');
      expect(voPoor.recommendation, contains('improving'));
    });

    test('debe retornar recomendación inválida si falla', () {
      final vo = ValueCreditScore('invalid');
      expect(vo.recommendation, contains('valid credit score'));
    });
  });

  group('ValueInterestRate - Additional Tests', () {
    test('debe convertir coma a punto', () {
      final vo = ValueInterestRate('7,5');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 7.5);
    });

    test('debe validar porcentajes decimales', () {
      final vo = ValueInterestRate('0.25');
      expect(vo.isValid, isTrue);
    });
  });

  group('ValueMoney - Construction & Validation', () {
    test('debe crear dinero válido', () {
      final vo = ValueMoney('1000');
      expect(vo.isValid, isTrue);
      expect(vo.amount, 1000.0);
      expect(vo.symbol, '\$');
    });

    test('debe aceptar símbolo personalizado', () {
      final vo = ValueMoney('1000', symbol: '€');
      expect(vo.isValid, isTrue);
      expect(vo.symbol, '€');
    });

    test('debe aceptar cero como válido', () {
      final vo = ValueMoney('0');
      expect(vo.isValid, isTrue);
    });

    test('debe rechazar valores negativos por defecto', () {
      final vo = ValueMoney('-100');
      expect(vo.isValid, isFalse);
    });

    test('debe respetar mínimo personalizado', () {
      final vo = ValueMoney('5', min: 10.0);
      expect(vo.isValid, isFalse);
    });

    test('debe respetar máximo personalizado', () {
      final vo = ValueMoney('1000', max: 500.0);
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar string vacío', () {
      final vo = ValueMoney('');
      expect(vo.isValid, isFalse);
    });

    test('debe tener factory ValueMoney.zero()', () {
      final vo = ValueMoney.zero();
      expect(vo.isValid, isTrue);
      expect(vo.amount, 0.0);
    });

    test('debe permitir decimales', () {
      final vo = ValueMoney('1234.56');
      expect(vo.isValid, isTrue);
      expect(vo.amount, 1234.56);
    });
  });

  group('ValueMoney - Arithmetic Operations', () {
    test('debe sumar dos montos válidos del mismo símbolo', () {
      final money1 = ValueMoney('100', symbol: '\$');
      final money2 = ValueMoney('50', symbol: '\$');
      final result = money1 + money2;

      expect(result.isValid, isTrue);
      expect(result.amount, 150.0);
      expect(result.symbol, '\$');
    });

    test('debe rechazar suma con símbolo diferente', () {
      final money1 = ValueMoney('100', symbol: '\$');
      final money2 = ValueMoney('50', symbol: '€');
      final result = money1 + money2;

      expect(result.isValid, isFalse);
    });

    test('debe restar dos montos válidos del mismo símbolo', () {
      final money1 = ValueMoney('100', symbol: '\$');
      final money2 = ValueMoney('30', symbol: '\$');
      final result = money1 - money2;

      expect(result.isValid, isTrue);
      expect(result.amount, 70.0);
    });

    test('debe permitir resultado negativo por defecto en resta', () {
      final money1 = ValueMoney('30', symbol: '\$');
      final money2 = ValueMoney('100', symbol: '\$');
      final result = money1 - money2;

      expect(result.isValid, isTrue);
      expect(result.amount, -70.0);
    });

    test('debe rechazar resultado negativo si allowNegative=false', () {
      final money1 = ValueMoney('30', symbol: '\$');
      final money2 = ValueMoney('100', symbol: '\$');
      final result = money1.subtract(money2, allowNegative: false);

      expect(result.isValid, isFalse);
    });

    test('debe rechazar resta con símbolo diferente', () {
      final money1 = ValueMoney('100', symbol: '\$');
      final money2 = ValueMoney('50', symbol: '€');
      final result = money1 - money2;

      expect(result.isValid, isFalse);
    });

    test('debe multiplicar por factor numérico', () {
      final money = ValueMoney('100', symbol: '\$');
      final result = money * 2;

      expect(result.isValid, isTrue);
      expect(result.amount, 200.0);
    });

    test('debe multiplicar por 0.5', () {
      final money = ValueMoney('100', symbol: '\$');
      final result = money * 0.5;

      expect(result.isValid, isTrue);
      expect(result.amount, 50.0);
    });

    test('debe multiplicar por ValuePercentage', () {
      final money = ValueMoney('100', symbol: '\$');
      final percentage = ValuePercentage('10'); // 10%
      final result = money.multiplyByPercentage(percentage);

      expect(result.isValid, isTrue);
      expect(result.amount, 10.0);
    });

    test('debe retornar fallo si ValuePercentage es inválido', () {
      final money = ValueMoney('100', symbol: '\$');
      final percentage = ValuePercentage('150'); // > 100
      final result = money.multiplyByPercentage(percentage);

      expect(result.isValid, isFalse);
    });
  });

  group('ValueMoney - Comparison Operators', () {
    test('debe comparar > correctamente', () {
      final money1 = ValueMoney('100', symbol: '\$');
      final money2 = ValueMoney('50', symbol: '\$');

      expect(money1 > money2, isTrue);
      expect(money2 > money1, isFalse);
    });

    test('debe comparar < correctamente', () {
      final money1 = ValueMoney('50', symbol: '\$');
      final money2 = ValueMoney('100', symbol: '\$');

      expect(money1 < money2, isTrue);
      expect(money2 < money1, isFalse);
    });

    test('debe comparar >= correctamente', () {
      final money1 = ValueMoney('100', symbol: '\$');
      final money2 = ValueMoney('100', symbol: '\$');

      expect(money1 >= money2, isTrue);
    });

    test('debe comparar <= correctamente', () {
      final money1 = ValueMoney('100', symbol: '\$');
      final money2 = ValueMoney('100', symbol: '\$');

      expect(money1 <= money2, isTrue);
    });

    test('debe retornar false en comparación con símbolo diferente', () {
      final money1 = ValueMoney('100', symbol: '\$');
      final money2 = ValueMoney('100', symbol: '€');

      expect(money1 > money2, isFalse);
      expect(money1 < money2, isFalse);
      expect(money1 >= money2, isFalse);
      expect(money1 <= money2, isFalse);
    });

    test('debe retornar false si alguno es inválido', () {
      final validMoney = ValueMoney('100', symbol: '\$');
      final invalidMoney = ValueMoney('invalid', symbol: '\$');

      expect(validMoney > invalidMoney, isFalse);
      expect(invalidMoney > validMoney, isFalse);
    });
  });

  group('ValueMoney - Static Methods', () {
    test('debe sumar lista de montos válidos', () {
      final list = [
        ValueMoney('100', symbol: '\$'),
        ValueMoney('50', symbol: '\$'),
        ValueMoney('25', symbol: '\$'),
      ];

      final result = ValueMoney.sum(list);
      expect(result.isValid, isTrue);
      expect(result.amount, 175.0);
    });

    test('debe retornar cero para lista vacía', () {
      final result = ValueMoney.sum([]);
      expect(result.isValid, isTrue);
      expect(result.amount, 0.0);
    });

    test('debe retornar fallo si hay montos con símbolos diferentes', () {
      final list = [
        ValueMoney('100', symbol: '\$'),
        ValueMoney('50', symbol: '€'),
      ];

      final result = ValueMoney.sum(list);
      expect(result.isValid, isFalse);
    });

    test('debe calcular promedio de lista de montos', () {
      final list = [
        ValueMoney('100', symbol: '\$'),
        ValueMoney('50', symbol: '\$'),
      ];

      final result = ValueMoney.avg(list);
      expect(result.isValid, isTrue);
      expect(result.amount, 75.0);
    });

    test('debe retornar cero para promedio de lista vacía', () {
      final result = ValueMoney.avg([]);
      expect(result.isValid, isTrue);
      expect(result.amount, 0.0);
    });
  });

  group('ValueMoney - Comparable & Sorting', () {
    test('debe implementar Comparable correctamente', () {
      final money1 = ValueMoney('100', symbol: '\$');
      final money2 = ValueMoney('50', symbol: '\$');

      expect(money1.compareTo(money2) > 0, isTrue);
      expect(money2.compareTo(money1) < 0, isTrue);
    });

    test('debe agrupar por moneda en comparación', () {
      final euro = ValueMoney('100', symbol: '€');
      final dollar = ValueMoney('100', symbol: '\$');

      // Comparación por símbolo primero
      expect(dollar.compareTo(euro) < 0, isTrue); // '\$' < '€'
    });

    test('debe retornar 0 si ambos son inválidos', () {
      final invalid1 = ValueMoney('invalid', symbol: '\$');
      final invalid2 = ValueMoney('invalid', symbol: '\$');

      expect(invalid1.compareTo(invalid2), 0);
    });

    test('debe poder ordenar lista de montos', () {
      final list = [
        ValueMoney('30', symbol: '\$'),
        ValueMoney('100', symbol: '\$'),
        ValueMoney('50', symbol: '\$'),
      ];

      list.sort();
      expect(list[0].amount, 30.0);
      expect(list[1].amount, 50.0);
      expect(list[2].amount, 100.0);
    });
  });

  group('ValueMoney - String Representation', () {
    test('debe retornar representación de string válida', () {
      final vo = ValueMoney('100.50', symbol: '\$');
      expect(vo.toString(), '\$100.50');
    });

    test('debe formatear a 2 decimales', () {
      final vo = ValueMoney('100.567', symbol: '€');
      expect(vo.toString(), '€100.57');
    });

    test('debe mostrar mensaje de error si es inválido', () {
      final vo = ValueMoney('invalid', symbol: '\$');
      expect(vo.toString(), contains('Invalid'));
    });
  });

  group('ValueOptionMoney', () {
    test('debe ser válido con null', () {
      final vo = ValueOptionMoney(null);
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isNone(), isTrue);
    });

    test('debe ser válido con string vacío', () {
      final vo = ValueOptionMoney('');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isNone(), isTrue);
    });

    test('debe validar un monto válido', () {
      final vo = ValueOptionMoney('100');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isSome(), isTrue);
    });

    test('debe retornar 0 en amount si es none', () {
      final vo = ValueOptionMoney(null);
      expect(vo.amount, 0.0);
    });

    test('debe retornar símbolo por defecto si es none', () {
      final vo = ValueOptionMoney(null);
      expect(vo.symbol, '\$');
    });

    test('debe tener factory ValueOptionMoney.none()', () {
      final vo = ValueOptionMoney.none();
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isNone(), isTrue);
    });
  });

  group('ValueMoneyIterableX Extension', () {
    test('debe filtrar por moneda', () {
      final list = [
        ValueMoney('100', symbol: '\$'),
        ValueMoney('50', symbol: '€'),
        ValueMoney('75', symbol: '\$'),
      ];

      final filtered = list.whereCurrency('\$').toList();
      expect(filtered.length, 2);
    });

    test('debe sumar con extensión', () {
      final list = [
        ValueMoney('100', symbol: '\$'),
        ValueMoney('50', symbol: '\$'),
      ];

      final sum = list.sum();
      expect(sum.amount, 150.0);
    });

    test('debe promediar con extensión', () {
      final list = [
        ValueMoney('100', symbol: '\$'),
        ValueMoney('50', symbol: '\$'),
      ];

      final avg = list.avg();
      expect(avg.amount, 75.0);
    });

    test('debe encontrar máximo', () {
      final list = [
        ValueMoney('100', symbol: '\$'),
        ValueMoney('50', symbol: '\$'),
        ValueMoney('75', symbol: '\$'),
      ];

      final max = list.maxAmount();
      expect(max.amount, 100.0);
    });

    test('debe encontrar mínimo', () {
      final list = [
        ValueMoney('100', symbol: '\$'),
        ValueMoney('50', symbol: '\$'),
        ValueMoney('75', symbol: '\$'),
      ];

      final min = list.minAmount();
      expect(min.amount, 50.0);
    });

    test('debe retornar cero si lista está vacía', () {
      final list = <ValueMoney>[];

      expect(list.maxAmount().amount, 0.0);
      expect(list.minAmount().amount, 0.0);
    });
  });

  group('ValueROI', () {
    test('debe validar un ROI positivo', () {
      final vo = ValueROI('15.5');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 15.5);
    });

    test('debe validar un ROI negativo', () {
      final vo = ValueROI('-10');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, -10.0);
    });

    test('debe aceptar cero como ROI', () {
      final vo = ValueROI('0');
      expect(vo.isValid, isTrue);
    });

    test('debe aceptar ROI muy alto', () {
      final vo = ValueROI('1000');
      expect(vo.isValid, isTrue);
    });

    test('debe rechazar string vacío', () {
      final vo = ValueROI('');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar texto no numérico', () {
      final vo = ValueROI('abc');
      expect(vo.isValid, isFalse);
    });
  });

  group('ValueDTI', () {
    test('debe validar un DTI válido', () {
      final vo = ValueDTI('35');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 35.0);
    });

    test('debe aceptar DTI de 0', () {
      final vo = ValueDTI('0');
      expect(vo.isValid, isTrue);
    });

    test('debe rechazar DTI negativo', () {
      final vo = ValueDTI('-5');
      expect(vo.isValid, isFalse);
    });

    test('debe aceptar DTI mayor a 100%', () {
      final vo = ValueDTI('150');
      expect(vo.isValid, isTrue);
    });

    test('debe retornar categoría excellent si DTI <= 36%', () {
      final vo = ValueDTI('36');
      expect(vo.category, DTICategory.excellent);
      expect(vo.isExcellent, isTrue);
    });

    test('debe retornar categoría good si 36% < DTI <= 43%', () {
      final vo = ValueDTI('40');
      expect(vo.category, DTICategory.good);
      expect(vo.isAcceptable, isTrue);
      expect(vo.isExcellent, isFalse);
    });

    test('debe retornar categoría highRisk si DTI > 43%', () {
      final vo = ValueDTI('50');
      expect(vo.category, DTICategory.highRisk);
      expect(vo.isExcellent, isFalse);
      expect(vo.isAcceptable, isFalse);
    });

    test('debe retornar categoría invalid si hay error', () {
      final vo = ValueDTI('invalid');
      expect(vo.category, DTICategory.invalid);
    });

    test('debe convertir a fracción correctamente', () {
      final vo = ValueDTI('40');
      expect(vo.asFraction, 0.4);
    });

    test('debe tener statusMessage basado en categoría', () {
      final voExcellent = ValueDTI('30');
      expect(voExcellent.statusMessage, 'Excellent');

      final voRisk = ValueDTI('50');
      expect(voRisk.statusMessage, 'High Risk');
    });
  });

  group('ValueDTI - Calculate from Money', () {
    test('debe calcular DTI correctamente', () {
      final debt = ValueMoney('1000', symbol: '\$');
      final income = ValueMoney('3000', symbol: '\$');

      final dti = ValueDTI.calculate(debt, income);
      expect(dti.isValid, isTrue);
      expect(dti.orCrash, closeTo(33.33, 0.1));
    });

    test('debe rechazar ingreso cero', () {
      final debt = ValueMoney('1000', symbol: '\$');
      final income = ValueMoney('0', symbol: '\$');

      final dti = ValueDTI.calculate(debt, income);
      expect(dti.isValid, isFalse);
    });

    test('debe rechazar monedas diferentes', () {
      final debt = ValueMoney('1000', symbol: '\$');
      final income = ValueMoney('3000', symbol: '€');

      final dti = ValueDTI.calculate(debt, income);
      expect(dti.isValid, isFalse);
    });

    test('debe calcular DTI de 36% (límite excellent)', () {
      final debt = ValueMoney('1080', symbol: '\$');
      final income = ValueMoney('3000', symbol: '\$');

      final dti = ValueDTI.calculate(debt, income);
      expect(dti.isValid, isTrue);
      expect(dti.category, DTICategory.excellent);
    });

    test('debe calcular DTI para caso típico', () {
      final debt = ValueMoney(
        '1500',
        symbol: '\$',
      ); // Mortgage, car, credit cards
      final income = ValueMoney('5000', symbol: '\$'); // Gross monthly income

      final dti = ValueDTI.calculate(debt, income);
      expect(dti.isValid, isTrue);
      expect(dti.orCrash, 30.0);
      expect(dti.category, DTICategory.excellent);
    });
  });

  group('Integration Tests - Finance Scenarios', () {
    test('debe calcular utilidad neta de operación', () {
      final revenue = ValueMoney('10000', symbol: '\$');
      final expenses = ValueMoney('3000', symbol: '\$');

      final profit = revenue - expenses;
      expect(profit.isValid, isTrue);
      expect(profit.amount, 7000.0);
    });

    test('debe calcular ROI en porcentaje', () {
      final investment = ValueMoney('1000', symbol: '\$');
      final gain = ValueMoney('200', symbol: '\$');

      final roi = (gain.amount / investment.amount) * 100;
      expect(roi, 20.0);
    });

    test('debe validar estado crediticio y DTI', () {
      final creditScore = ValueCreditScore('750');
      final dti = ValueDTI('35');

      expect(creditScore.isValid, isTrue);
      expect(dti.isValid, isTrue);
      expect(creditScore.category, CreditScoreCategory.veryGood);
      expect(dti.category, DTICategory.excellent);
    });

    test('debe calcular comisión sobre venta', () {
      final saleAmount = ValueMoney('50000', symbol: '\$');
      final commissionRate = ValuePercentage('5'); // 5%

      final commission = saleAmount.multiplyByPercentage(commissionRate);
      expect(commission.isValid, isTrue);
      expect(commission.amount, 2500.0);
    });

    test('debe manejar múltiples transacciones', () {
      final transactions = [
        ValueMoney('100', symbol: '\$'),
        ValueMoney('250', symbol: '\$'),
        ValueMoney('150', symbol: '\$'),
      ];

      final total = ValueMoney.sum(transactions);
      final average = ValueMoney.avg(transactions);

      expect(total.amount, 500.0);
      expect(average.amount, closeTo(166.67, 0.1));
    });
  });

  group('Edge Cases and Error Handling', () {
    test('ValueMoney debe reportar error si es inválido', () {
      final vo = ValueMoney('invalid');
      expect(vo.isValid, isFalse);
      expect(vo.validate(), isNotNull);
    });

    test('ValueCreditScore debe reportar error si es inválido', () {
      final vo = ValueCreditScore('invalid');
      expect(vo.isValid, isFalse);
      expect(vo.validate(), isNotNull);
    });

    test('ValueDTI debe reportar error si es inválido', () {
      final vo = ValueDTI('invalid');
      expect(vo.isValid, isFalse);
      expect(vo.validate(), isNotNull);
    });

    test('operación con dinero inválido debe retornar inválido', () {
      final valid = ValueMoney('100', symbol: '\$');
      final invalid = ValueMoney('invalid', symbol: '\$');

      expect((valid + invalid).isValid, isFalse);
      expect((invalid - valid).isValid, isFalse);
    });
  });
}
