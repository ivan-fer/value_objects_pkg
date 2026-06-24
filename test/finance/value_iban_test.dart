import 'package:test/test.dart';
import 'package:value_objects_pkg/src/finance/value_finance.dart';

void main() {
  // IBANs de ejemplo válidos publicados por las entidades de estandarización.
  const validEs = 'ES9121000418450200051332';
  const validGb = 'GB82WEST12345698765432';
  const validDe = 'DE89370400440532013000';

  group('ValueIban', () {
    test('acepta un IBAN válido', () {
      final iban = ValueIban(validEs);
      expect(iban.isValid, isTrue);
      expect(iban.orCrash, validEs);
    });

    test('acepta IBAN con espacios y minúsculas, y lo normaliza', () {
      final iban = ValueIban('es91 2100 0418 4502 0005 1332');
      expect(iban.isValid, isTrue);
      expect(iban.orCrash, validEs);
    });

    test('valida IBANs de distintos países', () {
      expect(ValueIban(validGb).isValid, isTrue);
      expect(ValueIban(validDe).isValid, isTrue);
    });

    test('rechaza un IBAN con checksum incorrecto', () {
      // Mismo IBAN español con los dígitos de control alterados.
      final iban = ValueIban('ES0021000418450200051332');
      expect(iban.isValid, isFalse);
    });

    test('rechaza un IBAN con formato inválido', () {
      expect(ValueIban('12ES000418450200051332').isValid, isFalse);
      expect(ValueIban('ESAB21000418450200051332').isValid, isFalse);
      expect(ValueIban('ES91#2100').isValid, isFalse);
    });

    test('rechaza un string vacío', () {
      expect(ValueIban('').isValid, isFalse);
      expect(ValueIban('   ').isValid, isFalse);
    });

    test('formatted agrupa en bloques de 4 caracteres', () {
      final iban = ValueIban(validEs);
      expect(iban.formatted, 'ES91 2100 0418 4502 0005 1332');
    });

    test('formatted retorna string vacío si es inválido', () {
      expect(ValueIban('invalido').formatted, '');
    });

    test('countryCode devuelve las dos primeras letras', () {
      expect(ValueIban(validDe).countryCode, 'DE');
      expect(ValueIban('invalido').countryCode, '');
    });
  });

  group('ValueOptionIban', () {
    test('acepta null y string vacío como ausencia de valor', () {
      expect(ValueOptionIban(null).isValid, isTrue);
      expect(ValueOptionIban('').isValid, isTrue);
      expect(ValueOptionIban('   ').isValid, isTrue);
    });

    test('valida el IBAN cuando se provee un valor', () {
      expect(ValueOptionIban(validEs).isValid, isTrue);
      expect(ValueOptionIban('ES0021000418450200051332').isValid, isFalse);
    });

    test('orEmpty devuelve el IBAN o string vacío', () {
      expect(ValueOptionIban(validEs).orEmpty, validEs);
      expect(ValueOptionIban(null).orEmpty, '');
    });
  });
}
