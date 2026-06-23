import 'package:test/test.dart';
import 'package:value_objects_pkg/value_objects_pkg.dart';

/// Cross-module tests for the unified [CustomValidate] hook.
///
/// For each representative value object we check the three contract cases:
/// 1. a custom rule that rejects a structurally-valid value,
/// 2. a custom rule that returns null and lets the value pass,
/// 3. the built-in failure still wins when no custom rule is supplied.
void main() {
  group('CustomValidate - text (ValueSingleLine)', () {
    test('una regla personalizada rechaza un valor estructuralmente válido', () {
      final vo = ValueSingleLine(
        'hello',
        customValidate: (either) => either.fold(
          (_) => null,
          (s) => s.contains(' ') ? null : 'Must contain a space',
        ),
      );
      expect(vo.isValid, isTrue); // estructura válida
      expect(vo.validate(), 'Must contain a space'); // pero la regla falla
    });

    test('una regla que devuelve null deja pasar el valor', () {
      final vo = ValueSingleLine(
        'hello world',
        customValidate: (either) =>
            either.fold((_) => null, (s) => s.contains(' ') ? null : 'fail'),
      );
      expect(vo.validate(), isNull);
    });

    test('sin regla, gana la validación interna', () {
      final vo = ValueSingleLine('');
      expect(vo.validate(), isNotNull);
    });
  });

  group('CustomValidate - collections (ValueListNotEmpty)', () {
    test('regla de negocio sobre elementos prohibidos', () {
      final vo = ValueListNotEmpty<String>(
        ['a', 'banned'],
        customValidate: (either) => either.fold(
          (_) => null,
          (list) => list.contains('banned') ? 'Tag "banned" not allowed' : null,
        ),
      );
      expect(vo.isValid, isTrue);
      expect(vo.validate(), 'Tag "banned" not allowed');
    });

    test('lista válida sin elementos prohibidos pasa', () {
      final vo = ValueListNotEmpty<String>(
        ['a', 'b'],
        customValidate: (either) => either.fold(
          (_) => null,
          (list) => list.contains('banned') ? 'fail' : null,
        ),
      );
      expect(vo.validate(), isNull);
    });
  });

  group('CustomValidate - identity (ValueEmailAddress)', () {
    test('exige dominio corporativo', () {
      String? corporate(either) => either.fold(
        (_) => null,
        (email) =>
            email.endsWith('@acme.com') ? null : 'Must be a corporate email',
      );

      final invalid = ValueEmailAddress(
        'john@gmail.com',
        customValidate: corporate,
      );
      expect(invalid.isValid, isTrue);
      expect(invalid.validate(), 'Must be a corporate email');

      final valid = ValueEmailAddress(
        'john@acme.com',
        customValidate: corporate,
      );
      expect(valid.validate(), isNull);
    });
  });

  group('CustomValidate - geo (ValueLatitude)', () {
    test('restringe a un hemisferio', () {
      final vo = ValueLatitude(
        '-10.0',
        customValidate: (either) => either.fold(
          (_) => null,
          (lat) => lat >= 0 ? null : 'Must be in the northern hemisphere',
        ),
      );
      expect(vo.isValid, isTrue);
      expect(vo.validate(), 'Must be in the northern hemisphere');
    });
  });

  group('CustomValidate - finance (ValueMoney)', () {
    test('exige un monto mínimo de negocio sobre el record', () {
      final vo = ValueMoney(
        '5',
        customValidate: (either) => either.fold(
          (_) => null,
          (record) => record.$1 < 10 ? 'Minimum order is 10' : null,
        ),
      );
      expect(vo.isValid, isTrue);
      expect(vo.validate(), 'Minimum order is 10');
    });
  });

  group('CustomValidate - optional value objects', () {
    test('recibe el Option y puede decidir sobre none', () {
      final vo = ValueOptionListNotEmpty<int>(
        null,
        customValidate: (either) => either.fold(
          (_) => null,
          (option) => option.isNone() ? 'A value is required' : null,
        ),
      );
      expect(vo.isValid, isTrue); // none es estructuralmente válido
      expect(vo.validate(), 'A value is required'); // la regla lo exige
    });
  });
}
