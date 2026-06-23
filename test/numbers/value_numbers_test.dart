import 'package:test/test.dart';
import 'package:value_objects_pkg/src/core/value_failure.dart';
import 'package:value_objects_pkg/src/numbers/value_numbers.dart';

void main() {
  group('Validation Functions', () {
    group('parseNumeric', () {
      test('debe parsear un string a int correctamente', () {
        final result = parseNumeric<int>('42');
        expect(result.isRight(), isTrue);
        expect(result.getOrElse((_) => 0), 42);
      });

      test('debe parsear un string a double correctamente', () {
        final result = parseNumeric<double>('3.14');
        expect(result.isRight(), isTrue);
        expect(result.getOrElse((_) => 0.0), 3.14);
      });

      test('debe parsear un string con coma como decimal', () {
        final result = parseNumeric<double>('3,14');
        expect(result.isRight(), isTrue);
        expect(result.getOrElse((_) => 0.0), 3.14);
      });

      test('debe retornar left si el string está vacío', () {
        final result = parseNumeric<int>('');
        expect(result.isLeft(), isTrue);
        result.fold(
          (f) => expect(f, isA<StrEmpty>()),
          (_) => fail('Debería fallar'),
        );
      });

      test('debe retornar left si el string contiene solo espacios', () {
        final result = parseNumeric<double>('   ');
        expect(result.isLeft(), isTrue);
      });

      test('debe retornar left si el string no es un número válido', () {
        final result = parseNumeric<int>('abc');
        expect(result.isLeft(), isTrue);
        result.fold(
          (f) => expect(f, isA<NotANumber>()),
          (_) => fail('Debería fallar'),
        );
      });

      test('debe retornar left si el string tiene caracteres inválidos', () {
        final result = parseNumeric<double>('12.34.56');
        expect(result.isLeft(), isTrue);
      });
    });

    group('validateMin', () {
      test('debe aceptar un valor mayor al mínimo', () {
        final result = validateMin(10, 5);
        expect(result.isRight(), isTrue);
        expect(result.getOrElse((_) => 0), 10);
      });

      test('debe aceptar un valor igual al mínimo (no strict)', () {
        final result = validateMin(5, 5);
        expect(result.isRight(), isTrue);
      });

      test('debe rechazar un valor menor al mínimo', () {
        final result = validateMin(3, 5);
        expect(result.isLeft(), isTrue);
      });

      test('debe rechazar un valor igual al mínimo si strict=true', () {
        final result = validateMin(5, 5, strict: true);
        expect(result.isLeft(), isTrue);
      });

      test('debe funcionar con doubles', () {
        final result = validateMin(5.5, 5.0);
        expect(result.isRight(), isTrue);
      });
    });

    group('validateMax', () {
      test('debe aceptar un valor menor al máximo', () {
        final result = validateMax(5, 10);
        expect(result.isRight(), isTrue);
      });

      test('debe aceptar un valor igual al máximo', () {
        final result = validateMax(10, 10);
        expect(result.isRight(), isTrue);
      });

      test('debe rechazar un valor mayor al máximo', () {
        final result = validateMax(15, 10);
        expect(result.isLeft(), isTrue);
      });

      test('debe funcionar con doubles', () {
        final result = validateMax(3.14, 5.0);
        expect(result.isRight(), isTrue);
      });
    });

    group('validatePositive', () {
      test('debe aceptar un valor positivo', () {
        final result = validatePositive(5);
        expect(result.isRight(), isTrue);
      });

      test('debe rechazar cero', () {
        final result = validatePositive(0);
        expect(result.isLeft(), isTrue);
      });

      test('debe rechazar valores negativos', () {
        final result = validatePositive(-5);
        expect(result.isLeft(), isTrue);
      });

      test('debe funcionar con doubles positivos', () {
        final result = validatePositive(0.1);
        expect(result.isRight(), isTrue);
      });
    });

    group('validateNonNegative', () {
      test('debe aceptar un valor positivo', () {
        final result = validateNonNegative(5);
        expect(result.isRight(), isTrue);
      });

      test('debe aceptar cero', () {
        final result = validateNonNegative(0);
        expect(result.isRight(), isTrue);
      });

      test('debe rechazar valores negativos', () {
        final result = validateNonNegative(-5);
        expect(result.isLeft(), isTrue);
      });

      test('debe funcionar con doubles no negativos', () {
        final result = validateNonNegative(0.0);
        expect(result.isRight(), isTrue);
      });
    });
  });

  group('ValueNumber', () {
    test('debe validar un número válido', () {
      final vo = ValueNumber('42');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 42);
    });

    test('debe validar un número decimal', () {
      final vo = ValueNumber('3.14');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 3.14);
    });

    test('debe fallar con string vacío', () {
      final vo = ValueNumber('');
      expect(vo.isValid, isFalse);
    });

    test('debe fallar con texto no numérico', () {
      final vo = ValueNumber('abc');
      expect(vo.isValid, isFalse);
    });

    test('debe validar límite mínimo', () {
      final voValid = ValueNumber('10', min: 5);
      expect(voValid.isValid, isTrue);

      final voInvalid = ValueNumber('3', min: 5);
      expect(voInvalid.isValid, isFalse);
    });

    test('debe validar límite máximo', () {
      final voValid = ValueNumber('10', max: 20);
      expect(voValid.isValid, isTrue);

      final voInvalid = ValueNumber('25', max: 20);
      expect(voInvalid.isValid, isFalse);
    });

    test('debe validar rango min y max', () {
      final voValid = ValueNumber('15', min: 10, max: 20);
      expect(voValid.isValid, isTrue);

      final voInvalidLow = ValueNumber('5', min: 10, max: 20);
      expect(voInvalidLow.isValid, isFalse);

      final voInvalidHigh = ValueNumber('25', min: 10, max: 20);
      expect(voInvalidHigh.isValid, isFalse);
    });

    test('debe aceptar validación personalizada', () {
      final vo = ValueNumber(
        '5',
        customValidate: (either) {
          return either.fold(
            (f) => 'Error: ${f.toString()}',
            (v) => v < 10 ? 'Debe ser al menos 10' : null,
          );
        },
      );
      expect(vo.validate(), 'Debe ser al menos 10');
    });
  });

  group('ValueOptionNumber', () {
    test('debe ser válido con null', () {
      final vo = ValueOptionNumber(null);
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isNone(), isTrue);
    });

    test('debe ser válido con string vacío', () {
      final vo = ValueOptionNumber('');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isNone(), isTrue);
    });

    test('debe validar un número válido', () {
      final vo = ValueOptionNumber('42');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isSome(), isTrue);
      expect(vo.orCrash.fold(() => 0, (v) => v), 42);
    });

    test('debe retornar 0 con orZero si es none', () {
      final vo = ValueOptionNumber(null);
      expect(vo.orZero, 0);
    });

    test('debe retornar el valor con orZero si es some', () {
      final vo = ValueOptionNumber('42');
      expect(vo.orZero, 42);
      expect(vo.orCrash.fold(() => 0, (v) => v), 42);
    });

    test('debe retornar 0 con orZero si hay error', () {
      final vo = ValueOptionNumber('abc');
      expect(vo.orZero, 0);
    });

    test('debe validar límites min y max', () {
      final vo = ValueOptionNumber('15', min: 10, max: 20);
      expect(vo.isValid, isTrue);
    });
  });

  group('ValueNonNegativeNumber', () {
    test('debe aceptar un número positivo', () {
      final vo = ValueNonNegativeNumber('42');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 42);
    });

    test('debe aceptar cero', () {
      final vo = ValueNonNegativeNumber('0');
      expect(vo.isValid, isTrue);
    });

    test('debe rechazar un número negativo', () {
      final vo = ValueNonNegativeNumber('-5');
      expect(vo.isValid, isFalse);
    });

    test('debe validar máximo', () {
      final voValid = ValueNonNegativeNumber('10', max: 20);
      expect(voValid.isValid, isTrue);

      final voInvalid = ValueNonNegativeNumber('25', max: 20);
      expect(voInvalid.isValid, isFalse);
    });
  });

  group('ValuePositiveNumber', () {
    test('debe aceptar un número positivo', () {
      final vo = ValuePositiveNumber('42');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 42);
    });

    test('debe rechazar cero', () {
      final vo = ValuePositiveNumber('0');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar un número negativo', () {
      final vo = ValuePositiveNumber('-5');
      expect(vo.isValid, isFalse);
    });

    test('debe validar máximo', () {
      final voValid = ValuePositiveNumber('10', max: 20);
      expect(voValid.isValid, isTrue);

      final voInvalid = ValuePositiveNumber('25', max: 20);
      expect(voInvalid.isValid, isFalse);
    });
  });

  group('ValueInt', () {
    test('debe parsear un entero válido', () {
      final vo = ValueInt('42');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 42);
    });

    test('debe rechazar decimales', () {
      final vo = ValueInt('3.14');
      expect(vo.isValid, isFalse);
    });

    test('debe validar límites', () {
      final vo = ValueInt('42', min: 10, max: 50);
      expect(vo.isValid, isTrue);
    });

    test('debe rechazar si está fuera de límites', () {
      final vo = ValueInt('100', min: 10, max: 50);
      expect(vo.isValid, isFalse);
    });
  });

  group('ValueOptionInt', () {
    test('debe ser válido con null', () {
      final vo = ValueOptionInt(null);
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isNone(), isTrue);
    });

    test('debe validar un entero válido', () {
      final vo = ValueOptionInt('42');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isSome(), isTrue);
      expect(vo.orCrash.fold(() => 0, (v) => v), 42);
    });

    test('debe rechazar decimales', () {
      final vo = ValueOptionInt('3.14');
      expect(vo.isValid, isFalse);
    });

    test('debe validar límites', () {
      final vo = ValueOptionInt('42', min: 10, max: 50);
      expect(vo.isValid, isTrue);
    });
  });

  group('ValueNonNegativeInt', () {
    test('debe aceptar un entero positivo', () {
      final vo = ValueNonNegativeInt('42');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 42);
    });

    test('debe aceptar cero', () {
      final vo = ValueNonNegativeInt('0');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 0);
    });

    test('debe rechazar un entero negativo', () {
      final vo = ValueNonNegativeInt('-5');
      expect(vo.isValid, isFalse);
    });

    test('debe aceptar validación personalizada', () {
      final vo = ValueNonNegativeInt(
        '100',
        customValidate: (either) {
          return either.fold(
            (f) => 'Error',
            (v) => v > 1000 ? 'Muy alto' : null,
          );
        },
      );
      expect(vo.validate(), isNull);
    });
  });

  group('ValueOptionNonNegativeInt', () {
    test('debe ser válido con null', () {
      final vo = ValueOptionNonNegativeInt(null);
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isNone(), isTrue);
    });

    test('debe validar un entero no negativo', () {
      final vo = ValueOptionNonNegativeInt('42');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isSome(), isTrue);
    });

    test('debe rechazar enteros negativos', () {
      final vo = ValueOptionNonNegativeInt('-5');
      expect(vo.isValid, isFalse);
    });
  });

  group('ValuePositiveInt', () {
    test('debe aceptar un entero positivo', () {
      final vo = ValuePositiveInt('42');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 42);
    });

    test('debe rechazar cero', () {
      final vo = ValuePositiveInt('0');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar enteros negativos', () {
      final vo = ValuePositiveInt('-5');
      expect(vo.isValid, isFalse);
    });

    test('debe validar máximo', () {
      final voValid = ValuePositiveInt('10', max: 20);
      expect(voValid.isValid, isTrue);

      final voInvalid = ValuePositiveInt('25', max: 20);
      expect(voInvalid.isValid, isFalse);
    });

    test('debe aceptar validación personalizada', () {
      final vo = ValuePositiveInt(
        '5',
        customValidate: (either) {
          return either.fold(
            (f) => 'Error',
            (v) => v < 10 ? 'Debe ser al menos 10' : null,
          );
        },
      );
      expect(vo.validate(), 'Debe ser al menos 10');
    });
  });

  group('ValueOptionPositiveInt', () {
    test('debe ser válido con null', () {
      final vo = ValueOptionPositiveInt(null);
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isNone(), isTrue);
    });

    test('debe validar un entero positivo', () {
      final vo = ValueOptionPositiveInt('42');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isSome(), isTrue);
      expect(vo.orCrash.fold(() => 0, (v) => v), 42);
    });

    test('debe rechazar cero', () {
      final vo = ValueOptionPositiveInt('0');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar enteros negativos', () {
      final vo = ValueOptionPositiveInt('-5');
      expect(vo.isValid, isFalse);
    });

    test('debe validar máximo', () {
      final vo = ValueOptionPositiveInt('42', max: 50);
      expect(vo.isValid, isTrue);
    });
  });

  group('ValueDecimal', () {
    test('debe validar un decimal válido', () {
      final vo = ValueDecimal('3.14');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 3.14);
    });

    test('debe convertir coma a punto', () {
      final vo = ValueDecimal('3,14');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 3.14);
    });

    test('debe validar límites', () {
      final vo = ValueDecimal('3.14', min: 0.0, max: 10.0);
      expect(vo.isValid, isTrue);
    });

    test('debe rechazar si está fuera de límites', () {
      final vo = ValueDecimal('15.5', min: 0.0, max: 10.0);
      expect(vo.isValid, isFalse);
    });
  });

  group('ValueNonNegativeDecimal', () {
    test('debe aceptar un decimal positivo', () {
      final vo = ValueNonNegativeDecimal('3.14');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 3.14);
    });

    test('debe aceptar cero', () {
      final vo = ValueNonNegativeDecimal('0.0');
      expect(vo.isValid, isTrue);
    });

    test('debe rechazar decimales negativos', () {
      final vo = ValueNonNegativeDecimal('-3.14');
      expect(vo.isValid, isFalse);
    });

    test('debe validar máximo', () {
      final voValid = ValueNonNegativeDecimal('50.0', max: 100.0);
      expect(voValid.isValid, isTrue);

      final voInvalid = ValueNonNegativeDecimal('150.0', max: 100.0);
      expect(voInvalid.isValid, isFalse);
    });
  });

  group('ValuePositiveDecimal', () {
    test('debe aceptar un decimal positivo', () {
      final vo = ValuePositiveDecimal('3.14');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 3.14);
    });

    test('debe rechazar cero', () {
      final vo = ValuePositiveDecimal('0.0');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar decimales negativos', () {
      final vo = ValuePositiveDecimal('-3.14');
      expect(vo.isValid, isFalse);
    });

    test('debe validar máximo', () {
      final voValid = ValuePositiveDecimal('50.0', max: 100.0);
      expect(voValid.isValid, isTrue);

      final voInvalid = ValuePositiveDecimal('150.0', max: 100.0);
      expect(voInvalid.isValid, isFalse);
    });
  });

  group('ValuePercentage', () {
    test('debe aceptar un porcentaje válido', () {
      final vo = ValuePercentage('50.0');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 50.0);
    });

    test('debe aceptar 0%', () {
      final vo = ValuePercentage('0.0');
      expect(vo.isValid, isTrue);
    });

    test('debe aceptar 100%', () {
      final vo = ValuePercentage('100.0');
      expect(vo.isValid, isTrue);
    });

    test('debe rechazar valores mayores a 100', () {
      final vo = ValuePercentage('150.0');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar valores negativos', () {
      final vo = ValuePercentage('-10.0');
      expect(vo.isValid, isFalse);
    });

    test('debe convertir a fracción correctamente', () {
      final vo = ValuePercentage('50.0');
      expect(vo.asFraction, 0.5);
    });

    test('debe retornar 0 como fracción si hay error', () {
      final vo = ValuePercentage('150.0');
      expect(vo.asFraction, 0.0);
    });

    test('debe calcular fracciones correctamente', () {
      final vo5 = ValuePercentage('5.0');
      expect(vo5.asFraction, 0.05);

      final vo25 = ValuePercentage('25.0');
      expect(vo25.asFraction, 0.25);

      final vo100 = ValuePercentage('100.0');
      expect(vo100.asFraction, 1.0);
    });
  });

  group('ValueOptionPercentage', () {
    test('debe ser válido con null', () {
      final vo = ValueOptionPercentage(null);
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isNone(), isTrue);
    });

    test('debe ser válido con string vacío', () {
      final vo = ValueOptionPercentage('');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isNone(), isTrue);
    });

    test('debe validar un porcentaje válido', () {
      final vo = ValueOptionPercentage('50.0');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isSome(), isTrue);
    });

    test('debe rechazar porcentajes mayores a 100', () {
      final vo = ValueOptionPercentage('150.0');
      expect(vo.isValid, isFalse);
    });

    test('debe retornar 0 como fracción si es none', () {
      final vo = ValueOptionPercentage(null);
      expect(vo.asFraction, 0.0);
    });

    test('debe retornar fracción correcta si es some', () {
      final vo = ValueOptionPercentage('50.0');
      expect(vo.asFraction, 0.5);
    });

    test('debe retornar 0 como fracción si hay error', () {
      final vo = ValueOptionPercentage('abc');
      expect(vo.asFraction, 0.0);
    });
  });

  group('ValueOptionDecimal', () {
    test('debe ser válido con null', () {
      final vo = ValueOptionDecimal(null);
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isNone(), isTrue);
    });

    test('debe ser válido con string vacío', () {
      final vo = ValueOptionDecimal('');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isNone(), isTrue);
    });

    test('debe validar un decimal válido', () {
      final vo = ValueOptionDecimal('3.14');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isSome(), isTrue);
      expect(vo.orCrash.fold(() => 0.0, (v) => v), 3.14);
    });

    test('debe validar límites', () {
      final vo = ValueOptionDecimal('5.5', min: 0.0, max: 10.0);
      expect(vo.isValid, isTrue);
    });

    test('debe rechazar si está fuera de límites', () {
      final vo = ValueOptionDecimal('15.5', min: 0.0, max: 10.0);
      expect(vo.isValid, isFalse);
    });
  });
}
