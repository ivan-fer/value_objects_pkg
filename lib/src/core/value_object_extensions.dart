import 'package:fpdart/fpdart.dart';
import 'package:intl/intl.dart';

import 'value_object.dart';

extension ValueObjectExt<T> on ValueObject<T> {
  T? get orNull => value.toNullable();

  T orElse(T Function() orElse) => value.getOrElse((f) => orElse());

  /// Returns the value or a default value
  T orDefault(T defaultValue) => value.getOrElse((f) => defaultValue);
}

extension ValueObjectOptionExt<C> on ValueObject<Option<C>> {
  /// Returns the contained value, or `orElse()` if there is failure or none.
  /// It is equivalent to orElse (which already exists in the base class)
  /// but more specific for Option.
  C orElse(C Function() orElse) =>
      value.fold((f) => orElse(), (opt) => opt.getOrElse(() => orElse()));
  C orDefault(C defaultValue) => value.fold(
    (f) => defaultValue,
    (opt) => opt.getOrElse(() => defaultValue),
  );

  C? get orNull =>
      value.fold((failure) => null, (option) => option.toNullable());

  /// Returns `true` if the value is `None`
  bool isNone() => value.fold((f) => false, (r) => r.isNone());

  /// Returns `true` if the value is `Some` (exists and is valid)
  bool isSome() => value.fold((f) => false, (r) => r.isSome());
}

extension ValueObjectStringExt on ValueObject<String> {
  /// return the string value or empty string if is a failure
  String get orEmpty => value.getOrElse((f) => '');
}

extension ValueObjectDoubleExt on ValueObject<double> {
  /// return the double value or 0.0 if is a failure
  double get orZero => value.getOrElse((f) => 0.0);

  String formatCurrency({String locale = 'en_US', String symbol = '\$'}) {
    final number = value.getOrElse((f) => 0.0);
    return NumberFormat.currency(locale: locale, symbol: symbol).format(number);
  }
}

extension ValueObjectOptionStringExt on ValueObject<Option<String>> {
  /// return the string value or empty string if is none or failure
  String get orEmpty =>
      value.fold((f) => '', (r) => r.fold(() => '', (s) => s));
}

extension ValueObjectIntExt on ValueObject<int> {
  /// return the int value or 0 if is a failure
  int get orZero => value.getOrElse((f) => 0);
}

extension ValueObjectNumExt on ValueObject<num> {
  /// return the numeric value or 0 if is a failure
  num get orZero => value.getOrElse((f) => 0);
}

extension ValueObjectOptionDoubleExt on ValueObject<Option<double>> {
  /// return the double value or 0.0 if is none or failure
  double get orZero => value.fold((f) => 0.0, (r) => r.getOrElse(() => 0.0));
}

extension ValueObjectOptionIntExt on ValueObject<Option<int>> {
  /// return the int value or 0 if is none or failure
  int get orZero => value.fold((f) => 0, (r) => r.getOrElse(() => 0));
}

extension ValueObjectOptionNumExt on ValueObject<Option<num>> {
  /// return the numeric value or 0 if is none or failure
  num get orZero => value.fold((f) => 0, (r) => r.getOrElse(() => 0));
}
