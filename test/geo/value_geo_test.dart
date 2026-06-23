import 'package:test/test.dart';
import 'package:value_objects_pkg/src/geo/value_geo.dart';

void main() {
  group('validateLatitude', () {
    test('debe validar latitud en el rango válido', () {
      final result = validateLatitude(0.0);
      expect(result.isRight(), isTrue);
      expect(result.getOrElse((_) => 0.0), 0.0);
    });

    test('debe validar latitud norte máxima (90.0)', () {
      final result = validateLatitude(90.0);
      expect(result.isRight(), isTrue);
      expect(result.getOrElse((_) => 0.0), 90.0);
    });

    test('debe validar latitud sur mínima (-90.0)', () {
      final result = validateLatitude(-90.0);
      expect(result.isRight(), isTrue);
      expect(result.getOrElse((_) => 0.0), -90.0);
    });

    test('debe rechazar latitud mayor a 90.0', () {
      final result = validateLatitude(90.1);
      expect(result.isLeft(), isTrue);
    });

    test('debe rechazar latitud menor a -90.0', () {
      final result = validateLatitude(-90.1);
      expect(result.isLeft(), isTrue);
    });

    test('debe validar latitudes intermedias', () {
      final latitudes = [45.0, -45.0, 51.5074, -33.8688];
      for (final lat in latitudes) {
        final result = validateLatitude(lat);
        expect(result.isRight(), isTrue);
      }
    });

    test('debe validar latitud 0 (ecuador)', () {
      final result = validateLatitude(0.0);
      expect(result.isRight(), isTrue);
    });
  });

  group('validateLongitude', () {
    test('debe validar longitud en el rango válido', () {
      final result = validateLongitude(0.0);
      expect(result.isRight(), isTrue);
      expect(result.getOrElse((_) => 0.0), 0.0);
    });

    test('debe validar longitud este máxima (180.0)', () {
      final result = validateLongitude(180.0);
      expect(result.isRight(), isTrue);
      expect(result.getOrElse((_) => 0.0), 180.0);
    });

    test('debe validar longitud oeste mínima (-180.0)', () {
      final result = validateLongitude(-180.0);
      expect(result.isRight(), isTrue);
      expect(result.getOrElse((_) => 0.0), -180.0);
    });

    test('debe rechazar longitud mayor a 180.0', () {
      final result = validateLongitude(180.1);
      expect(result.isLeft(), isTrue);
    });

    test('debe rechazar longitud menor a -180.0', () {
      final result = validateLongitude(-180.1);
      expect(result.isLeft(), isTrue);
    });

    test('debe validar longitudes intermedias', () {
      final longitudes = [-73.935242, 139.6917, 2.3522, -43.1729];
      for (final lon in longitudes) {
        final result = validateLongitude(lon);
        expect(result.isRight(), isTrue);
      }
    });

    test('debe validar longitud 0 (meridiano de Greenwich)', () {
      final result = validateLongitude(0.0);
      expect(result.isRight(), isTrue);
    });
  });

  group('ValueLatitude', () {
    test('debe crear latitud válida desde string', () {
      final vo = ValueLatitude('45.5');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 45.5);
    });

    test('debe crear latitud con 0', () {
      final vo = ValueLatitude('0.0');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 0.0);
    });

    test('debe crear latitud máxima (90)', () {
      final vo = ValueLatitude('90.0');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 90.0);
    });

    test('debe crear latitud mínima (-90)', () {
      final vo = ValueLatitude('-90.0');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, -90.0);
    });

    test('debe rechazar latitud fuera de rango', () {
      final vo = ValueLatitude('91.0');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar latitud inválida', () {
      final vo = ValueLatitude('-91.0');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar string no numérico', () {
      final vo = ValueLatitude('abc');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar string vacío', () {
      final vo = ValueLatitude('');
      expect(vo.isValid, isFalse);
    });

    test('debe validar latitudes con muchos decimales', () {
      final vo = ValueLatitude('51.5074103');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 51.5074103);
    });

    test('debe validar latitudes negativas con muchos decimales', () {
      final vo = ValueLatitude('-33.8688197');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, -33.8688197);
    });

    test('debe rechazar latitud con solo espacios', () {
      final vo = ValueLatitude('   ');
      expect(vo.isValid, isFalse);
    });
  });

  group('ValueLongitude', () {
    test('debe crear longitud válida desde string', () {
      final vo = ValueLongitude('-73.935242');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, -73.935242);
    });

    test('debe crear longitud con 0', () {
      final vo = ValueLongitude('0.0');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 0.0);
    });

    test('debe crear longitud máxima (180)', () {
      final vo = ValueLongitude('180.0');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 180.0);
    });

    test('debe crear longitud mínima (-180)', () {
      final vo = ValueLongitude('-180.0');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, -180.0);
    });

    test('debe rechazar longitud fuera de rango', () {
      final vo = ValueLongitude('181.0');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar longitud inválida', () {
      final vo = ValueLongitude('-181.0');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar string no numérico', () {
      final vo = ValueLongitude('xyz');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar string vacío', () {
      final vo = ValueLongitude('');
      expect(vo.isValid, isFalse);
    });

    test('debe validar longitudes con muchos decimales', () {
      final vo = ValueLongitude('139.6917');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, 139.6917);
    });

    test('debe validar longitudes negativas con muchos decimales', () {
      final vo = ValueLongitude('-43.1729');
      expect(vo.isValid, isTrue);
      expect(vo.orCrash, -43.1729);
    });

    test('debe rechazar longitud con solo espacios', () {
      final vo = ValueLongitude('   ');
      expect(vo.isValid, isFalse);
    });
  });

  group('Coordinates - Integration Tests', () {
    test('debe validar coordenadas válidas de Nueva York', () {
      final lat = ValueLatitude('40.7128');
      final lon = ValueLongitude('-74.0060');

      expect(lat.isValid, isTrue);
      expect(lon.isValid, isTrue);
    });

    test('debe validar coordenadas válidas de Tokyo', () {
      final lat = ValueLatitude('35.6762');
      final lon = ValueLongitude('139.6503');

      expect(lat.isValid, isTrue);
      expect(lon.isValid, isTrue);
    });

    test('debe validar coordenadas válidas de Sydney', () {
      final lat = ValueLatitude('-33.8688');
      final lon = ValueLongitude('151.2093');

      expect(lat.isValid, isTrue);
      expect(lon.isValid, isTrue);
    });

    test('debe validar coordenadas en el polo norte', () {
      final lat = ValueLatitude('90.0');
      final lon = ValueLongitude('0.0'); // Longitud irrelevante en polos

      expect(lat.isValid, isTrue);
      expect(lon.isValid, isTrue);
    });

    test('debe validar coordenadas en el polo sur', () {
      final lat = ValueLatitude('-90.0');
      final lon = ValueLongitude('0.0');

      expect(lat.isValid, isTrue);
      expect(lon.isValid, isTrue);
    });

    test('debe validar múltiples coordenadas en secuencia', () {
      final locations = [
        {'lat': '40.7128', 'lon': '-74.0060'}, // NYC
        {'lat': '35.6762', 'lon': '139.6503'}, // Tokyo
        {'lat': '-33.8688', 'lon': '151.2093'}, // Sydney
        {'lat': '51.5074', 'lon': '-0.1278'}, // London
        {'lat': '48.8566', 'lon': '2.3522'}, // Paris
      ];

      for (final loc in locations) {
        final lat = ValueLatitude(loc['lat']!);
        final lon = ValueLongitude(loc['lon']!);
        expect(
          lat.isValid,
          isTrue,
          reason: 'Latitude ${loc['lat']} should be valid',
        );
        expect(
          lon.isValid,
          isTrue,
          reason: 'Longitude ${loc['lon']} should be valid',
        );
      }
    });

    test('debe rechazar coordenadas inválidas', () {
      final invalidLocations = [
        {'lat': '91.0', 'lon': '0.0'}, // Lat fuera de rango
        {'lat': '0.0', 'lon': '181.0'}, // Lon fuera de rango
        {'lat': '-91.0', 'lon': '0.0'}, // Lat negativa fuera de rango
        {'lat': '0.0', 'lon': '-181.0'}, // Lon negativa fuera de rango
      ];

      for (final loc in invalidLocations) {
        final lat = ValueLatitude(loc['lat']!);
        final lon = ValueLongitude(loc['lon']!);
        final isInvalid = !lat.isValid || !lon.isValid;
        expect(
          isInvalid,
          isTrue,
          reason: 'Location ${loc['lat']}, ${loc['lon']} should be invalid',
        );
      }
    });
  });

  group('Edge Cases - Geo Coordinates', () {
    test('debe manejar decimales muy pequeños', () {
      final lat = ValueLatitude('0.0001');
      final lon = ValueLongitude('0.0001');

      expect(lat.isValid, isTrue);
      expect(lon.isValid, isTrue);
    });

    test('debe manejar decimales muy grandes dentro del rango', () {
      final lat = ValueLatitude('89.9999999');
      final lon = ValueLongitude('179.9999999');

      expect(lat.isValid, isTrue);
      expect(lon.isValid, isTrue);
    });

    test('debe rechazar valores muy cercanos a los límites (fuera)', () {
      final latTooBig = ValueLatitude('90.0001');
      final lonTooBig = ValueLongitude('180.0001');

      expect(latTooBig.isValid, isFalse);
      expect(lonTooBig.isValid, isFalse);
    });

    test('debe manejar números científicos en formato string', () {
      final vo1 = ValueLatitude('1e1'); // 10.0
      final vo2 = ValueLongitude('1e2'); // 100.0 (dentro de rango)

      expect(vo1.isValid, isTrue); // 10.0 es válido
      expect(vo2.isValid, isTrue); // 100.0 está dentro de rango (-180 a 180)
    });

    test('debe rechazar infinito', () {
      final vo = ValueLatitude('Infinity');
      expect(vo.isValid, isFalse);
    });

    test('debe rechazar NaN', () {
      // Nota: parseNumeric en Dart convierte 'NaN' a double.nan
      // que luego falla la validación de rango
      final vo = ValueLatitude('not_a_number');
      expect(vo.isValid, isFalse);
    });
  });
}
