import 'package:test/test.dart';
import 'package:value_objects_pkg/src/identity/value_identities.dart';

void main() {
  group('ValuePhoneNumber', () {
    test('debe validar un número de teléfono válido', () {
      final vo = ValuePhoneNumber('1234567');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, '1234567');
    });

    test('debe validar número con código de país (+)', () {
      final vo = ValuePhoneNumber('+5491234567890');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, '+5491234567890');
    });

    test('debe validar número con espacios (quitarlos)', () {
      final vo = ValuePhoneNumber('+54 9 123 456 7890');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, '+5491234567890');
    });

    test('debe validar número con 7 dígitos (mínimo)', () {
      final vo = ValuePhoneNumber('1234567');
      expect(vo.isValid, isTrue);
    });

    test('debe validar número con 15 dígitos (máximo)', () {
      final vo = ValuePhoneNumber('123456789012345');
      expect(vo.isValid, isTrue);
    });

    test('debe rechazar número con menos de 7 dígitos', () {
      final vo = ValuePhoneNumber('123456');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar número con más de 15 dígitos', () {
      final vo = ValuePhoneNumber('1234567890123456');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar número con caracteres especiales inválidos', () {
      final vo = ValuePhoneNumber('+549-1234-5678');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar número vacío', () {
      final vo = ValuePhoneNumber('');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar número con solo espacios', () {
      final vo = ValuePhoneNumber('   ');
      expect(vo.isValid, isFalse);
    });

    test('debe validar números de diferentes países', () {
      final phones = [
        '+12025551234', // USA
        '+441632960000', // UK
        '+33123456789', // France
        '+492030113456', // Germany
        '+347911234567', // Italy
      ];
      for (final phone in phones) {
        final vo = ValuePhoneNumber(phone);
        expect(vo.isValid, isTrue, reason: 'Phone $phone should be valid');
      }
    });

    test('debe rechazar número sin dígitos', () {
      final vo = ValuePhoneNumber('+');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar número con letras', () {
      final vo = ValuePhoneNumber('+549ABC1234567');
      expect(vo.isValid, isFalse);
    });

    test('debe normalizar espacios en números internacionales', () {
      final vo = ValuePhoneNumber('+1 202 555 1234');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, '+12025551234');
    });
  });

  group('ValueOptionPhoneNumber', () {
    test('debe validar un número de teléfono válido', () {
      final vo = ValueOptionPhoneNumber('1234567');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isSome(), isTrue);
    });

    test('debe validar null como None()', () {
      final vo = ValueOptionPhoneNumber(null);
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isNone(), isTrue);
    });

    test('debe validar string vacío como None()', () {
      final vo = ValueOptionPhoneNumber('');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isNone(), isTrue);
    });

    test('debe fallar con número inválido', () {
      final vo = ValueOptionPhoneNumber('123');
      expect(vo.isValid, isFalse);
    });

    test('debe validar número con código de país en Some()', () {
      final vo = ValueOptionPhoneNumber('+5491234567890');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.fold(() => '', (phone) => phone), '+5491234567890');
    });
  });

  group('Integration Tests - Phone with User Identity', () {
    test('debe crear perfil de usuario con teléfono', () {
      final id = UniqueId();
      final firstName = ValueName('Juan');
      final lastName = ValueLastName('García');
      final email = ValueEmailAddress('juan.garcia@example.com');
      final phone = ValuePhoneNumber('+5491234567890');
      final password = ValuePassword('SecurePass123!');

      expect(id.isValid, isTrue);
      expect(firstName.isValid, isTrue);
      expect(lastName.isValid, isTrue);
      expect(email.isValid, isTrue);
      expect(phone.isValid, isTrue);
      expect(password.isValid, isTrue);
    });

    test('debe validar teléfono opcional en perfil', () {
      final optionalPhone = ValueOptionPhoneNumber('+5491234567890');
      final optionalPhoneNull = ValueOptionPhoneNumber(null);

      expect(optionalPhone.isValid, isTrue);
      expect(optionalPhoneNull.isValid, isTrue);
    });
  });
}
