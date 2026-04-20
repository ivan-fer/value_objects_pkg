import 'package:distance/distance.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:value_objects_pkg/src/core/value_failure.dart';
import 'package:value_objects_pkg/src/measures/value_measures.dart';

void main() {
  group('Validation Functions', () {
    group('validateDateRange', () {
      test('debe aceptar una fecha dentro del rango', () {
        final minDate = DateTime(2020, 1, 1);
        final maxDate = DateTime(2025, 12, 31);
        final testDate = DateTime(2023, 6, 15);

        final result = validateDateRange(testDate, minDate, maxDate);
        expect(result.isRight(), isTrue);
        expect(result.getOrElse((_) => DateTime.now()), testDate);
      });

      test('debe aceptar una fecha igual a la fecha mínima', () {
        final minDate = DateTime(2020, 1, 1);
        final maxDate = DateTime(2025, 12, 31);

        final result = validateDateRange(minDate, minDate, maxDate);
        expect(result.isRight(), isTrue);
      });

      test('debe aceptar una fecha igual a la fecha máxima', () {
        final minDate = DateTime(2020, 1, 1);
        final maxDate = DateTime(2025, 12, 31);

        final result = validateDateRange(maxDate, minDate, maxDate);
        expect(result.isRight(), isTrue);
      });

      test('debe rechazar una fecha anterior al mínimo', () {
        final minDate = DateTime(2020, 1, 1);
        final maxDate = DateTime(2025, 12, 31);
        final testDate = DateTime(2019, 12, 31);

        final result = validateDateRange(testDate, minDate, maxDate);
        expect(result.isLeft(), isTrue);
      });

      test('debe rechazar una fecha posterior al máximo', () {
        final minDate = DateTime(2020, 1, 1);
        final maxDate = DateTime(2025, 12, 31);
        final testDate = DateTime(2026, 1, 1);

        final result = validateDateRange(testDate, minDate, maxDate);
        expect(result.isLeft(), isTrue);
      });
    });

    group('validateDistanceNotZero', () {
      test('debe aceptar una distancia diferente de cero', () {
        final distance = Distance(kilometers: 5);
        final result = validateDistanceNotZero(distance);
        expect(result.isRight(), isTrue);
      });

      test('debe rechazar una distancia de cero', () {
        final result = validateDistanceNotZero(Distance.zero);
        expect(result.isLeft(), isTrue);
        result.fold(
          (f) => expect(f, isA<ZeroValue>()),
          (_) => fail('Debería fallar'),
        );
      });

      test('debe aceptar distancias negativas (inversas)', () {
        final distance = Distance(kilometers: -5);
        final result = validateDistanceNotZero(distance);
        expect(result.isRight(), isTrue);
      });
    });

    group('validateDistanceRange', () {
      test('debe aceptar una distancia dentro del rango', () {
        final minDistance = Distance(kilometers: 1);
        final maxDistance = Distance(kilometers: 10);
        final testDistance = Distance(kilometers: 5);

        final result = validateDistanceRange(
          testDistance,
          min: minDistance,
          max: maxDistance,
        );
        expect(result.isRight(), isTrue);
      });

      test('debe validar solo con mínimo', () {
        final minDistance = Distance(kilometers: 1);
        final testDistance = Distance(kilometers: 5);

        final result = validateDistanceRange(testDistance, min: minDistance);
        expect(result.isRight(), isTrue);
      });

      test('debe validar solo con máximo', () {
        final maxDistance = Distance(kilometers: 10);
        final testDistance = Distance(kilometers: 5);

        final result = validateDistanceRange(testDistance, max: maxDistance);
        expect(result.isRight(), isTrue);
      });

      test('debe rechazar distancia menor que el mínimo', () {
        final minDistance = Distance(kilometers: 5);
        final testDistance = Distance(kilometers: 2);

        final result = validateDistanceRange(testDistance, min: minDistance);
        expect(result.isLeft(), isTrue);
      });

      test('debe rechazar distancia mayor que el máximo', () {
        final maxDistance = Distance(kilometers: 5);
        final testDistance = Distance(kilometers: 10);

        final result = validateDistanceRange(testDistance, max: maxDistance);
        expect(result.isLeft(), isTrue);
      });

      test('debe aceptar distancia sin límites', () {
        final testDistance = Distance(kilometers: 100);

        final result = validateDistanceRange(testDistance);
        expect(result.isRight(), isTrue);
      });
    });

    group('validateDurationNotZero', () {
      test('debe aceptar una duración diferente de cero', () {
        final duration = const Duration(hours: 5);
        final result = validateDurationNotZero(duration);
        expect(result.isRight(), isTrue);
      });

      test('debe rechazar una duración de cero', () {
        final result = validateDurationNotZero(Duration.zero);
        expect(result.isLeft(), isTrue);
        result.fold(
          (f) => expect(f, isA<ZeroValue>()),
          (_) => fail('Debería fallar'),
        );
      });

      test('debe aceptar duraciones negativas', () {
        final duration = const Duration(hours: -5);
        final result = validateDurationNotZero(duration);
        expect(result.isRight(), isTrue);
      });
    });

    group('validateDurationRange', () {
      test('debe aceptar una duración dentro del rango', () {
        final minDuration = const Duration(hours: 1);
        final maxDuration = const Duration(hours: 10);
        final testDuration = const Duration(hours: 5);

        final result = validateDurationRange(
          testDuration,
          min: minDuration,
          max: maxDuration,
        );
        expect(result.isRight(), isTrue);
      });

      test('debe validar solo con mínimo', () {
        final minDuration = const Duration(hours: 1);
        final testDuration = const Duration(hours: 5);

        final result = validateDurationRange(testDuration, min: minDuration);
        expect(result.isRight(), isTrue);
      });

      test('debe validar solo con máximo', () {
        final maxDuration = const Duration(hours: 10);
        final testDuration = const Duration(hours: 5);

        final result = validateDurationRange(testDuration, max: maxDuration);
        expect(result.isRight(), isTrue);
      });

      test('debe rechazar duración menor que el mínimo', () {
        final minDuration = const Duration(hours: 5);
        final testDuration = const Duration(hours: 2);

        final result = validateDurationRange(testDuration, min: minDuration);
        expect(result.isLeft(), isTrue);
      });

      test('debe rechazar duración mayor que el máximo', () {
        final maxDuration = const Duration(hours: 5);
        final testDuration = const Duration(hours: 10);

        final result = validateDurationRange(testDuration, max: maxDuration);
        expect(result.isLeft(), isTrue);
      });

      test('debe aceptar duración sin límites', () {
        final testDuration = const Duration(hours: 100);

        final result = validateDurationRange(testDuration);
        expect(result.isRight(), isTrue);
      });
    });
  });

  group('ValueWhen', () {
    test('debe ser válido con una fecha dentro del rango por defecto', () {
      final now = DateTime.now();
      final vo = ValueWhen(now);
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, now);
    });

    test('debe tener rango por defecto de 1900-2100', () {
      final dateInRange = DateTime(1950, 1, 1);
      final vo = ValueWhen(dateInRange);
      expect(vo.isValid, isTrue);
    });

    test('debe rechazar una fecha anterior a 1900 (defecto)', () {
      final dateOutOfRange = DateTime(1899, 12, 31);
      final vo = ValueWhen(dateOutOfRange);
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar una fecha posterior a 2100 (defecto)', () {
      final dateOutOfRange = DateTime(2101, 1, 1);
      final vo = ValueWhen(dateOutOfRange);
      expect(vo.isValid, isFalse);
    });

    test('debe aceptar rango personalizado', () {
      final minDate = DateTime(2020, 1, 1);
      final maxDate = DateTime(2025, 12, 31);
      final testDate = DateTime(2023, 6, 15);

      final vo = ValueWhen(testDate, minDate: minDate, maxDate: maxDate);
      expect(vo.isValid, isTrue);
    });

    test('debe rechazar fecha fuera de rango personalizado', () {
      final minDate = DateTime(2020, 1, 1);
      final maxDate = DateTime(2025, 12, 31);
      final testDate = DateTime(2026, 1, 1);

      final vo = ValueWhen(testDate, minDate: minDate, maxDate: maxDate);
      expect(vo.isValid, isFalse);
    });

    test('debe aceptar solo minDate personalizado', () {
      final minDate = DateTime(2020, 1, 1);
      final testDate = DateTime(2023, 6, 15);

      final vo = ValueWhen(testDate, minDate: minDate);
      expect(vo.isValid, isTrue);
    });

    test('debe aceptar solo maxDate personalizado', () {
      final maxDate = DateTime(2025, 12, 31);
      final testDate = DateTime(2023, 6, 15);

      final vo = ValueWhen(testDate, maxDate: maxDate);
      expect(vo.isValid, isTrue);
    });
  });

  group('ValueOptionWhen', () {
    test('debe ser válido con null', () {
      final vo = ValueOptionWhen(null);
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isNone(), isTrue);
    });

    test('debe validar una fecha válida', () {
      final testDate = DateTime.now();
      final vo = ValueOptionWhen(testDate);
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.isSome(), isTrue);
      expect(vo.orCrash.fold(() => null, (d) => d), testDate);
    });

    test('debe tener rango por defecto 1900-2100', () {
      final dateInRange = DateTime(1950, 1, 1);
      final vo = ValueOptionWhen(dateInRange);
      expect(vo.isValid, isTrue);
    });

    test('debe rechazar fecha fuera de rango por defecto', () {
      final dateOutOfRange = DateTime(2101, 1, 1);
      final vo = ValueOptionWhen(dateOutOfRange);
      expect(vo.isValid, isFalse);
    });

    test('debe aceptar rango personalizado', () {
      final minDate = DateTime(2020, 1, 1);
      final maxDate = DateTime(2025, 12, 31);
      final testDate = DateTime(2023, 6, 15);

      final vo = ValueOptionWhen(testDate, minDate: minDate, maxDate: maxDate);
      expect(vo.isValid, isTrue);
    });

    test('debe rechazar fecha fuera de rango personalizado', () {
      final minDate = DateTime(2020, 1, 1);
      final maxDate = DateTime(2025, 12, 31);
      final testDate = DateTime(2026, 1, 1);

      final vo = ValueOptionWhen(testDate, minDate: minDate, maxDate: maxDate);
      expect(vo.isValid, isFalse);
    });
  });

  group('ValueBirthDate', () {
    test('debe aceptar una fecha de nacimiento válida', () {
      final now = DateTime.now();
      final validBirthDate = DateTime(now.year - 25, now.month, now.day);

      final vo = ValueBirthDate(validBirthDate);
      expect(vo.isValid, isTrue);
    });

    test('debe rechazar una persona menor de edad (por defecto 18)', () {
      final now = DateTime.now();
      final tooYoung = DateTime(now.year - 10, now.month, now.day);

      final vo = ValueBirthDate(tooYoung);
      expect(vo.isValid, isFalse);
      expect(vo.validate(), contains('18'));
    });

    test('debe rechazar una fecha de nacimiento en el futuro', () {
      final tomorrow = DateTime.now().add(const Duration(days: 1));

      final vo = ValueBirthDate(tomorrow);
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar una fecha de nacimiento muy antigua (> 120 años)', () {
      final now = DateTime.now();
      final tooOld = DateTime(now.year - 121, now.month, now.day);

      final vo = ValueBirthDate(tooOld);
      expect(vo.isValid, isFalse);
    });

    test('debe respetar minAge personalizado', () {
      final now = DateTime.now();
      final testDate = DateTime(now.year - 21, now.month, now.day);

      final voValid = ValueBirthDate(testDate, minAge: 20);
      expect(voValid.isValid, isTrue);

      final voInvalid = ValueBirthDate(testDate, minAge: 25);
      expect(voInvalid.isValid, isFalse);
    });

    test('debe tener mensaje de error apropiadopara menor de edad', () {
      final now = DateTime.now();
      final tooYoung = DateTime(now.year - 10, now.month, now.day);

      final vo = ValueBirthDate(tooYoung, minAge: 18);
      expect(vo.validate(), contains('at least 18 years old'));
    });

    test('debe permitir alguien exactamente en el límite de edad', () {
      final now = DateTime.now();
      final exactLimit = DateTime(now.year - 18, now.month, now.day);

      final vo = ValueBirthDate(exactLimit);
      expect(vo.isValid, isTrue);
    });
  });

  group('ValueDistance', () {
    test('debe aceptar una distancia válida', () {
      final distance = Distance(kilometers: 5);
      final vo = ValueDistance(distance);
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.inKilometers, 5.0);
    });

    test('debe rechazar distancia cero', () {
      final vo = ValueDistance(Distance.zero);
      expect(vo.isValid, isFalse);
    });

    test('debe validar límite mínimo', () {
      final minDistance = Distance(kilometers: 1);
      final validDistance = Distance(kilometers: 5);

      final vo = ValueDistance(validDistance, min: minDistance);
      expect(vo.isValid, isTrue);
    });

    test('debe rechazar distancia menor que el mínimo', () {
      final minDistance = Distance(kilometers: 5);
      final tooSmall = Distance(kilometers: 2);

      final vo = ValueDistance(tooSmall, min: minDistance);
      expect(vo.isValid, isFalse);
    });

    test('debe validar límite máximo', () {
      final maxDistance = Distance(kilometers: 10);
      final validDistance = Distance(kilometers: 5);

      final vo = ValueDistance(validDistance, max: maxDistance);
      expect(vo.isValid, isTrue);
    });

    test('debe rechazar distancia mayor que el máximo', () {
      final maxDistance = Distance(kilometers: 5);
      final tooLarge = Distance(kilometers: 10);

      final vo = ValueDistance(tooLarge, max: maxDistance);
      expect(vo.isValid, isFalse);
    });

    test('debe validar rango min y max', () {
      final minDistance = Distance(kilometers: 1);
      final maxDistance = Distance(kilometers: 10);
      final validDistance = Distance(kilometers: 5);

      final vo = ValueDistance(
        validDistance,
        min: minDistance,
        max: maxDistance,
      );
      expect(vo.isValid, isTrue);
    });

    test('debe retornar Distance.zero si hay error en orZero', () {
      final vo = ValueDistance(Distance.zero);
      expect(vo.orZero, Distance.zero);
    });

    test('debe retornar la distancia si es válida en orZero', () {
      final distance = Distance(kilometers: 5);
      final vo = ValueDistance(distance);
      expect(vo.orZero.inKilometers, 5.0);
    });

    test('debe funcionar con diferentes unidades de distancia', () {
      final distanceMeters = Distance(meters: 5000);
      final vo = ValueDistance(distanceMeters);
      expect(vo.isValid, isTrue);
    });
  });

  group('ValueDuration', () {
    test('debe aceptar una duración válida', () {
      final duration = const Duration(hours: 5);
      final vo = ValueDuration(duration);
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.inHours, 5);
    });

    test('debe rechazar duración cero', () {
      final vo = ValueDuration(Duration.zero);
      expect(vo.isValid, isFalse);
    });

    test('debe validar límite mínimo', () {
      final minDuration = const Duration(hours: 1);
      final validDuration = const Duration(hours: 5);

      final vo = ValueDuration(validDuration, min: minDuration);
      expect(vo.isValid, isTrue);
    });

    test('debe rechazar duración menor que el mínimo', () {
      final minDuration = const Duration(hours: 5);
      final tooSmall = const Duration(hours: 2);

      final vo = ValueDuration(tooSmall, min: minDuration);
      expect(vo.isValid, isFalse);
    });

    test('debe validar límite máximo', () {
      final maxDuration = const Duration(hours: 10);
      final validDuration = const Duration(hours: 5);

      final vo = ValueDuration(validDuration, max: maxDuration);
      expect(vo.isValid, isTrue);
    });

    test('debe rechazar duración mayor que el máximo', () {
      final maxDuration = const Duration(hours: 5);
      final tooLarge = const Duration(hours: 10);

      final vo = ValueDuration(tooLarge, max: maxDuration);
      expect(vo.isValid, isFalse);
    });

    test('debe validar rango min y max', () {
      final minDuration = const Duration(hours: 1);
      final maxDuration = const Duration(hours: 10);
      final validDuration = const Duration(hours: 5);

      final vo = ValueDuration(
        validDuration,
        min: minDuration,
        max: maxDuration,
      );
      expect(vo.isValid, isTrue);
    });

    test('debe retornar Duration.zero si hay error en orZero', () {
      final vo = ValueDuration(Duration.zero);
      expect(vo.orZero, Duration.zero);
    });

    test('debe retornar la duración si es válida en orZero', () {
      final duration = const Duration(hours: 5);
      final vo = ValueDuration(duration);
      expect(vo.orZero.inHours, 5);
    });

    test('debe funcionar con diferentes unidades de duración', () {
      final durationMinutes = const Duration(minutes: 300);
      final vo = ValueDuration(durationMinutes);
      expect(vo.isValid, isTrue);
      expect(vo.orCrash.inMinutes, 300);
    });

    test('debe funcionar con duraciones negativas', () {
      final negativeDuration = const Duration(hours: -5);
      final vo = ValueDuration(negativeDuration);
      expect(vo.isValid, isTrue);
    });

    test('debe rechazar duración negativa si no cumple rango', () {
      final minDuration = const Duration(hours: 1);
      final negativeDuration = const Duration(hours: -5);

      final vo = ValueDuration(negativeDuration, min: minDuration);
      expect(vo.isValid, isFalse);
    });
  });
}
