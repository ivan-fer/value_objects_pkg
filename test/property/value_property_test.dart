import 'package:test/test.dart';
import 'package:value_objects_pkg/src/property/value_property.dart';

void main() {
  group('ValueSqFt', () {
    test('debe validar una superficie válida en pies cuadrados', () {
      final vo = ValueSqFt('2500');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 2500.0);
    });

    test('debe validar superficie con decimales', () {
      final vo = ValueSqFt('1500.5');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 1500.5);
    });

    test('debe aceptar cero como superficie válida', () {
      final vo = ValueSqFt('0');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 0.0);
    });

    test('debe rechazar valores negativos', () {
      final vo = ValueSqFt('-100');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar string vacío', () {
      final vo = ValueSqFt('');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar texto no numérico', () {
      final vo = ValueSqFt('abc');
      expect(vo.isValid, isFalse);
    });

    test('debe validar máximo si se proporciona', () {
      final voValid = ValueSqFt('2000', max: 3000);
      expect(voValid.isValid, isTrue);

      final voInvalid = ValueSqFt('4000', max: 3000);
      expect(voInvalid.isValid, isFalse);
    });

    test('debe convertir a acres correctamente', () {
      final vo = ValueSqFt('43560');
      expect(vo.isValid, isTrue);
      expect(vo.toAcres, 1.0);
    });

    test('debe convertir superficie pequeña a fracción de acre', () {
      final vo = ValueSqFt('21780');
      expect(vo.isValid, isTrue);
      expect(vo.toAcres, 0.5);
    });

    test('debe retornar 0 en toAcres si hay error', () {
      final vo = ValueSqFt('invalid');
      expect(vo.toAcres, 0.0);
    });

    test('debe convertir cero a cero acres', () {
      final vo = ValueSqFt('0');
      expect(vo.toAcres, 0.0);
    });

    test('debe manejar grandes superficies', () {
      final vo = ValueSqFt('435600');
      expect(vo.isValid, isTrue);
      expect(vo.toAcres, 10.0);
    });

    test('debe convertir coma a punto', () {
      final vo = ValueSqFt('1500,5');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 1500.5);
    });
  });

  group('ValueAcres', () {
    test('debe validar una superficie válida en acres', () {
      final vo = ValueAcres('2.5');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 2.5);
    });

    test('debe validar acres como entero', () {
      final vo = ValueAcres('5');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 5.0);
    });

    test('debe aceptar cero como valor válido', () {
      final vo = ValueAcres('0');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 0.0);
    });

    test('debe rechazar valores negativos', () {
      final vo = ValueAcres('-2.5');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar string vacío', () {
      final vo = ValueAcres('');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar texto no numérico', () {
      final vo = ValueAcres('abc');
      expect(vo.isValid, isFalse);
    });

    test('debe validar máximo si se proporciona', () {
      final voValid = ValueAcres('1.5', max: 5.0);
      expect(voValid.isValid, isTrue);

      final voInvalid = ValueAcres('10', max: 5.0);
      expect(voInvalid.isValid, isFalse);
    });

    test('debe convertir a pies cuadrados correctamente', () {
      final vo = ValueAcres('1');
      expect(vo.isValid, isTrue);
      expect(vo.toSqFt, 43560.0);
    });

    test('debe convertir fracción de acre a pies cuadrados', () {
      final vo = ValueAcres('0.5');
      expect(vo.isValid, isTrue);
      expect(vo.toSqFt, 21780.0);
    });

    test('debe retornar 0 en toSqFt si hay error', () {
      final vo = ValueAcres('invalid');
      expect(vo.toSqFt, 0.0);
    });

    test('debe convertir cero a cero pies cuadrados', () {
      final vo = ValueAcres('0');
      expect(vo.toSqFt, 0.0);
    });

    test('debe manejar grandes áreas', () {
      final vo = ValueAcres('10');
      expect(vo.isValid, isTrue);
      expect(vo.toSqFt, 435600.0);
    });

    test('debe convertir coma a punto', () {
      final vo = ValueAcres('2,5');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 2.5);
    });

    test('debe ser válido con máximo muy grande', () {
      final vo = ValueAcres('1000', max: 10000);
      expect(vo.isValid, isTrue);
    });
  });

  group('ValueOptionAcres', () {
    test('debe ser válido con null', () {
      final vo = ValueOptionAcres(null);
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isNone(), isTrue);
    });

    test('debe ser válido con string vacío', () {
      final vo = ValueOptionAcres('');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isNone(), isTrue);
    });

    test('debe ser válido con espacios solo', () {
      final vo = ValueOptionAcres('   ');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isNone(), isTrue);
    });

    test('debe validar un valor de acres válido', () {
      final vo = ValueOptionAcres('2.5');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isSome(), isTrue);
      expect(vo.orCrash.fold(() => 0.0, (v) => v), 2.5);
    });

    test('debe aceptar cero como valor válido', () {
      final vo = ValueOptionAcres('0');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isSome(), isTrue);
    });

    test('debe rechazar valores negativos', () {
      final vo = ValueOptionAcres('-2.5');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar texto no numérico', () {
      final vo = ValueOptionAcres('abc');
      expect(vo.isValid, isFalse);
    });

    test('debe validar máximo si se proporciona', () {
      final voValid = ValueOptionAcres('1.5', max: 5.0);
      expect(voValid.isValid, isTrue);

      final voInvalid = ValueOptionAcres('10', max: 5.0);
      expect(voInvalid.isValid, isFalse);
    });

    test('debe convertir coma a punto', () {
      final vo = ValueOptionAcres('2,5');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.fold(() => 0.0, (v) => v), 2.5);
    });

    test('debe tener mensaje de error apropiado si falla', () {
      final vo = ValueOptionAcres('-5');
      expect(vo.isValid, isFalse);
      expect(vo.validate(), isNotNull);
    });
  });

  group('ValueYearBuilt', () {
    test('debe validar un año razonable actual', () {
      final currentYear = DateTime.now().year;
      final vo = ValueYearBuilt(currentYear.toString());
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, currentYear);
    });

    test('debe validar años históricos válidos', () {
      final vo1 = ValueYearBuilt('1900');
      expect(vo1.isValid, isTrue);

      final vo2 = ValueYearBuilt('1500');
      expect(vo2.isValid, isTrue);

      final vo3 = ValueYearBuilt('1000');
      expect(vo3.isValid, isTrue);
    });

    test('debe rechazar años anteriores a 1000', () {
      final vo = ValueYearBuilt('999');
      expect(vo.isValid, isFalse);
    });

    test('debe aceptar años futuros cercanos', () {
      final futureYear = DateTime.now().year + 5;
      final vo = ValueYearBuilt(futureYear.toString());
      expect(vo.isValid, isTrue);
    });

    test(
      'debe aceptar año exactamente en el límite superior (actual + 10)',
      () {
        final maxYear = DateTime.now().year + 10;
        final vo = ValueYearBuilt(maxYear.toString());
        expect(vo.isValid, isTrue);
      },
    );

    test('debe rechazar años demasiado futuros', () {
      final tooFarFuture = DateTime.now().year + 11;
      final vo = ValueYearBuilt(tooFarFuture.toString());
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar string vacío', () {
      final vo = ValueYearBuilt('');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar texto no numérico', () {
      final vo = ValueYearBuilt('abc');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar decimales (año debe ser entero)', () {
      final vo = ValueYearBuilt('2000.5');
      expect(vo.isValid, isFalse);
    });

    test('debe validar un año típico de construcción moderna', () {
      final vo = ValueYearBuilt('2020');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 2020);
    });

    test('debe validar años del siglo pasado', () {
      final vo = ValueYearBuilt('1980');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 1980);
    });

    test('debe validar años muy antiguos pero válidos', () {
      final vo = ValueYearBuilt('1750');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 1750);
    });

    test('debe rechazar año negativo', () {
      final vo = ValueYearBuilt('-2000');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar cero como año', () {
      final vo = ValueYearBuilt('0');
      expect(vo.isValid, isFalse);
    });

    test('debe convertir coma a punto en entrada (aunque sea inválida)', () {
      final vo = ValueYearBuilt('2000,5');
      // Como parseNumeric convierte coma a punto, se convierte a 2000.5
      // Y como el tipo es int, int.tryParse('2000.5') retorna null
      expect(vo.isValid, isFalse);
    });

    test('debe validar rango completo de años válidos', () {
      final minYear = 1000;
      final maxYear = DateTime.now().year + 10;

      final voMin = ValueYearBuilt(minYear.toString());
      expect(voMin.isValid, isTrue);

      final voMid = ValueYearBuilt('1950');
      expect(voMid.isValid, isTrue);

      final voMax = ValueYearBuilt(maxYear.toString());
      expect(voMax.isValid, isTrue);
    });
  });

  group('Conversiones Bidireccionales', () {
    test('SqFt -> Acres -> SqFt debe retornar el valor original', () {
      final vo = ValueSqFt('43560');
      expect(vo.isValid, isTrue);

      final acres = vo.toAcres;
      final voAcres = ValueAcres(acres.toString());
      expect(voAcres.isValid, isTrue);

      // Puede haber pequeña pérdida de precisión por conversión de strings
      expect(voAcres.toSqFt, closeTo(43560.0, 0.1));
    });

    test('Acres -> SqFt -> Acres debe retornar el valor original', () {
      final vo = ValueAcres('2.5');
      expect(vo.isValid, isTrue);

      final sqFt = vo.toSqFt;
      final voSqFt = ValueSqFt(sqFt.toString());
      expect(voSqFt.isValid, isTrue);

      expect(voSqFt.toAcres, closeTo(2.5, 0.0001));
    });

    test('Conversión precisa: 1 acre = 43,560 sq ft', () {
      final voAcres = ValueAcres('1');
      expect(voAcres.isValid, isTrue);
      expect(voAcres.toSqFt, 43560.0);

      final voSqFt = ValueSqFt('43560');
      expect(voSqFt.isValid, isTrue);
      expect(voSqFt.toAcres, 1.0);
    });

    test('Conversión precisa: 0.5 acres = 21,780 sq ft', () {
      final voAcres = ValueAcres('0.5');
      expect(voAcres.isValid, isTrue);
      expect(voAcres.toSqFt, 21780.0);

      final voSqFt = ValueSqFt('21780');
      expect(voSqFt.isValid, isTrue);
      expect(voSqFt.toAcres, 0.5);
    });
  });

  group('Edge Cases y Validación de Errores', () {
    test('ValueSqFt debe reportar error si es inválido', () {
      final vo = ValueSqFt('invalid');
      expect(vo.isValid, isFalse);
      expect(vo.validate(), isNotNull);
    });

    test('ValueAcres debe reportar error si es inválido', () {
      final vo = ValueAcres('invalid');
      expect(vo.isValid, isFalse);
      expect(vo.validate(), isNotNull);
    });

    test('ValueOptionAcres debe reportar error si es inválido', () {
      final vo = ValueOptionAcres('invalid');
      expect(vo.isValid, isFalse);
      expect(vo.validate(), isNotNull);
    });

    test('ValueYearBuilt debe reportar error si es inválido', () {
      final vo = ValueYearBuilt('invalid');
      expect(vo.isValid, isFalse);
      expect(vo.validate(), isNotNull);
    });

    test('ValueSqFt debe manejar números muy grandes', () {
      final vo = ValueSqFt('1000000');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 1000000.0);
    });

    test('ValueAcres debe manejar números muy grandes', () {
      final vo = ValueAcres('1000');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 1000.0);
    });

    test('ValueYearBuilt debe validar múltiples épocas', () {
      final years = ['1066', '1492', '1776', '1920', '1969', '2000', '2024'];
      for (final year in years) {
        final vo = ValueYearBuilt(year);
        expect(vo.isValid, isTrue, reason: 'Year $year should be valid');
      }
    });
  });
}
