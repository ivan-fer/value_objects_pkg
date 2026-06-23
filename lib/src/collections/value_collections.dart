import 'package:fpdart/fpdart.dart';
import 'package:value_objects_pkg/src/core/value_failure.dart';
import 'package:value_objects_pkg/src/core/value_object.dart';

// ---------------------------------------------------------------------------
// Validation Functions
// ---------------------------------------------------------------------------

/// Validate that a collection is not empty.
Either<ValueFailure, List<T>> validateCollectionNotEmpty<T>(List<T> input) =>
    input.isEmpty
    ? left(ValueFailure.collEmpty(nameObject: 'Collection of $T'))
    : right(input);

/// Validate that all items in a collection are unique (no repeated items).
Either<ValueFailure, List<T>> validateCollectionUniqueItems<T>(List<T> input) {
  final set = input.toSet();
  if (set.length != input.length) {
    return left(ValueFailure.collRepeatItems(nameObject: 'Collection of $T'));
  }
  return right(input);
}

/// Validate that an item is present in the collection.
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

/// Validate that an item is NOT present in the collection.
Either<ValueFailure, List<T>> validateCollectionNotContains<T>(
  List<T> input,
  T item,
) {
  if (input.contains(item)) {
    return left(
      ValueFailure.collContains(
        nameObject: 'Collection of $T',
        nameItem: item.toString(),
      ),
    );
  }
  return right(input);
}

/// Validate that a collection has at least [min] items.
Either<ValueFailure, List<T>> validateCollectionMinLength<T>(
  List<T> input,
  int min,
) {
  if (input.length < min) {
    return left(
      ValueFailure.collTooFew(
        nameObject: 'Collection of $T',
        minAllow: min,
        total: input.length,
      ),
    );
  }
  return right(input);
}

/// Validate that a collection has at most [max] items.
Either<ValueFailure, List<T>> validateCollectionMaxLength<T>(
  List<T> input,
  int max,
) {
  if (input.length > max) {
    return left(
      ValueFailure.collTooMany(
        nameObject: 'Collection of $T',
        maxAllow: max,
        total: input.length,
      ),
    );
  }
  return right(input);
}

// ---------------------------------------------------------------------------
// Base Classes
// ---------------------------------------------------------------------------

/// Abstract base class for ValueObjects that hold a list.
abstract class ValueList<T> extends ValueObject<List<T>> {
  @override
  final Either<ValueFailure, List<T>> value;

  const ValueList(this.value);

  @override
  String? validate() => value.failureMessage;

  /// Returns the valid list, or an empty list when the object is invalid.
  List<T> get orEmpty => value.getOrElse((_) => <T>[]);
}

/// Abstract base class for optional list ValueObjects.
abstract class ValueOptionList<T> extends ValueObject<Option<List<T>>> {
  @override
  final Either<ValueFailure, Option<List<T>>> value;

  const ValueOptionList(this.value);

  @override
  String? validate() => value.failureMessage;

  /// Returns the valid list, or an empty list when the object is invalid
  /// or absent (`none`).
  List<T> get orEmpty => value.getOrElse((_) => none()).getOrElse(() => <T>[]);
}

// ---------------------------------------------------------------------------
// Implementations
// ---------------------------------------------------------------------------

/// A list guaranteed to hold at least one element.
class ValueListNotEmpty<T> extends ValueList<T> {
  factory ValueListNotEmpty(List<T> input) {
    final result = validateCollectionNotEmpty(input);
    return ValueListNotEmpty._(result);
  }

  const ValueListNotEmpty._(super.value);
}

/// A list guaranteed to have all unique elements.
class ValueUniqueList<T> extends ValueList<T> {
  factory ValueUniqueList(List<T> input) {
    final result = validateCollectionUniqueItems(input);
    return ValueUniqueList._(result);
  }

  const ValueUniqueList._(super.value);
}

/// A list guaranteed to hold at least one element and to have all unique
/// elements.
class ValueUniqueListNotEmpty<T> extends ValueList<T> {
  factory ValueUniqueListNotEmpty(List<T> input) {
    final result = validateCollectionNotEmpty(
      input,
    ).flatMap(validateCollectionUniqueItems);
    return ValueUniqueListNotEmpty._(result);
  }

  const ValueUniqueListNotEmpty._(super.value);
}

/// A list guaranteed to contain a specific element.
class ValueListContains<T> extends ValueList<T> {
  factory ValueListContains(List<T> input, T item) {
    final result = validateCollectionContains(input, item);
    return ValueListContains._(result.map((_) => input));
  }

  const ValueListContains._(super.value);
}

/// A list guaranteed not to contain a specific element.
class ValueListNotContains<T> extends ValueList<T> {
  factory ValueListNotContains(List<T> input, T item) {
    final result = validateCollectionNotContains(input, item);
    return ValueListNotContains._(result);
  }

  const ValueListNotContains._(super.value);
}

/// A list guaranteed to hold at least [min] elements.
class ValueListMinLength<T> extends ValueList<T> {
  factory ValueListMinLength(List<T> input, int min) {
    final result = validateCollectionMinLength(input, min);
    return ValueListMinLength._(result);
  }

  const ValueListMinLength._(super.value);
}

/// A list guaranteed to hold at most [max] elements.
class ValueListMaxLength<T> extends ValueList<T> {
  factory ValueListMaxLength(List<T> input, int max) {
    final result = validateCollectionMaxLength(input, max);
    return ValueListMaxLength._(result);
  }

  const ValueListMaxLength._(super.value);
}

/// A list guaranteed to hold between [min] and [max] elements (inclusive).
class ValueListLengthRange<T> extends ValueList<T> {
  factory ValueListLengthRange(
    List<T> input, {
    required int min,
    required int max,
  }) {
    final result = validateCollectionMinLength(
      input,
      min,
    ).flatMap((list) => validateCollectionMaxLength(list, max));
    return ValueListLengthRange._(result);
  }

  const ValueListLengthRange._(super.value);
}

/// An optional list. When present, behaves like [ValueListNotEmpty];
/// when `null`, it is valid and resolves to `none`.
class ValueOptionListNotEmpty<T> extends ValueOptionList<T> {
  factory ValueOptionListNotEmpty(List<T>? input) {
    if (input == null) {
      return ValueOptionListNotEmpty._(right(const None()));
    }
    final result = validateCollectionNotEmpty(input).map(some);
    return ValueOptionListNotEmpty._(result);
  }

  const ValueOptionListNotEmpty._(super.value);
}

/// An optional list. When present, behaves like [ValueUniqueList];
/// when `null`, it is valid and resolves to `none`.
class ValueOptionUniqueList<T> extends ValueOptionList<T> {
  factory ValueOptionUniqueList(List<T>? input) {
    if (input == null) {
      return ValueOptionUniqueList._(right(const None()));
    }
    final result = validateCollectionUniqueItems(input).map(some);
    return ValueOptionUniqueList._(result);
  }

  const ValueOptionUniqueList._(super.value);
}

/// An optional list. When present, behaves like [ValueUniqueListNotEmpty];
/// when `null`, it is valid and resolves to `none`.
class ValueOptionUniqueListNotEmpty<T> extends ValueOptionList<T> {
  factory ValueOptionUniqueListNotEmpty(List<T>? input) {
    if (input == null) {
      return ValueOptionUniqueListNotEmpty._(right(const None()));
    }
    final result = validateCollectionNotEmpty(
      input,
    ).flatMap(validateCollectionUniqueItems).map(some);
    return ValueOptionUniqueListNotEmpty._(result);
  }

  const ValueOptionUniqueListNotEmpty._(super.value);
}
