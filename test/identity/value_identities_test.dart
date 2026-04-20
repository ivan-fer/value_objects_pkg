import 'package:flutter_test/flutter_test.dart';
import 'package:value_objects_pkg/src/core/value_failure.dart';
import 'package:value_objects_pkg/src/identity/value_identities.dart';

void main() {
  group('UniqueId', () {
    test('debe generar un UUID válido cuando se crea sin argumentos', () {
      final id1 = UniqueId();
      final id2 = UniqueId();

      expect(id1.isValid, isTrue);
      expect(id2.isValid, isTrue);
      // Cada UUID debe ser diferente
      expect(id1.orCrash, isNotEmpty);
      expect(id2.orCrash, isNotEmpty);
      expect(id1.orCrash, isNot(equals(id2.orCrash)));
    });

    test('debe generar IDs con formato UUID v4', () {
      final id = UniqueId();
      expect(
        id.orCrash,
        matches(
          RegExp(
            r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
          ),
        ),
      );
    });

    test('debe validar un string UUID válido', () {
      final validUuid = '550e8400-e29b-41d4-a716-446655440000';
      final id = UniqueId.fromUniqueString(validUuid);

      expect(id.isValid, isTrue);
      expect(id.orCrash, validUuid);
    });

    test('debe rechazar string vacío', () {
      final id = UniqueId.fromUniqueString('');

      expect(id.isValid, isFalse);
    });

    test('debe aceptar cualquier string no vacío como ID único', () {
      final customId = 'custom-id-123';
      final id = UniqueId.fromUniqueString(customId);

      expect(id.isValid, isTrue);
      expect(id.orCrash, customId);
    });

    test('debe retornar mensaje de error si es inválido', () {
      final id = UniqueId.fromUniqueString('');
      expect(id.validate(), isNotNull);
    });

    test('debe manejar UUIDs con diferentes formatos', () {
      final uuids = [
        '123e4567-e89b-12d3-a456-426614174000',
        'f47ac10b-58cc-4372-a567-0e02b2c3d479',
        'custom-string-id',
        'test-id-001',
      ];

      for (final uuid in uuids) {
        final id = UniqueId.fromUniqueString(uuid);
        expect(id.isValid, isTrue);
      }
    });
  });

  group('ValueName', () {
    test('debe aceptar un nombre válido', () {
      final vo = ValueName('Juan');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 'Juan');
    });

    test('debe aceptar nombres con acentos', () {
      final vo = ValueName('José');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 'José');
    });

    test('debe aceptar nombres con espacios', () {
      final vo = ValueName('Jean Claude');
      expect(vo.isValid, isTrue);
    });

    test('debe aceptar nombres compuestos con guión', () {
      final vo = ValueName('Jean-Luc');
      expect(vo.isValid, isTrue);
    });

    test('debe rechazar nombres con números', () {
      final vo = ValueName('Juan123');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar nombres con caracteres especiales', () {
      final vo = ValueName('Juan@García');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar string vacío', () {
      final vo = ValueName('');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar solo espacios', () {
      final vo = ValueName('   ');
      expect(vo.isValid, isFalse);
    });

    test('debe validar nombres unicode con acentos', () {
      final names = ['Iván', 'María', 'François', 'Müller'];
      for (final name in names) {
        final vo = ValueName(name);
        expect(vo.isValid, isTrue, reason: 'Name $name should be valid');
      }
    });
  });

  group('ValueLastName', () {
    test('debe aceptar un apellido válido', () {
      final vo = ValueLastName('García');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 'García');
    });

    test('debe aceptar apellidos compuestos', () {
      final vo = ValueLastName('García López');
      expect(vo.isValid, isTrue);
    });

    test('debe aceptar apellidos con guión', () {
      final vo = ValueLastName('García-López');
      expect(vo.isValid, isTrue);
    });

    test('debe rechazar apellidos con números', () {
      final vo = ValueLastName('García123');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar apellidos con caracteres especiales', () {
      final vo = ValueLastName('García@López');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar string vacío', () {
      final vo = ValueLastName('');
      expect(vo.isValid, isFalse);
    });

    test('debe usar la misma validación que ValueName', () {
      final name = ValueName('García');
      final lastName = ValueLastName('García');

      expect(name.isValid, lastName.isValid);
    });
  });

  group('ValueEmailAddress', () {
    test('debe validar un email simple válido', () {
      final vo = ValueEmailAddress('user@example.com');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 'user@example.com');
    });

    test('debe validar emails con puntos en local part', () {
      final vo = ValueEmailAddress('first.last@example.com');
      expect(vo.isValid, isTrue);
    });

    test('debe validar emails con números', () {
      final vo = ValueEmailAddress('user123@example.com');
      expect(vo.isValid, isTrue);
    });

    test('debe validar emails con guiones', () {
      final vo = ValueEmailAddress('user-name@example.com');
      expect(vo.isValid, isTrue);
    });

    test('debe validar emails con caracteres especiales válidos', () {
      final emails = [
        'user+tag@example.com',
        'user_name@example.com',
        'user!name@example.co.uk',
      ];

      for (final email in emails) {
        final vo = ValueEmailAddress(email);
        expect(vo.isValid, isTrue, reason: 'Email $email should be valid');
      }
    });

    test('debe rechazar email sin @', () {
      final vo = ValueEmailAddress('userexample.com');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar email sin dominio', () {
      final vo = ValueEmailAddress('user@');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar email sin extensión', () {
      final vo = ValueEmailAddress('user@example');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar email con espacios', () {
      final vo = ValueEmailAddress('user name@example.com');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar string vacío', () {
      final vo = ValueEmailAddress('');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar email con múltiples @', () {
      final vo = ValueEmailAddress('user@name@example.com');
      expect(vo.isValid, isFalse);
    });

    test('debe validar emails con dominios subdivididos', () {
      final vo = ValueEmailAddress('user@mail.example.co.uk');
      expect(vo.isValid, isTrue);
    });

    test('debe rechazar email con caracteres inválidos', () {
      final vo = ValueEmailAddress('user#name@example.com');
      expect(vo.isValid, isFalse);
    });
  });

  group('ValuePassword', () {
    test('debe validar una contraseña que cumple todos los requisitos', () {
      final vo = ValuePassword('SecurePass123!');
      expect(vo.isValid, isTrue);
    });

    test('debe aceptar contraseñas con 8 caracteres exactos', () {
      final vo = ValuePassword('Pass123!');
      expect(vo.isValid, isTrue);
    });

    test('debe aceptar contraseñas largas', () {
      final vo = ValuePassword('VerySecurePassword123!@#');
      expect(vo.isValid, isTrue);
    });

    test('debe rechazar contraseña sin mayúscula', () {
      final vo = ValuePassword('securepass123!');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar contraseña sin minúscula', () {
      final vo = ValuePassword('SECUREPASS123!');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar contraseña sin número', () {
      final vo = ValuePassword('SecurePassword!');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar contraseña sin carácter especial', () {
      final vo = ValuePassword('SecurePassword123');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar contraseña menor a 8 caracteres', () {
      final vo = ValuePassword('Pass1!');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar contraseña mayor a 64 caracteres', () {
      final longPassword = 'P${'a' * 62}1!';
      final vo = ValuePassword(longPassword);
      expect(vo.isValid, isFalse);
    });

    test('debe aceptar contraseña con exactamente 64 caracteres', () {
      final password = 'P${'a' * 61}1!';
      final vo = ValuePassword(password);
      expect(vo.isValid, isTrue);
    });

    test('debe rechazar contraseña vacía', () {
      final vo = ValuePassword('');
      expect(vo.isValid, isFalse);
    });

    test('debe aceptar caracteres especiales válidos', () {
      final passwords = [
        'Pass123!',
        'Pass123@',
        'Pass123#',
        'Pass123\$',
        'Pass123%',
        'Pass123^',
        'Pass123&',
        'Pass123*',
      ];

      for (final password in passwords) {
        final vo = ValuePassword(password);
        expect(
          vo.isValid,
          isTrue,
          reason: 'Password $password should be valid',
        );
      }
    });

    test('debe rechazar string con solo números', () {
      final vo = ValuePassword('12345678');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar string con solo letras', () {
      final vo = ValuePassword('abcdefgh');
      expect(vo.isValid, isFalse);
    });
  });

  group('ValuePasswordConfirm', () {
    test('debe validar si las contraseñas coinciden', () {
      final original = 'SecurePass123!';
      final vo = ValuePasswordConfirm(original, original);

      expect(vo.isValid, isTrue);
      expect(vo.orCrash, original);
    });

    test('debe rechazar si las contraseñas no coinciden', () {
      final vo = ValuePasswordConfirm('SecurePass123!', 'DifferentPass123!');

      expect(vo.isValid, isFalse);
    });

    test('debe ser sensible a mayúsculas y minúsculas', () {
      final vo1 = ValuePasswordConfirm('SecurePass123!', 'securepass123!');
      expect(vo1.isValid, isFalse);

      final vo2 = ValuePasswordConfirm('SecurePass123!', 'SecurePass123!');
      expect(vo2.isValid, isTrue);
    });

    test('debe ser sensible a caracteres especiales', () {
      final vo1 = ValuePasswordConfirm('SecurePass123!', 'SecurePass123@');
      expect(vo1.isValid, isFalse);

      final vo2 = ValuePasswordConfirm('SecurePass123!', 'SecurePass123!');
      expect(vo2.isValid, isTrue);
    });

    test('debe rechazar coincidencia parcial', () {
      final vo = ValuePasswordConfirm('SecurePass123!', 'SecurePass123');
      expect(vo.isValid, isFalse);
    });

    test('debe tener mensaje de error descriptivo si no coinciden', () {
      final vo = ValuePasswordConfirm('Pass1', 'Pass2');
      expect(vo.validate(), contains('do not match'));
    });

    test('debe validar contraseñas vacías si coinciden', () {
      final vo = ValuePasswordConfirm('', '');
      expect(vo.isValid, isTrue);
    });

    test('debe rechazar uno vacío y otro no', () {
      final vo1 = ValuePasswordConfirm('', 'SecurePass123!');
      expect(vo1.isValid, isFalse);

      final vo2 = ValuePasswordConfirm('SecurePass123!', '');
      expect(vo2.isValid, isFalse);
    });
  });

  group('ValueOptionName', () {
    test('debe ser válido con null', () {
      final vo = ValueOptionName(null);
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isNone(), isTrue);
    });

    test('debe ser válido con string vacío', () {
      final vo = ValueOptionName('');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isNone(), isTrue);
    });

    test('debe validar un nombre válido', () {
      final vo = ValueOptionName('Juan');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isSome(), isTrue);
      expect(vo.orCrash.fold(() => '', (name) => name), 'Juan');
    });

    test('debe rechazar un nombre inválido', () {
      final vo = ValueOptionName('Juan123');
      expect(vo.isValid, isFalse);
    });
  });

  group('ValueOptionLastName', () {
    test('debe ser válido con null', () {
      final vo = ValueOptionLastName(null);
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isNone(), isTrue);
    });

    test('debe ser válido con string vacío', () {
      final vo = ValueOptionLastName('');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isNone(), isTrue);
    });

    test('debe validar un apellido válido', () {
      final vo = ValueOptionLastName('García');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isSome(), isTrue);
      expect(vo.orCrash.fold(() => '', (name) => name), 'García');
    });

    test('debe rechazar un apellido inválido', () {
      final vo = ValueOptionLastName('García123');
      expect(vo.isValid, isFalse);
    });
  });

  group('ValueOptionEmailAddress', () {
    test('debe ser válido con null', () {
      final vo = ValueOptionEmailAddress(null);
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isNone(), isTrue);
    });

    test('debe ser válido con string vacío', () {
      final vo = ValueOptionEmailAddress('');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isNone(), isTrue);
    });

    test('debe validar un email válido', () {
      final vo = ValueOptionEmailAddress('user@example.com');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isSome(), isTrue);
      expect(vo.orCrash.fold(() => '', (email) => email), 'user@example.com');
    });

    test('debe rechazar un email inválido', () {
      final vo = ValueOptionEmailAddress('invalid-email');
      expect(vo.isValid, isFalse);
    });
  });

  group('Integration Tests - User Identity', () {
    test('debe crear un perfil de usuario válido', () {
      final id = UniqueId();
      final firstName = ValueName('Juan');
      final lastName = ValueLastName('García');
      final email = ValueEmailAddress('juan.garcia@example.com');
      final password = ValuePassword('SecurePass123!');

      expect(id.isValid, isTrue);
      expect(firstName.isValid, isTrue);
      expect(lastName.isValid, isTrue);
      expect(email.isValid, isTrue);
      expect(password.isValid, isTrue);
    });

    test('debe validar confirmación de contraseña en registro', () {
      final password = ValuePassword('SecurePass123!');
      final confirm = ValuePasswordConfirm('SecurePass123!', 'SecurePass123!');

      expect(password.isValid, isTrue);
      expect(confirm.isValid, isTrue);
    });

    test('debe rechazar confirmación de contraseña incorrecta', () {
      final password = ValuePassword('SecurePass123!');
      final confirm = ValuePasswordConfirm('WrongPass123!', 'SecurePass123!');

      expect(password.isValid, isTrue);
      expect(confirm.isValid, isFalse);
    });

    test('debe manejar perfil con nombres opcionales', () {
      final optionalFirstName = ValueOptionName(null);
      final optionalLastName = ValueOptionLastName('García');
      final email = ValueEmailAddress('user@example.com');

      expect(optionalFirstName.isValid, isTrue);
      expect(optionalFirstName.orCrash.isNone(), isTrue);

      expect(optionalLastName.isValid, isTrue);
      expect(optionalLastName.orCrash.isSome(), isTrue);

      expect(email.isValid, isTrue);
    });

    test('debe generar múltiples IDs únicos para diferentes usuarios', () {
      final ids = List.generate(5, (_) => UniqueId());
      final idValues = ids.map((id) => id.orCrash).toList();

      // Todos deben ser válidos
      for (final id in ids) {
        expect(id.isValid, isTrue);
      }

      // Todos deben ser diferentes
      final uniqueIds = idValues.toSet();
      expect(uniqueIds.length, 5);
    });

    test('debe validar múltiples usuarios con información diferente', () {
      final users = [
        {
          'name': ValueName('Juan'),
          'lastName': ValueLastName('García'),
          'email': ValueEmailAddress('juan@example.com'),
        },
        {
          'name': ValueName('María'),
          'lastName': ValueLastName('López'),
          'email': ValueEmailAddress('maria@example.com'),
        },
        {
          'name': ValueName('François'),
          'lastName': ValueLastName('Dupont'),
          'email': ValueEmailAddress('francois@example.fr'),
        },
      ];

      for (final user in users) {
        expect((user['name'] as ValueName).isValid, isTrue);
        expect((user['lastName'] as ValueLastName).isValid, isTrue);
        expect((user['email'] as ValueEmailAddress).isValid, isTrue);
      }
    });
  });

  group('Edge Cases and Error Handling', () {
    test('ValueName debe reportar error si es inválido', () {
      final vo = ValueName('123');
      expect(vo.isValid, isFalse);
      expect(vo.validate(), isNotNull);
    });

    test('ValueEmailAddress debe reportar error si es inválido', () {
      final vo = ValueEmailAddress('invalid');
      expect(vo.isValid, isFalse);
      expect(vo.validate(), isNotNull);
    });

    test('ValuePassword debe reportar error si es inválido', () {
      final vo = ValuePassword('weak');
      expect(vo.isValid, isFalse);
      expect(vo.validate(), isNotNull);
    });

    test('debe manejar nombres con múltiples espacios', () {
      final vo = ValueName('Jean   Claude');
      expect(vo.isValid, isTrue);
    });

    test('debe manejar emails con dominios largos', () {
      final vo = ValueEmailAddress('user@subdomain.example.co.uk');
      expect(vo.isValid, isTrue);
    });

    test('debe rechazar nombres con números en posiciones diferentes', () {
      final names = ['1Juan', 'Ju1an', 'Juan1', '123'];

      for (final name in names) {
        final vo = ValueName(name);
        expect(vo.isValid, isFalse, reason: 'Name $name should be invalid');
      }
    });

    test('debe validar contraseñas con límites de complejidad', () {
      // Exactamente mínimo: 8 caracteres, 1 mayús, 1 minús, 1 número, 1 especial
      final minimalValid = 'Aa1!bcde';
      final voMin = ValuePassword(minimalValid);
      expect(voMin.isValid, isTrue);

      // Un carácter menos que mínimo
      final tooShort = 'Aa1!bcd';
      final voShort = ValuePassword(tooShort);
      expect(voShort.isValid, isFalse);
    });
  });
}
