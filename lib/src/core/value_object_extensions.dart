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
}

extension ValueObjectStringExt on ValueObject<String> {
  /// return the string value or empty string if is a failure
  String get orEmpty => value.getOrElse((f) => '');
}

extension ValueObjectDoubleExt on ValueObject<double> {
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
