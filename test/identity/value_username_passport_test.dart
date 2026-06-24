import 'package:test/test.dart';
import 'package:value_objects_pkg/src/identity/value_identities.dart';

void main() {
  group('ValueUsername', () {
    test('acepta un usuario válido', () {
      final user = ValueUsername('ivan.fer_01');
      expect(user.isValid, isTrue);
      expect(user.orCrash, 'ivan.fer_01');
    });

    test('recorta espacios alrededor', () {
      final user = ValueUsername('  juan_perez  ');
      expect(user.isValid, isTrue);
      expect(user.orCrash, 'juan_perez');
    });

    test('rechaza si no comienza con una letra', () {
      expect(ValueUsername('1ivan').isValid, isFalse);
      expect(ValueUsername('_ivan').isValid, isFalse);
    });

    test('rechaza si es demasiado corto o largo', () {
      expect(ValueUsername('ab').isValid, isFalse);
      expect(ValueUsername('a' * 21).isValid, isFalse);
    });

    test('rechaza caracteres inválidos y espacios internos', () {
      expect(ValueUsername('ivan perez').isValid, isFalse);
      expect(ValueUsername('iván').isValid, isFalse);
      expect(ValueUsername('ivan@fer').isValid, isFalse);
    });

    test('rechaza un string vacío', () {
      expect(ValueUsername('').isValid, isFalse);
    });
  });

  group('ValueOptionUsername', () {
    test('acepta null y string vacío como ausencia de valor', () {
      expect(ValueOptionUsername(null).isValid, isTrue);
      expect(ValueOptionUsername('').isValid, isTrue);
    });

    test('valida el usuario cuando se provee un valor', () {
      expect(ValueOptionUsername('ivan_fer').isValid, isTrue);
      expect(ValueOptionUsername('1ivan').isValid, isFalse);
    });
  });

  group('ValuePassport', () {
    test('acepta un pasaporte válido y lo normaliza a mayúsculas', () {
      final passport = ValuePassport('ab123456');
      expect(passport.isValid, isTrue);
      expect(passport.orCrash, 'AB123456');
    });

    test('elimina espacios internos', () {
      final passport = ValuePassport('AB 123 456');
      expect(passport.isValid, isTrue);
      expect(passport.orCrash, 'AB123456');
    });

    test('rechaza longitudes fuera de rango', () {
      expect(ValuePassport('AB123').isValid, isFalse);
      expect(ValuePassport('AB1234567890').isValid, isFalse);
    });

    test('rechaza caracteres no alfanuméricos', () {
      expect(ValuePassport('AB-12345').isValid, isFalse);
    });

    test('rechaza un string vacío', () {
      expect(ValuePassport('').isValid, isFalse);
    });
  });

  group('ValueOptionPassport', () {
    test('acepta null y string vacío como ausencia de valor', () {
      expect(ValueOptionPassport(null).isValid, isTrue);
      expect(ValueOptionPassport('').isValid, isTrue);
    });

    test('valida el pasaporte cuando se provee un valor', () {
      expect(ValueOptionPassport('AB123456').isValid, isTrue);
      expect(ValueOptionPassport('AB-12345').isValid, isFalse);
    });
  });
}
