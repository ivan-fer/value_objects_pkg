import 'package:fpdart/fpdart.dart';
import 'package:value_objects_pkg/src/core/value_failure.dart';
import 'package:value_objects_pkg/src/core/value_object.dart';

// ---------------------------------------------------------------------------
// Validation Functions
// ---------------------------------------------------------------------------

/// validate if a collection is not empty
Either<ValueFailure, List<T>> validateCollectionNotEmpty<T>(List<T> input) =>
    input.isEmpty
    ? left(ValueFailure.collEmpty(nameObject: 'Collection of $T'))
    : right(input);

/// validate if items in a collection are unique (no repeat items)
Either<ValueFailure, List<T>> validateCollectionUniqueItems<T>(List<T> input) {
  final set = input.toSet();
  if (set.length != input.length) {
    return left(ValueFailure.collRepeatItems(nameObject: 'Collection of $T'));
  }
  return right(input);
}

/// validate if a item is in the collection
Either<ValueFailure, T> validateCollectionContains<T>(List<T> input, T item) {
  if (!input.contains(item)) {
    return left(
      ValueFailure.collNotContains(
        nameObject: 'Collection of $T',
        nameItem: item.toString(),
      ),
    );
  }
  return right(item);
}

// ---------------------------------------------------------------------------
// Base Classes
// ---------------------------------------------------------------------------

/// Clase base abstracta para ValueObjects que manejan listas.
abstract class ValueList<T> extends ValueObject<List<T>> {
  @override
  final Either<ValueFailure, List<T>> value;

  const ValueList(this.value);

  @override
  String? validate() => value.failureMessage;

  /// Retorna la lista válida o una lista vacía si hay un fallo.
  /// Muy útil para inicializar UI (ej. ListView.builder).
  List<T> get orEmpty => value.getOrElse((_) => <T>[]);
}

// ---------------------------------------------------------------------------
// Implementations
// ---------------------------------------------------------------------------

/// Una lista que garantiza tener al menos un elemento.
class ValueListNotEmpty<T> extends ValueList<T> {
  factory ValueListNotEmpty(List<T> input) {
    final result = validateCollectionNotEmpty(input);
    return ValueListNotEmpty._(result);
  }

  const ValueListNotEmpty._(super.value);
}

/// Una lista que garantiza que todos sus elementos sean únicos.
class ValueUniqueList<T> extends ValueList<T> {
  factory ValueUniqueList(List<T> input) {
    final result = validateCollectionUniqueItems(input);
    return ValueUniqueList._(result);
  }

  const ValueUniqueList._(super.value);
}

/// Una lista que garantiza tener al menos un elemento y que todos sean únicos.
class ValueUniqueListNotEmpty<T> extends ValueList<T> {
  factory ValueUniqueListNotEmpty(List<T> input) {
    final result = validateCollectionNotEmpty(
      input,
    ).flatMap(validateCollectionUniqueItems);
    return ValueUniqueListNotEmpty._(result);
  }

  const ValueUniqueListNotEmpty._(super.value);
}
