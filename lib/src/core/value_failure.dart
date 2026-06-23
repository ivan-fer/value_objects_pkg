import 'package:freezed_annotation/freezed_annotation.dart';

part 'value_failure.freezed.dart';

@freezed
sealed class ValueFailure with _$ValueFailure {
  const ValueFailure._(); // Constructor privado para agregar métodos/getters

  /// Retorna el mensaje de error personalizado si existe,
  /// de lo contrario retorna un mensaje por defecto según el tipo de fallo.
  String get errorMessage {
    if (message.isNotEmpty) return message;

    return switch (this) {
      StrEmpty() => 'This field cannot be empty',
      StrMaxLength(maxAllow: final max, total: final total) =>
        'Too long ($total/$max characters)',
      StrMinLength(minAllow: final min, total: final total) =>
        'Too short (entered $total, minimum is $min)',
      StrInvalidChars() => 'Contains invalid characters',
      NotANumber() => 'Input is not a number',
      NotADouble() => 'Input is not a valid decimal',
      NumOutRange(min: final min, max: final max) =>
        'The number must be between $min and $max',
      NumOutMin(minAllow: final min) => 'Value must be at least $min',
      NumOutMax(maxAllow: final max) => 'Value must be at most $max',
      ZeroValue() => 'Value cannot be zero',
      DateOutRange(min: final min, max: final max) =>
        'Date must be between ${min.year} and ${max.year}',
      FutureDateNotAllowed() => 'Future dates are not allowed',
      DateTooOld() => 'The date provided is too far in the past',
      ItemEmpty() => 'The collection cannot be empty',
      ItemRepeats() => 'The collection cannot contain repeated items',
      CollNotContains(nameItem: final item) =>
        'The collection must contain "$item"',
      CollContains(nameItem: final item) =>
        'The collection must not contain "$item"',
      CollTooFew(minAllow: final min, total: final total) =>
        'Too few items (entered $total, minimum is $min)',
      CollTooMany(maxAllow: final max, total: final total) =>
        'Too many items ($total/$max)',
      _ =>
        'Invalid value', // Fallback genérico (incluye Invalid y errores no explícitos)
    };
  }

  // general -----------------------------------------------------

  const factory ValueFailure.invalid({
    /// string name of the object with failure
    @Default('') String nameObject,
    @Default('') String message,
  }) = Invalid;

  /// Value is zero when it should not be
  const factory ValueFailure.zeroValue({
    /// string name of the object with failure
    @Default('') String nameObject,
    @Default('') String message,
  }) = ZeroValue;

  /// Enum value is 'none'
  const factory ValueFailure.enumIsNone({
    /// string name of the object with failure
    @Default('') String nameObject,
    @Default('') String message,
  }) = EnumIsNone;

  // String -----------------------------------------------------

  /// String is empty
  const factory ValueFailure.strEmpty({
    /// string name of the object with failure
    @Default('') String nameObject,
    @Default('') String message,
  }) = StrEmpty;

  /// String is multiline
  const factory ValueFailure.strMultiline({
    /// string name of the object with failure
    @Default('') String nameObject,
    @Default('') String message,
  }) = StrMultiline;

  /// String exceed max limit
  const factory ValueFailure.strMaxLength({
    /// string name of the object with failure
    @Default('') String nameObject,
    @Default('') String message,

    /// the max characters allow in the string
    required int maxAllow,

    /// length of the input string
    required int total,
  }) = StrMaxLength;

  const factory ValueFailure.strMinLength({
    /// string name of the object with failure
    @Default('') String nameObject,
    @Default('') String message,

    /// the min characters allow in the string
    required int minAllow,

    /// length of the input string
    required int total,
  }) = StrMinLength;

  /// String is out of range
  const factory ValueFailure.strOutRange({
    /// string name of the object with failure
    @Default('') String nameObject,
    @Default('') String message,
    required num min,
    required num max,
  }) = StrOutRange;

  /// String contains invalid characters
  const factory ValueFailure.strInvalidChars({
    /// string name of the object with failure
    @Default('') String nameObject,
    @Default('') String message,
  }) = StrInvalidChars;

  /// String does not contain a specified substring
  const factory ValueFailure.strNotContains({
    /// string name of the object with failure
    @Default('') String nameObject,
    @Default('') String message,

    /// substring intended to find
    @Default('') String substring,
  }) = StrNotContains;

