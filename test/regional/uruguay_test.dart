import 'package:test/test.dart';
import 'package:value_objects_pkg/uruguay.dart';

void main() {
  group('ValueCedula', () {
    test('acepta una cédula válida de 8 dígitos', () {
      final cedula = ValueCedula('12345672');
      expect(cedula.isValid, isTrue);
      expect(cedula.orCrash, '12345672');
    });

    test('acepta una cédula válida con puntos y guion', () {
      final cedula = ValueCedula('1.234.567-2');
      expect(cedula.isValid, isTrue);
      // El valor se normaliza a solo dígitos.
      expect(cedula.orCrash, '12345672');
    });

    test('acepta una cédula válida de 7 dígitos y la normaliza a 8', () {
      final cedula = ValueCedula('1234561');
      expect(cedula.isValid, isTrue);
      expect(cedula.orCrash, '01234561');
    });

    test('rechaza una cédula con dígito verificador incorrecto', () {
      final cedula = ValueCedula('12345670');
      expect(cedula.isValid, isFalse);
    });

    test('rechaza un string vacío', () {
      final cedula = ValueCedula('');
      expect(cedula.isValid, isFalse);
    });

    test('rechaza una cédula con letras', () {
      final cedula = ValueCedula('1234567A');
      expect(cedula.isValid, isFalse);
    });

    test('rechaza una cédula demasiado corta', () {
      final cedula = ValueCedula('12345');
      expect(cedula.isValid, isFalse);
    });

    test('rechaza una cédula demasiado larga', () {
      final cedula = ValueCedula('123456789');
      expect(cedula.isValid, isFalse);
    });

    test('retorna mensaje de error cuando es inválida', () {
      final cedula = ValueCedula('12345670');
      expect(cedula.validate(), isNotNull);
    });

    test('respeta un customValidate adicional', () {
      final cedula = ValueCedula(
        '12345672',
        customValidate: (value) => value.fold(
          (_) => null,
          (cedula) =>
              cedula == '12345672' ? 'No se permite esta cédula' : null,
        ),
      );
      expect(cedula.validate(), 'No se permite esta cédula');
    });
  });

  group('ValueOptionCedula', () {
    test('acepta null como ausencia de valor', () {
      final cedula = ValueOptionCedula(null);
      expect(cedula.isValid, isTrue);
    });

    test('acepta string vacío como ausencia de valor', () {
      final cedula = ValueOptionCedula('');
      expect(cedula.isValid, isTrue);
    });

    test('valida la cédula cuando se provee un valor', () {
      final valida = ValueOptionCedula('1.234.567-2');
      expect(valida.isValid, isTrue);

      final invalida = ValueOptionCedula('12345670');
      expect(invalida.isValid, isFalse);
    });
  });

  group('ValueRut', () {
    test('acepta un RUT válido de 12 dígitos', () {
      final rut = ValueRut('210000000019');
      expect(rut.isValid, isTrue);
      expect(rut.orCrash, '210000000019');
    });

    test('acepta un RUT válido con puntos y guion', () {
      final rut = ValueRut('21-000000001-9');
      expect(rut.isValid, isTrue);
      expect(rut.orCrash, '210000000019');
    });

    test('rechaza un RUT con dígito verificador incorrecto', () {
      final rut = ValueRut('210000000010');
      expect(rut.isValid, isFalse);
    });

    test('rechaza un RUT con cantidad de dígitos distinta de 12', () {
      expect(ValueRut('21000000001').isValid, isFalse);
      expect(ValueRut('2100000000199').isValid, isFalse);
    });

    test('rechaza un RUT con letras', () {
      expect(ValueRut('21000000001A').isValid, isFalse);
    });

    test('rechaza un string vacío', () {
      expect(ValueRut('').isValid, isFalse);
    });
  });

  group('ValueOptionRut', () {
    test('acepta null y string vacío como ausencia de valor', () {
      expect(ValueOptionRut(null).isValid, isTrue);
      expect(ValueOptionRut('').isValid, isTrue);
    });

    test('valida el RUT cuando se provee un valor', () {
      expect(ValueOptionRut('210000000019').isValid, isTrue);
      expect(ValueOptionRut('210000000010').isValid, isFalse);
    });
  });
}
