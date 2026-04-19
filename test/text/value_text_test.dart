import 'package:flutter_test/flutter_test.dart';
import 'package:value_objects_pkg/src/core/value_failure.dart';
import 'package:value_objects_pkg/src/text/value_text.dart';

void main() {
  group('Validation Functions (Top-Level)', () {
    group('validateNotEmpty', () {
      test('debe retornar right cuando el texto no está vacío', () {
        final result = validateNotEmpty('Hola Mundo');
        expect(result.isRight(), isTrue);
        expect(result.getOrElse((_) => ''), 'Hola Mundo');
      });

      test(
        'debe hacer trim y retornar left si el texto está compuesto solo de espacios',
        () {
          final result = validateNotEmpty('   ');
          expect(result.isLeft(), isTrue);
          result.fold(
            (f) => expect(f, isA<StrEmpty>()),
            (_) => fail('Debería fallar'),
          );
        },
      );
    });

    group('validateMaxLength & validateMinLength', () {
      test('debe validar la longitud correctamente', () {
        expect(validateMaxLength('Hola', 10).isRight(), isTrue);
        expect(validateMaxLength('Hola', 4).isRight(), isTrue);

        final failMax = validateMaxLength('Hola Mundo', 5);
        expect(failMax.isLeft(), isTrue);
        failMax.fold((f) => expect(f, isA<StrMaxLength>()), (_) => fail(''));

        expect(validateMinLength('Hola', 2).isRight(), isTrue);

        final failMin = validateMinLength('H', 3);
        expect(failMin.isLeft(), isTrue);
        failMin.fold((f) => expect(f, isA<StrMinLength>()), (_) => fail(''));
      });
    });

    group('validateSingleLine', () {
      test('debe retornar right si no tiene saltos de línea', () {
        expect(validateSingleLine('Una sola línea').isRight(), isTrue);
      });

      test('debe retornar left si contiene saltos de línea', () {
        expect(validateSingleLine('Dos\nlíneas').isLeft(), isTrue);
      });
    });

    group('validateUrlFormat', () {
      test('debe aceptar URLs absolutas http/https válidas', () {
        expect(validateUrlFormat('https://google.com').isRight(), isTrue);
        expect(validateUrlFormat('http://localhost:8080').isRight(), isTrue);
      });

      test('debe aceptar paths locales o assets', () {
        expect(validateUrlFormat('assets/images/logo.png').isRight(), isTrue);
        expect(validateUrlFormat('packages/my_pkg/icon.png').isRight(), isTrue);
      });

      test('debe rechazar formatos de URL inválidos', () {
        expect(validateUrlFormat('no-es-una-url').isLeft(), isTrue);
        expect(validateUrlFormat('ftp://invalid.com').isLeft(), isTrue);
      });
    });

    group('validatePersonalName', () {
      test('debe aceptar nombres válidos con acentos y espacios', () {
        expect(validatePersonalName('Iván').isRight(), isTrue);
        expect(validatePersonalName('Maria José').isRight(), isTrue);
        expect(validatePersonalName('Jean-Luc').isRight(), isTrue);
      });

      test('debe rechazar nombres con números o caracteres extraños', () {
        expect(validatePersonalName('Iván123').isLeft(), isTrue);
        expect(validatePersonalName('Maria@José').isLeft(), isTrue);
      });
    });

    group('validatePassword', () {
      test('debe aceptar una contraseña válida', () {
        final result = validatePassword('Valid123!');
        expect(result.isRight(), isTrue);
      });

      test('debe fallar si no cumple la complejidad', () {
        // Sin mayúsculas
        expect(validatePassword('invalid123!').isLeft(), isTrue);
        // Sin minúsculas
        expect(validatePassword('INVALID123!').isLeft(), isTrue);
        // Sin números
        expect(validatePassword('InvalidPwd!').isLeft(), isTrue);
        // Sin caracteres especiales
        expect(validatePassword('Invalid1234').isLeft(), isTrue);
        // Muy corta
        expect(validatePassword('Val1!').isLeft(), isTrue);
      });
    });

    group('Text Content Utilities (Starts With / Contains / Alpha)', () {
      test('validateOnlyAlphabetical funciona correctamente', () {
        expect(validateOnlyAlphabetical('Hola').isRight(), isTrue);
        expect(validateOnlyAlphabetical('Hola123').isLeft(), isTrue);
      });

      test('validateContainsSubstring funciona correctamente', () {
        expect(
          validateContainsSubstring('Flutter is awesome', 'utter').isRight(),
          isTrue,
        );
        expect(
          validateContainsSubstring(
            'Flutter is awesome',
            'Utter',
            caseSensitive: true,
          ).isLeft(),
          isTrue,
        );
      });

      test('validateStartsWith funciona correctamente', () {
        expect(validateStartsWith('Flutter App', 'Flu').isRight(), isTrue);
        expect(validateStartsWith('Flutter App', 'App').isLeft(), isTrue);
      });
    });
  });

  group('Value Objects', () {
    group('ValueSingleLine', () {
      test('debe ser válido para una sola línea', () {
        final vo = ValueSingleLine('Texto válido');
        expect(vo.isValid, isTrue);
        expect(vo.orCrash, 'Texto válido');
      });

      test('debe fallar si está vacío', () {
        final vo = ValueSingleLine('');
        expect(vo.isValid, isFalse);
        expect(vo.validate(), isNotNull);
      });

      test('debe fallar si es multilínea', () {
        final vo = ValueSingleLine('Línea 1\nLínea 2');
        expect(vo.isValid, isFalse);
      });

      test('debe fallar si excede el max length', () {
        final vo = ValueSingleLine('A' * 150, max: 100);
        expect(vo.isValid, isFalse);
      });
    });

    group('ValueMultipleLine', () {
      test('debe aceptar textos con saltos de línea', () {
        final vo = ValueMultipleLine('Línea 1\nLínea 2');
        expect(vo.isValid, isTrue);
      });

      test('debe fallar si excede el max length', () {
        final vo = ValueMultipleLine('A' * 601);
        expect(vo.isValid, isFalse);
      });
    });

    group('Optional Texts', () {
      test(
        'ValueOptionSingleLine es válido (como none) cuando se pasa null o vacío',
        () {
          final voNull = ValueOptionSingleLine(null);
          expect(voNull.isValid, isTrue);
          expect(voNull.orCrash.isNone(), isTrue);

          final voEmpty = ValueOptionSingleLine('');
          expect(voEmpty.isValid, isTrue);
          expect(voEmpty.orCrash.isNone(), isTrue);
        },
      );

      test('ValueOptionSingleLine valida normalmente si se pasa un valor', () {
        final voValid = ValueOptionSingleLine('Hola');
        expect(voValid.isValid, isTrue);
        expect(voValid.orCrash.isSome(), isTrue);

        final voInvalid = ValueOptionSingleLine('Hola\nMundo');
        expect(voInvalid.isValid, isFalse);
      });

      test('ValueOptionMultipleLine funciona correctamente', () {
        final vo = ValueOptionMultipleLine('Hola\nMundo');
        expect(vo.isValid, isTrue);
      });
    });

    group('ValueUrl & ValueOptionUrl', () {
      test('ValueUrl debe ser válido con URL válida', () {
        final vo = ValueUrl('https://flutter.dev');
        expect(vo.isValid, isTrue);
        expect(vo.orCrash.host, 'flutter.dev');
      });

      test('ValueUrl debe fallar con texto aleatorio', () {
        final vo = ValueUrl('solo-texto');
        expect(vo.isValid, isFalse);
      });

      test('ValueOptionUrl debe manejar null correctamente', () {
        final vo = ValueOptionUrl(null);
        expect(vo.isValid, isTrue);
        expect(vo.orEmpty, '');
      });

      test(
        'ValueOptionUrl debe manejar un path local correctamente y orEmpty devolverá su ruta',
        () {
          final vo = ValueOptionUrl('assets/logo.png');
          expect(vo.isValid, isTrue);
          expect(vo.orEmpty, 'assets/logo.png');
        },
      );
    });
  });
}