  /// String does not start with a specified substring
  const factory ValueFailure.strNotStartsWith({
    /// string name of the object with failure
    @Default('') String nameObject,
    @Default('') String message,

    /// substring intended to find
    @Default('') String prefix,
  }) = StrNotStartsWith;

  // numbers ----------------------------------------------------
  const factory ValueFailure.notANumber({
    /// string name of the object with failure
    @Default('') String nameObject,
    @Default('') String message,
    String? failedValue,
  }) = NotANumber;
  const factory ValueFailure.notAnInt({
    /// string name of the object with failure
    @Default('') String nameObject,
    @Default('') String message,
    String? failedValue,
  }) = NotAnInt;
  const factory ValueFailure.notADouble({
    /// string name of the object with failure
    @Default('') String nameObject,
    @Default('') String message,
    String? failedValue,
  }) = NotADouble;

  const factory ValueFailure.numOutRange({
    /// string name of the object with failure
    @Default('') String nameObject,
    @Default('') String message,
    num? failedValue,
    required num min,
    required num max,
  }) = NumOutRange;

  /// String exceed max limit
  const factory ValueFailure.numOutMax({
    /// string name of the object with failure
    @Default('') String nameObject,
    @Default('') String message,
    num? failedValue,

    /// max value allow
    required num maxAllow,
  }) = NumOutMax;

  const factory ValueFailure.numOutMin({
    /// string name of the object with failure
    @Default('') String nameObject,
    @Default('') String message,
    num? failedValue,

    /// min value allow
    required num minAllow,
  }) = NumOutMin;

  /// Value cannot be negative
  const factory ValueFailure.negativeValue({
    /// string name of the object with failure
    @Default('') String nameObject,
    @Default('') String message,
    num? failedValue,
  }) = NegativeValue;

  /// Value is unreasonably high
  const factory ValueFailure.valueExceedsLimit({
    /// string name of the object with failure
    @Default('') String nameObject,
    @Default('') String message,
    num? failedValue,
    required num limit,
  }) = ValueExceedsLimit;

  // dates ------------------------------------------------------
  const factory ValueFailure.dateOutRange({
    /// string name of the object with failure
    @Default('') String nameObject,
    @Default('') String message,
    required DateTime min,
    required DateTime max,
  }) = DateOutRange;

  /// Date is in the future
  const factory ValueFailure.futureDateNotAllowed({
    /// string name of the object with failure
    @Default('') String nameObject,
    @Default('') String message,
    DateTime? failedValue,
  }) = FutureDateNotAllowed;

  /// Date is too old to be valid
  const factory ValueFailure.dateTooOld({
    /// string name of the object with failure
    @Default('') String nameObject,
    @Default('') String message,
    DateTime? failedValue,
    required Duration maxAge,
  }) = DateTooOld;

  // collections ------------------------------------------------------

  /// Collection is empty
  const factory ValueFailure.collEmpty({
    /// string name of the object with failure
    @Default('') String nameObject,
    @Default('') String message,
  }) = ItemEmpty;

  /// Collection have repeat items
  const factory ValueFailure.collRepeatItems({
    /// string name of the object with failure
    @Default('') String nameObject,
    @Default('') String message,
  }) = ItemRepeats;

  /// Collection does not contain a specified item
  const factory ValueFailure.collNotContains({
    /// string name of the object with failure
    @Default('') String nameObject,
    @Default('') String message,
    @Default('') String nameItem,
  }) = CollNotContains;

  /// Collection contains a specified item
  const factory ValueFailure.collContains({
    /// string name of the object with failure
    @Default('') String nameObject,
    @Default('') String message,
    @Default('') String nameItem,
  }) = CollContains;

  /// Collection has fewer items than allowed
  const factory ValueFailure.collTooFew({
    /// string name of the object with failure
    @Default('') String nameObject,
    @Default('') String message,
    required int minAllow,
    required int total,
  }) = CollTooFew;

  /// Collection has more items than allowed
  const factory ValueFailure.collTooMany({
    /// string name of the object with failure
    @Default('') String nameObject,
    @Default('') String message,
    required int maxAllow,
    required int total,
  }) = CollTooMany;

  const factory ValueFailure.insufficientStock({
    @Default('') String nameObject,
    @Default('') String message,
    required int available,
    required double requested,
  }) = InsufficientStock;
}
