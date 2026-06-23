import 'package:test/test.dart';
import 'package:value_objects_pkg/src/collections/value_collections.dart';
import 'package:value_objects_pkg/src/core/value_failure.dart';

void main() {
  group('validateCollectionNotEmpty', () {
    test('debe validar una lista no vacía', () {
      final result = validateCollectionNotEmpty([1, 2, 3]);
      expect(result.isRight(), isTrue);
      expect(result.getOrElse((_) => []), [1, 2, 3]);
    });

    test('debe rechazar una lista vacía', () {
      final result = validateCollectionNotEmpty<int>([]);
      expect(result.isLeft(), isTrue);
      expect(result.fold((f) => f, (_) => null), isA<ValueFailure>());
    });

    test('debe validar lista con un elemento', () {
      final result = validateCollectionNotEmpty(['hello']);
      expect(result.isRight(), isTrue);
    });

    test('debe validar lista con múltiples elementos', () {
      final result = validateCollectionNotEmpty([1, 2, 3, 4, 5]);
      expect(result.isRight(), isTrue);
    });
  });

  group('validateCollectionUniqueItems', () {
    test('debe validar una lista con elementos únicos', () {
      final result = validateCollectionUniqueItems([1, 2, 3, 4]);
      expect(result.isRight(), isTrue);
      expect(result.getOrElse((_) => []), [1, 2, 3, 4]);
    });

    test('debe rechazar una lista con elementos duplicados', () {
      final result = validateCollectionUniqueItems([1, 2, 2, 3]);
      expect(result.isLeft(), isTrue);
      expect(result.fold((f) => f, (_) => null), isA<ValueFailure>());
    });

    test('debe validar lista vacía (sin duplicados)', () {
      final result = validateCollectionUniqueItems<int>([]);
      expect(result.isRight(), isTrue);
    });

    test('debe validar lista con un elemento', () {
      final result = validateCollectionUniqueItems(['unique']);
      expect(result.isRight(), isTrue);
    });

    test('debe rechazar lista con múltiples duplicados', () {
      final result = validateCollectionUniqueItems(['a', 'b', 'a', 'c', 'b']);
      expect(result.isLeft(), isTrue);
    });

    test('debe validar lista con objetos complejos únicos', () {
      final list = [DateTime(2023), DateTime(2024)];
      final result = validateCollectionUniqueItems(list);
      expect(result.isRight(), isTrue);
    });

    test('debe rechazar lista con objetos complejos duplicados', () {
      final date = DateTime(2023);
      final result = validateCollectionUniqueItems([date, date]);
      expect(result.isLeft(), isTrue);
    });
  });

  group('validateCollectionContains', () {
    test('debe validar que el elemento está en la lista', () {
      final result = validateCollectionContains([1, 2, 3], 2);
      expect(result.isRight(), isTrue);
      expect(result.getOrElse((_) => 0), 2);
    });

    test('debe rechazar si el elemento no está en la lista', () {
      final result = validateCollectionContains([1, 2, 3], 4);
      expect(result.isLeft(), isTrue);
      expect(result.fold((f) => f, (_) => null), isA<ValueFailure>());
    });

    test('debe validar elemento al inicio de la lista', () {
      final result = validateCollectionContains(['a', 'b', 'c'], 'a');
      expect(result.isRight(), isTrue);
    });

    test('debe validar elemento al final de la lista', () {
      final result = validateCollectionContains(['a', 'b', 'c'], 'c');
      expect(result.isRight(), isTrue);
    });

    test('debe rechazar en lista vacía', () {
      final result = validateCollectionContains<int>([], 1);
      expect(result.isLeft(), isTrue);
    });

    test('debe validar con tipos complejos', () {
      final item = DateTime(2023);
      final result = validateCollectionContains([DateTime(2022), item], item);
      expect(result.isRight(), isTrue);
    });
  });

  group('ValueListNotEmpty', () {
    test('debe crear instancia con lista no vacía', () {
      final vo = ValueListNotEmpty([1, 2, 3]);
      expect(vo.isValid, isTrue);
      expect(vo.orEmpty, [1, 2, 3]);
    });

    test('debe fallar con lista vacía', () {
      final vo = ValueListNotEmpty<int>([]);
      expect(vo.isValid, isFalse);
      expect(vo.orEmpty, <int>[]);
    });

    test('debe crear instancia con un elemento', () {
      final vo = ValueListNotEmpty(['single']);
      expect(vo.isValid, isTrue);
      expect(vo.orEmpty, ['single']);
    });

    test('debe crear instancia con múltiples elementos', () {
      final vo = ValueListNotEmpty([1, 2, 3, 4, 5]);
      expect(vo.isValid, isTrue);
      expect(vo.orEmpty, [1, 2, 3, 4, 5]);
    });

    test('debe manejar tipos genéricos', () {
      final vo = ValueListNotEmpty<String>(['hello', 'world']);
      expect(vo.isValid, isTrue);
      expect(vo.orEmpty, ['hello', 'world']);
    });
  });

  group('ValueUniqueList', () {
    test('debe crear instancia con elementos únicos', () {
      final vo = ValueUniqueList([1, 2, 3, 4]);
      expect(vo.isValid, isTrue);
      expect(vo.orEmpty, [1, 2, 3, 4]);
    });

    test('debe fallar con elementos duplicados', () {
      final vo = ValueUniqueList([1, 2, 2, 3]);
      expect(vo.isValid, isFalse);
      expect(vo.orEmpty, <int>[]);
    });

    test('debe crear instancia con lista vacía', () {
      final vo = ValueUniqueList<int>([]);
      expect(vo.isValid, isTrue);
      expect(vo.orEmpty, <int>[]);
    });

    test('debe crear instancia con un elemento', () {
      final vo = ValueUniqueList(['unique']);
      expect(vo.isValid, isTrue);
      expect(vo.orEmpty, ['unique']);
    });

    test('debe manejar objetos complejos únicos', () {
      final list = [DateTime(2023), DateTime(2024)];
      final vo = ValueUniqueList(list);
      expect(vo.isValid, isTrue);
      expect(vo.orEmpty, list);
    });

    test('debe fallar con objetos complejos duplicados', () {
      final date = DateTime(2023);
      final vo = ValueUniqueList([date, date]);
      expect(vo.isValid, isFalse);
      expect(vo.orEmpty, <DateTime>[]);
    });
  });

  group('ValueUniqueListNotEmpty', () {
    test('debe crear instancia con elementos únicos y no vacía', () {
      final vo = ValueUniqueListNotEmpty([1, 2, 3]);
      expect(vo.isValid, isTrue);
      expect(vo.orEmpty, [1, 2, 3]);
    });

    test('debe fallar con lista vacía', () {
      final vo = ValueUniqueListNotEmpty<int>([]);
      expect(vo.isValid, isFalse);
      expect(vo.orEmpty, <int>[]);
    });

    test('debe fallar con elementos duplicados', () {
      final vo = ValueUniqueListNotEmpty([1, 2, 2, 3]);
      expect(vo.isValid, isFalse);
      expect(vo.orEmpty, <int>[]);
    });

    test(
      'debe fallar con lista vacía y duplicados (vacía tiene prioridad)',
      () {
        final vo = ValueUniqueListNotEmpty<int>([]);
        expect(vo.isValid, isFalse);
      },
    );

    test('debe crear instancia con un elemento único', () {
      final vo = ValueUniqueListNotEmpty(['single']);
      expect(vo.isValid, isTrue);
      expect(vo.orEmpty, ['single']);
    });

    test('debe manejar tipos genéricos', () {
      final vo = ValueUniqueListNotEmpty<String>(['a', 'b', 'c']);
      expect(vo.isValid, isTrue);
      expect(vo.orEmpty, ['a', 'b', 'c']);
    });

    test('debe fallar con múltiples duplicados', () {
      final vo = ValueUniqueListNotEmpty(['x', 'y', 'x', 'z']);
      expect(vo.isValid, isFalse);
    });
  });

  group('ValueList - orEmpty method', () {
    test('ValueListNotEmpty retorna lista correcta cuando válida', () {
      final vo = ValueListNotEmpty([1, 2, 3]);
      expect(vo.orEmpty, [1, 2, 3]);
    });

    test('ValueListNotEmpty retorna lista vacía cuando inválida', () {
      final vo = ValueListNotEmpty<int>([]);
      expect(vo.orEmpty, <int>[]);
    });

    test('ValueUniqueList retorna lista correcta cuando válida', () {
      final vo = ValueUniqueList([1, 2, 3]);
      expect(vo.orEmpty, [1, 2, 3]);
    });

    test('ValueUniqueList retorna lista vacía cuando inválida', () {
      final vo = ValueUniqueList([1, 1, 2]);
      expect(vo.orEmpty, <int>[]);
    });

    test('ValueUniqueListNotEmpty retorna lista correcta cuando válida', () {
      final vo = ValueUniqueListNotEmpty([1, 2, 3]);
      expect(vo.orEmpty, [1, 2, 3]);
    });

    test('ValueUniqueListNotEmpty retorna lista vacía cuando inválida', () {
      final vo = ValueUniqueListNotEmpty<int>([]);
      expect(vo.orEmpty, <int>[]);
    });
  });

  group('Integration Tests - Collections', () {
    test('debe validar múltiples listas en secuencia', () {
      final lists = [
        [1, 2, 3], // válida para todas
        [], // falla not empty
        [1, 1, 2], // falla unique
        [1, 2, 2], // falla ambas
      ];

      final notEmptyResults = lists.map((l) => ValueListNotEmpty(l).isValid);
      final uniqueResults = lists.map((l) => ValueUniqueList(l).isValid);
      final bothResults = lists.map((l) => ValueUniqueListNotEmpty(l).isValid);

      expect(notEmptyResults, [true, false, true, true]);
      expect(uniqueResults, [true, true, false, false]);
      expect(bothResults, [true, false, false, false]);
    });

    test('debe manejar listas grandes', () {
      final largeList = List.generate(1000, (i) => i);
      final vo = ValueUniqueListNotEmpty(largeList);
      expect(vo.isValid, isTrue);
      expect(vo.orEmpty.length, 1000);
    });

    test('debe validar con tipos nullable', () {
      final list = [1, 2, null, 3];
      final vo = ValueListNotEmpty<int?>(list);
      expect(vo.isValid, isTrue);
      expect(vo.orEmpty, list);
    });

    test('debe fallar validación de contención en lista inválida', () {
      final vo = ValueListNotEmpty<int>([]);
      expect(vo.isValid, isFalse);
      // orEmpty debería ser vacío, pero la validación original falló
      expect(vo.orEmpty, <int>[]);
    });
  });

  group('validateCollectionNotContains', () {
    test('debe validar cuando el elemento no está en la lista', () {
      final result = validateCollectionNotContains([1, 2, 3], 4);
      expect(result.isRight(), isTrue);
      expect(result.getOrElse((_) => []), [1, 2, 3]);
    });

    test('debe rechazar cuando el elemento está en la lista', () {
      final result = validateCollectionNotContains([1, 2, 3], 2);
      expect(result.isLeft(), isTrue);
      expect(result.fold((f) => f, (_) => null), isA<ValueFailure>());
    });

    test('debe validar en lista vacía', () {
      final result = validateCollectionNotContains<int>([], 1);
      expect(result.isRight(), isTrue);
    });
  });

  group('validateCollectionMinLength', () {
    test('debe validar cuando alcanza el mínimo', () {
      final result = validateCollectionMinLength([1, 2, 3], 3);
      expect(result.isRight(), isTrue);
    });

    test('debe validar cuando supera el mínimo', () {
      final result = validateCollectionMinLength([1, 2, 3, 4], 2);
      expect(result.isRight(), isTrue);
    });

    test('debe rechazar cuando no alcanza el mínimo', () {
      final result = validateCollectionMinLength([1], 3);
      expect(result.isLeft(), isTrue);
      expect(result.fold((f) => f, (_) => null), isA<ValueFailure>());
    });
  });

  group('validateCollectionMaxLength', () {
    test('debe validar cuando alcanza el máximo', () {
      final result = validateCollectionMaxLength([1, 2, 3], 3);
      expect(result.isRight(), isTrue);
    });

    test('debe validar cuando está por debajo del máximo', () {
      final result = validateCollectionMaxLength([1], 3);
      expect(result.isRight(), isTrue);
    });

    test('debe rechazar cuando supera el máximo', () {
      final result = validateCollectionMaxLength([1, 2, 3, 4], 2);
      expect(result.isLeft(), isTrue);
      expect(result.fold((f) => f, (_) => null), isA<ValueFailure>());
    });
  });

  group('ValueListContains', () {
    test('debe ser válido cuando contiene el elemento', () {
      final vo = ValueListContains([1, 2, 3], 2);
      expect(vo.isValid, isTrue);
      expect(vo.orEmpty, [1, 2, 3]);
    });

    test('debe fallar cuando no contiene el elemento', () {
      final vo = ValueListContains([1, 2, 3], 9);
      expect(vo.isValid, isFalse);
      expect(vo.orEmpty, <int>[]);
    });

    test('debe fallar en lista vacía', () {
      final vo = ValueListContains<int>([], 1);
      expect(vo.isValid, isFalse);
    });
  });

  group('ValueListNotContains', () {
    test('debe ser válido cuando no contiene el elemento', () {
      final vo = ValueListNotContains([1, 2, 3], 9);
      expect(vo.isValid, isTrue);
      expect(vo.orEmpty, [1, 2, 3]);
    });

    test('debe fallar cuando contiene el elemento', () {
      final vo = ValueListNotContains([1, 2, 3], 2);
      expect(vo.isValid, isFalse);
      expect(vo.orEmpty, <int>[]);
    });

    test('debe ser válido en lista vacía', () {
      final vo = ValueListNotContains<int>([], 1);
      expect(vo.isValid, isTrue);
      expect(vo.orEmpty, <int>[]);
    });
  });

  group('ValueListMinLength', () {
    test('debe ser válido cuando alcanza el mínimo', () {
      final vo = ValueListMinLength([1, 2, 3], 2);
      expect(vo.isValid, isTrue);
      expect(vo.orEmpty, [1, 2, 3]);
    });

    test('debe fallar cuando no alcanza el mínimo', () {
      final vo = ValueListMinLength([1], 2);
      expect(vo.isValid, isFalse);
      expect(vo.orEmpty, <int>[]);
    });
  });

  group('ValueListMaxLength', () {
    test('debe ser válido cuando está dentro del máximo', () {
      final vo = ValueListMaxLength([1, 2], 3);
      expect(vo.isValid, isTrue);
      expect(vo.orEmpty, [1, 2]);
    });

    test('debe fallar cuando supera el máximo', () {
      final vo = ValueListMaxLength([1, 2, 3, 4], 3);
      expect(vo.isValid, isFalse);
      expect(vo.orEmpty, <int>[]);
    });
  });

  group('ValueListLengthRange', () {
    test('debe ser válido dentro del rango', () {
      final vo = ValueListLengthRange([1, 2, 3], min: 1, max: 5);
      expect(vo.isValid, isTrue);
      expect(vo.orEmpty, [1, 2, 3]);
    });

    test('debe fallar por debajo del mínimo', () {
      final vo = ValueListLengthRange([1], min: 2, max: 5);
      expect(vo.isValid, isFalse);
    });

    test('debe fallar por encima del máximo', () {
      final vo = ValueListLengthRange([1, 2, 3, 4, 5, 6], min: 1, max: 5);
      expect(vo.isValid, isFalse);
    });

    test('debe validar en los límites exactos', () {
      expect(ValueListLengthRange([1, 2], min: 2, max: 2).isValid, isTrue);
    });
  });

  group('ValueOptionUniqueList', () {
    test('debe ser válido (none) cuando se pasa null', () {
      final vo = ValueOptionUniqueList<int>(null);
      expect(vo.isValid, isTrue);
      expect(vo.orEmpty, <int>[]);
    });

    test('debe ser válido con lista de elementos únicos', () {
      final vo = ValueOptionUniqueList([1, 2, 3]);
      expect(vo.isValid, isTrue);
      expect(vo.orEmpty, [1, 2, 3]);
    });

    test('debe fallar con elementos duplicados', () {
      final vo = ValueOptionUniqueList([1, 2, 2]);
      expect(vo.isValid, isFalse);
      expect(vo.orEmpty, <int>[]);
    });

    test('debe ser válido (none) con lista vacía', () {
      final vo = ValueOptionUniqueList<int>([]);
      expect(vo.isValid, isTrue);
    });
  });

  group('ValueOptionUniqueListNotEmpty', () {
    test('debe ser válido (none) cuando se pasa null', () {
      final vo = ValueOptionUniqueListNotEmpty<int>(null);
      expect(vo.isValid, isTrue);
      expect(vo.orEmpty, <int>[]);
    });

    test('debe ser válido con lista no vacía y única', () {
      final vo = ValueOptionUniqueListNotEmpty([1, 2, 3]);
      expect(vo.isValid, isTrue);
      expect(vo.orEmpty, [1, 2, 3]);
    });

    test('debe fallar con lista vacía', () {
      final vo = ValueOptionUniqueListNotEmpty<int>([]);
      expect(vo.isValid, isFalse);
    });

    test('debe fallar con elementos duplicados', () {
      final vo = ValueOptionUniqueListNotEmpty([1, 2, 2]);
      expect(vo.isValid, isFalse);
    });
  });

  group('ValueOptionListNotEmpty', () {
    test('debe ser válido (como none) cuando se pasa null', () {
      final vo = ValueOptionListNotEmpty<int>(null);
      expect(vo.isValid, isTrue);
      expect(vo.orEmpty, <int>[]);
    });

    test('debe ser válido con la lista cuando se pasa una lista no vacía', () {
      final vo = ValueOptionListNotEmpty([1, 2, 3]);
      expect(vo.isValid, isTrue);
      expect(vo.orEmpty, [1, 2, 3]);
    });

    test('debe fallar cuando se pasa una lista vacía', () {
      final vo = ValueOptionListNotEmpty<int>([]);
      expect(vo.isValid, isFalse);
      expect(vo.orEmpty, <int>[]);
    });

    test('debe manejar tipos genéricos con valor presente', () {
      final vo = ValueOptionListNotEmpty<String>(['a', 'b']);
      expect(vo.isValid, isTrue);
      expect(vo.orEmpty, ['a', 'b']);
    });
  });

  group('Edge Cases', () {
    test('debe manejar listas con nulls', () {
      final list = [null, null];
      final vo = ValueListNotEmpty<int?>(list);
      expect(vo.isValid, isTrue);
      expect(vo.orEmpty, list);
    });

    test('debe validar unicidad con nulls', () {
      final list = [null, 1, null];
      final vo = ValueUniqueList<int?>(list);
      expect(vo.isValid, isFalse); // null se considera duplicado
    });

    test('debe validar contención con null', () {
      final result = validateCollectionContains([null, 1, 2], null);
      expect(result.isRight(), isTrue);
    });

    test('debe rechazar contención de null en lista sin null', () {
      final result = validateCollectionContains([1, 2, 3], null);
      expect(result.isLeft(), isTrue);
    });

    test('debe manejar strings vacías en listas', () {
      final list = ['', 'a', ''];
      final vo = ValueUniqueList(list);
      expect(vo.isValid, isFalse); // strings vacías duplicadas
    });

    test('debe validar lista con un solo elemento duplicado', () {
      final list = [1, 1];
      final vo = ValueUniqueList(list);
      expect(vo.isValid, isFalse);
    });
  });
}
