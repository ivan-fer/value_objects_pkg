// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'value_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ValueFailure implements DiagnosticableTreeMixin {

/// string name of the object with failure
 String get nameObject; String get message;
/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ValueFailureCopyWith<ValueFailure> get copyWith => _$ValueFailureCopyWithImpl<ValueFailure>(this as ValueFailure, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ValueFailure'))
    ..add(DiagnosticsProperty('nameObject', nameObject))..add(DiagnosticsProperty('message', message));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ValueFailure&&(identical(other.nameObject, nameObject) || other.nameObject == nameObject)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,nameObject,message);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ValueFailure(nameObject: $nameObject, message: $message)';
}


}

/// @nodoc
abstract mixin class $ValueFailureCopyWith<$Res>  {
  factory $ValueFailureCopyWith(ValueFailure value, $Res Function(ValueFailure) _then) = _$ValueFailureCopyWithImpl;
@useResult
$Res call({
 String nameObject, String message
});




}
/// @nodoc
class _$ValueFailureCopyWithImpl<$Res>
    implements $ValueFailureCopyWith<$Res> {
  _$ValueFailureCopyWithImpl(this._self, this._then);

  final ValueFailure _self;
  final $Res Function(ValueFailure) _then;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nameObject = null,Object? message = null,}) {
  return _then(_self.copyWith(
nameObject: null == nameObject ? _self.nameObject : nameObject // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ValueFailure].
extension ValueFailurePatterns on ValueFailure {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Invalid value)?  invalid,TResult Function( ZeroValue value)?  zeroValue,TResult Function( EnumIsNone value)?  enumIsNone,TResult Function( StrEmpty value)?  strEmpty,TResult Function( StrMultiline value)?  strMultiline,TResult Function( StrMaxLength value)?  strMaxLength,TResult Function( StrMinLength value)?  strMinLength,TResult Function( StrOutRange value)?  strOutRange,TResult Function( StrInvalidChars value)?  strInvalidChars,TResult Function( StrNotContains value)?  strNotContains,TResult Function( StrNotStartsWith value)?  strNotStartsWith,TResult Function( NotANumber value)?  notANumber,TResult Function( NotAnInt value)?  notAnInt,TResult Function( NotADouble value)?  notADouble,TResult Function( NumOutRange value)?  numOutRange,TResult Function( NumOutMax value)?  numOutMax,TResult Function( NumOutMin value)?  numOutMin,TResult Function( NegativeValue value)?  negativeValue,TResult Function( ValueExceedsLimit value)?  valueExceedsLimit,TResult Function( DateOutRange value)?  dateOutRange,TResult Function( FutureDateNotAllowed value)?  futureDateNotAllowed,TResult Function( DateTooOld value)?  dateTooOld,TResult Function( ItemEmpty value)?  collEmpty,TResult Function( ItemRepeats value)?  collRepeatItems,TResult Function( CollNotContains value)?  collNotContains,TResult Function( InsufficientStock value)?  insufficientStock,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Invalid() when invalid != null:
return invalid(_that);case ZeroValue() when zeroValue != null:
return zeroValue(_that);case EnumIsNone() when enumIsNone != null:
return enumIsNone(_that);case StrEmpty() when strEmpty != null:
return strEmpty(_that);case StrMultiline() when strMultiline != null:
return strMultiline(_that);case StrMaxLength() when strMaxLength != null:
return strMaxLength(_that);case StrMinLength() when strMinLength != null:
return strMinLength(_that);case StrOutRange() when strOutRange != null:
return strOutRange(_that);case StrInvalidChars() when strInvalidChars != null:
return strInvalidChars(_that);case StrNotContains() when strNotContains != null:
return strNotContains(_that);case StrNotStartsWith() when strNotStartsWith != null:
return strNotStartsWith(_that);case NotANumber() when notANumber != null:
return notANumber(_that);case NotAnInt() when notAnInt != null:
return notAnInt(_that);case NotADouble() when notADouble != null:
return notADouble(_that);case NumOutRange() when numOutRange != null:
return numOutRange(_that);case NumOutMax() when numOutMax != null:
return numOutMax(_that);case NumOutMin() when numOutMin != null:
return numOutMin(_that);case NegativeValue() when negativeValue != null:
return negativeValue(_that);case ValueExceedsLimit() when valueExceedsLimit != null:
return valueExceedsLimit(_that);case DateOutRange() when dateOutRange != null:
return dateOutRange(_that);case FutureDateNotAllowed() when futureDateNotAllowed != null:
return futureDateNotAllowed(_that);case DateTooOld() when dateTooOld != null:
return dateTooOld(_that);case ItemEmpty() when collEmpty != null:
return collEmpty(_that);case ItemRepeats() when collRepeatItems != null:
return collRepeatItems(_that);case CollNotContains() when collNotContains != null:
return collNotContains(_that);case InsufficientStock() when insufficientStock != null:
return insufficientStock(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Invalid value)  invalid,required TResult Function( ZeroValue value)  zeroValue,required TResult Function( EnumIsNone value)  enumIsNone,required TResult Function( StrEmpty value)  strEmpty,required TResult Function( StrMultiline value)  strMultiline,required TResult Function( StrMaxLength value)  strMaxLength,required TResult Function( StrMinLength value)  strMinLength,required TResult Function( StrOutRange value)  strOutRange,required TResult Function( StrInvalidChars value)  strInvalidChars,required TResult Function( StrNotContains value)  strNotContains,required TResult Function( StrNotStartsWith value)  strNotStartsWith,required TResult Function( NotANumber value)  notANumber,required TResult Function( NotAnInt value)  notAnInt,required TResult Function( NotADouble value)  notADouble,required TResult Function( NumOutRange value)  numOutRange,required TResult Function( NumOutMax value)  numOutMax,required TResult Function( NumOutMin value)  numOutMin,required TResult Function( NegativeValue value)  negativeValue,required TResult Function( ValueExceedsLimit value)  valueExceedsLimit,required TResult Function( DateOutRange value)  dateOutRange,required TResult Function( FutureDateNotAllowed value)  futureDateNotAllowed,required TResult Function( DateTooOld value)  dateTooOld,required TResult Function( ItemEmpty value)  collEmpty,required TResult Function( ItemRepeats value)  collRepeatItems,required TResult Function( CollNotContains value)  collNotContains,required TResult Function( InsufficientStock value)  insufficientStock,}){
final _that = this;
switch (_that) {
case Invalid():
return invalid(_that);case ZeroValue():
return zeroValue(_that);case EnumIsNone():
return enumIsNone(_that);case StrEmpty():
return strEmpty(_that);case StrMultiline():
return strMultiline(_that);case StrMaxLength():
return strMaxLength(_that);case StrMinLength():
return strMinLength(_that);case StrOutRange():
return strOutRange(_that);case StrInvalidChars():
return strInvalidChars(_that);case StrNotContains():
return strNotContains(_that);case StrNotStartsWith():
return strNotStartsWith(_that);case NotANumber():
return notANumber(_that);case NotAnInt():
return notAnInt(_that);case NotADouble():
return notADouble(_that);case NumOutRange():
return numOutRange(_that);case NumOutMax():
return numOutMax(_that);case NumOutMin():
return numOutMin(_that);case NegativeValue():
return negativeValue(_that);case ValueExceedsLimit():
return valueExceedsLimit(_that);case DateOutRange():
return dateOutRange(_that);case FutureDateNotAllowed():
return futureDateNotAllowed(_that);case DateTooOld():
return dateTooOld(_that);case ItemEmpty():
return collEmpty(_that);case ItemRepeats():
return collRepeatItems(_that);case CollNotContains():
return collNotContains(_that);case InsufficientStock():
return insufficientStock(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Invalid value)?  invalid,TResult? Function( ZeroValue value)?  zeroValue,TResult? Function( EnumIsNone value)?  enumIsNone,TResult? Function( StrEmpty value)?  strEmpty,TResult? Function( StrMultiline value)?  strMultiline,TResult? Function( StrMaxLength value)?  strMaxLength,TResult? Function( StrMinLength value)?  strMinLength,TResult? Function( StrOutRange value)?  strOutRange,TResult? Function( StrInvalidChars value)?  strInvalidChars,TResult? Function( StrNotContains value)?  strNotContains,TResult? Function( StrNotStartsWith value)?  strNotStartsWith,TResult? Function( NotANumber value)?  notANumber,TResult? Function( NotAnInt value)?  notAnInt,TResult? Function( NotADouble value)?  notADouble,TResult? Function( NumOutRange value)?  numOutRange,TResult? Function( NumOutMax value)?  numOutMax,TResult? Function( NumOutMin value)?  numOutMin,TResult? Function( NegativeValue value)?  negativeValue,TResult? Function( ValueExceedsLimit value)?  valueExceedsLimit,TResult? Function( DateOutRange value)?  dateOutRange,TResult? Function( FutureDateNotAllowed value)?  futureDateNotAllowed,TResult? Function( DateTooOld value)?  dateTooOld,TResult? Function( ItemEmpty value)?  collEmpty,TResult? Function( ItemRepeats value)?  collRepeatItems,TResult? Function( CollNotContains value)?  collNotContains,TResult? Function( InsufficientStock value)?  insufficientStock,}){
final _that = this;
switch (_that) {
case Invalid() when invalid != null:
return invalid(_that);case ZeroValue() when zeroValue != null:
return zeroValue(_that);case EnumIsNone() when enumIsNone != null:
return enumIsNone(_that);case StrEmpty() when strEmpty != null:
return strEmpty(_that);case StrMultiline() when strMultiline != null:
return strMultiline(_that);case StrMaxLength() when strMaxLength != null:
return strMaxLength(_that);case StrMinLength() when strMinLength != null:
return strMinLength(_that);case StrOutRange() when strOutRange != null:
return strOutRange(_that);case StrInvalidChars() when strInvalidChars != null:
return strInvalidChars(_that);case StrNotContains() when strNotContains != null:
return strNotContains(_that);case StrNotStartsWith() when strNotStartsWith != null:
return strNotStartsWith(_that);case NotANumber() when notANumber != null:
return notANumber(_that);case NotAnInt() when notAnInt != null:
return notAnInt(_that);case NotADouble() when notADouble != null:
return notADouble(_that);case NumOutRange() when numOutRange != null:
return numOutRange(_that);case NumOutMax() when numOutMax != null:
return numOutMax(_that);case NumOutMin() when numOutMin != null:
return numOutMin(_that);case NegativeValue() when negativeValue != null:
return negativeValue(_that);case ValueExceedsLimit() when valueExceedsLimit != null:
return valueExceedsLimit(_that);case DateOutRange() when dateOutRange != null:
return dateOutRange(_that);case FutureDateNotAllowed() when futureDateNotAllowed != null:
return futureDateNotAllowed(_that);case DateTooOld() when dateTooOld != null:
return dateTooOld(_that);case ItemEmpty() when collEmpty != null:
return collEmpty(_that);case ItemRepeats() when collRepeatItems != null:
return collRepeatItems(_that);case CollNotContains() when collNotContains != null:
return collNotContains(_that);case InsufficientStock() when insufficientStock != null:
return insufficientStock(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String nameObject,  String message)?  invalid,TResult Function( String nameObject,  String message)?  zeroValue,TResult Function( String nameObject,  String message)?  enumIsNone,TResult Function( String nameObject,  String message)?  strEmpty,TResult Function( String nameObject,  String message)?  strMultiline,TResult Function( String nameObject,  String message,  int maxAllow,  int total)?  strMaxLength,TResult Function( String nameObject,  String message,  int minAllow,  int total)?  strMinLength,TResult Function( String nameObject,  String message,  num min,  num max)?  strOutRange,TResult Function( String nameObject,  String message)?  strInvalidChars,TResult Function( String nameObject,  String message,  String substring)?  strNotContains,TResult Function( String nameObject,  String message,  String prefix)?  strNotStartsWith,TResult Function( String nameObject,  String message,  String? failedValue)?  notANumber,TResult Function( String nameObject,  String message,  String? failedValue)?  notAnInt,TResult Function( String nameObject,  String message,  String? failedValue)?  notADouble,TResult Function( String nameObject,  String message,  num? failedValue,  num min,  num max)?  numOutRange,TResult Function( String nameObject,  String message,  num? failedValue,  num maxAllow)?  numOutMax,TResult Function( String nameObject,  String message,  num? failedValue,  num minAllow)?  numOutMin,TResult Function( String nameObject,  String message,  num? failedValue)?  negativeValue,TResult Function( String nameObject,  String message,  num? failedValue,  num limit)?  valueExceedsLimit,TResult Function( String nameObject,  String message,  DateTime min,  DateTime max)?  dateOutRange,TResult Function( String nameObject,  String message,  DateTime? failedValue)?  futureDateNotAllowed,TResult Function( String nameObject,  String message,  DateTime? failedValue,  Duration maxAge)?  dateTooOld,TResult Function( String nameObject,  String message)?  collEmpty,TResult Function( String nameObject,  String message)?  collRepeatItems,TResult Function( String nameObject,  String message,  String nameItem)?  collNotContains,TResult Function( String nameObject,  String message,  int available,  double requested)?  insufficientStock,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Invalid() when invalid != null:
return invalid(_that.nameObject,_that.message);case ZeroValue() when zeroValue != null:
return zeroValue(_that.nameObject,_that.message);case EnumIsNone() when enumIsNone != null:
return enumIsNone(_that.nameObject,_that.message);case StrEmpty() when strEmpty != null:
return strEmpty(_that.nameObject,_that.message);case StrMultiline() when strMultiline != null:
return strMultiline(_that.nameObject,_that.message);case StrMaxLength() when strMaxLength != null:
return strMaxLength(_that.nameObject,_that.message,_that.maxAllow,_that.total);case StrMinLength() when strMinLength != null:
return strMinLength(_that.nameObject,_that.message,_that.minAllow,_that.total);case StrOutRange() when strOutRange != null:
return strOutRange(_that.nameObject,_that.message,_that.min,_that.max);case StrInvalidChars() when strInvalidChars != null:
return strInvalidChars(_that.nameObject,_that.message);case StrNotContains() when strNotContains != null:
return strNotContains(_that.nameObject,_that.message,_that.substring);case StrNotStartsWith() when strNotStartsWith != null:
return strNotStartsWith(_that.nameObject,_that.message,_that.prefix);case NotANumber() when notANumber != null:
return notANumber(_that.nameObject,_that.message,_that.failedValue);case NotAnInt() when notAnInt != null:
return notAnInt(_that.nameObject,_that.message,_that.failedValue);case NotADouble() when notADouble != null:
return notADouble(_that.nameObject,_that.message,_that.failedValue);case NumOutRange() when numOutRange != null:
return numOutRange(_that.nameObject,_that.message,_that.failedValue,_that.min,_that.max);case NumOutMax() when numOutMax != null:
return numOutMax(_that.nameObject,_that.message,_that.failedValue,_that.maxAllow);case NumOutMin() when numOutMin != null:
return numOutMin(_that.nameObject,_that.message,_that.failedValue,_that.minAllow);case NegativeValue() when negativeValue != null:
return negativeValue(_that.nameObject,_that.message,_that.failedValue);case ValueExceedsLimit() when valueExceedsLimit != null:
return valueExceedsLimit(_that.nameObject,_that.message,_that.failedValue,_that.limit);case DateOutRange() when dateOutRange != null:
return dateOutRange(_that.nameObject,_that.message,_that.min,_that.max);case FutureDateNotAllowed() when futureDateNotAllowed != null:
return futureDateNotAllowed(_that.nameObject,_that.message,_that.failedValue);case DateTooOld() when dateTooOld != null:
return dateTooOld(_that.nameObject,_that.message,_that.failedValue,_that.maxAge);case ItemEmpty() when collEmpty != null:
return collEmpty(_that.nameObject,_that.message);case ItemRepeats() when collRepeatItems != null:
return collRepeatItems(_that.nameObject,_that.message);case CollNotContains() when collNotContains != null:
return collNotContains(_that.nameObject,_that.message,_that.nameItem);case InsufficientStock() when insufficientStock != null:
return insufficientStock(_that.nameObject,_that.message,_that.available,_that.requested);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String nameObject,  String message)  invalid,required TResult Function( String nameObject,  String message)  zeroValue,required TResult Function( String nameObject,  String message)  enumIsNone,required TResult Function( String nameObject,  String message)  strEmpty,required TResult Function( String nameObject,  String message)  strMultiline,required TResult Function( String nameObject,  String message,  int maxAllow,  int total)  strMaxLength,required TResult Function( String nameObject,  String message,  int minAllow,  int total)  strMinLength,required TResult Function( String nameObject,  String message,  num min,  num max)  strOutRange,required TResult Function( String nameObject,  String message)  strInvalidChars,required TResult Function( String nameObject,  String message,  String substring)  strNotContains,required TResult Function( String nameObject,  String message,  String prefix)  strNotStartsWith,required TResult Function( String nameObject,  String message,  String? failedValue)  notANumber,required TResult Function( String nameObject,  String message,  String? failedValue)  notAnInt,required TResult Function( String nameObject,  String message,  String? failedValue)  notADouble,required TResult Function( String nameObject,  String message,  num? failedValue,  num min,  num max)  numOutRange,required TResult Function( String nameObject,  String message,  num? failedValue,  num maxAllow)  numOutMax,required TResult Function( String nameObject,  String message,  num? failedValue,  num minAllow)  numOutMin,required TResult Function( String nameObject,  String message,  num? failedValue)  negativeValue,required TResult Function( String nameObject,  String message,  num? failedValue,  num limit)  valueExceedsLimit,required TResult Function( String nameObject,  String message,  DateTime min,  DateTime max)  dateOutRange,required TResult Function( String nameObject,  String message,  DateTime? failedValue)  futureDateNotAllowed,required TResult Function( String nameObject,  String message,  DateTime? failedValue,  Duration maxAge)  dateTooOld,required TResult Function( String nameObject,  String message)  collEmpty,required TResult Function( String nameObject,  String message)  collRepeatItems,required TResult Function( String nameObject,  String message,  String nameItem)  collNotContains,required TResult Function( String nameObject,  String message,  int available,  double requested)  insufficientStock,}) {final _that = this;
switch (_that) {
case Invalid():
return invalid(_that.nameObject,_that.message);case ZeroValue():
return zeroValue(_that.nameObject,_that.message);case EnumIsNone():
return enumIsNone(_that.nameObject,_that.message);case StrEmpty():
return strEmpty(_that.nameObject,_that.message);case StrMultiline():
return strMultiline(_that.nameObject,_that.message);case StrMaxLength():
return strMaxLength(_that.nameObject,_that.message,_that.maxAllow,_that.total);case StrMinLength():
return strMinLength(_that.nameObject,_that.message,_that.minAllow,_that.total);case StrOutRange():
return strOutRange(_that.nameObject,_that.message,_that.min,_that.max);case StrInvalidChars():
return strInvalidChars(_that.nameObject,_that.message);case StrNotContains():
return strNotContains(_that.nameObject,_that.message,_that.substring);case StrNotStartsWith():
return strNotStartsWith(_that.nameObject,_that.message,_that.prefix);case NotANumber():
return notANumber(_that.nameObject,_that.message,_that.failedValue);case NotAnInt():
return notAnInt(_that.nameObject,_that.message,_that.failedValue);case NotADouble():
return notADouble(_that.nameObject,_that.message,_that.failedValue);case NumOutRange():
return numOutRange(_that.nameObject,_that.message,_that.failedValue,_that.min,_that.max);case NumOutMax():
return numOutMax(_that.nameObject,_that.message,_that.failedValue,_that.maxAllow);case NumOutMin():
return numOutMin(_that.nameObject,_that.message,_that.failedValue,_that.minAllow);case NegativeValue():
return negativeValue(_that.nameObject,_that.message,_that.failedValue);case ValueExceedsLimit():
return valueExceedsLimit(_that.nameObject,_that.message,_that.failedValue,_that.limit);case DateOutRange():
return dateOutRange(_that.nameObject,_that.message,_that.min,_that.max);case FutureDateNotAllowed():
return futureDateNotAllowed(_that.nameObject,_that.message,_that.failedValue);case DateTooOld():
return dateTooOld(_that.nameObject,_that.message,_that.failedValue,_that.maxAge);case ItemEmpty():
return collEmpty(_that.nameObject,_that.message);case ItemRepeats():
return collRepeatItems(_that.nameObject,_that.message);case CollNotContains():
return collNotContains(_that.nameObject,_that.message,_that.nameItem);case InsufficientStock():
return insufficientStock(_that.nameObject,_that.message,_that.available,_that.requested);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String nameObject,  String message)?  invalid,TResult? Function( String nameObject,  String message)?  zeroValue,TResult? Function( String nameObject,  String message)?  enumIsNone,TResult? Function( String nameObject,  String message)?  strEmpty,TResult? Function( String nameObject,  String message)?  strMultiline,TResult? Function( String nameObject,  String message,  int maxAllow,  int total)?  strMaxLength,TResult? Function( String nameObject,  String message,  int minAllow,  int total)?  strMinLength,TResult? Function( String nameObject,  String message,  num min,  num max)?  strOutRange,TResult? Function( String nameObject,  String message)?  strInvalidChars,TResult? Function( String nameObject,  String message,  String substring)?  strNotContains,TResult? Function( String nameObject,  String message,  String prefix)?  strNotStartsWith,TResult? Function( String nameObject,  String message,  String? failedValue)?  notANumber,TResult? Function( String nameObject,  String message,  String? failedValue)?  notAnInt,TResult? Function( String nameObject,  String message,  String? failedValue)?  notADouble,TResult? Function( String nameObject,  String message,  num? failedValue,  num min,  num max)?  numOutRange,TResult? Function( String nameObject,  String message,  num? failedValue,  num maxAllow)?  numOutMax,TResult? Function( String nameObject,  String message,  num? failedValue,  num minAllow)?  numOutMin,TResult? Function( String nameObject,  String message,  num? failedValue)?  negativeValue,TResult? Function( String nameObject,  String message,  num? failedValue,  num limit)?  valueExceedsLimit,TResult? Function( String nameObject,  String message,  DateTime min,  DateTime max)?  dateOutRange,TResult? Function( String nameObject,  String message,  DateTime? failedValue)?  futureDateNotAllowed,TResult? Function( String nameObject,  String message,  DateTime? failedValue,  Duration maxAge)?  dateTooOld,TResult? Function( String nameObject,  String message)?  collEmpty,TResult? Function( String nameObject,  String message)?  collRepeatItems,TResult? Function( String nameObject,  String message,  String nameItem)?  collNotContains,TResult? Function( String nameObject,  String message,  int available,  double requested)?  insufficientStock,}) {final _that = this;
switch (_that) {
case Invalid() when invalid != null:
return invalid(_that.nameObject,_that.message);case ZeroValue() when zeroValue != null:
return zeroValue(_that.nameObject,_that.message);case EnumIsNone() when enumIsNone != null:
return enumIsNone(_that.nameObject,_that.message);case StrEmpty() when strEmpty != null:
return strEmpty(_that.nameObject,_that.message);case StrMultiline() when strMultiline != null:
return strMultiline(_that.nameObject,_that.message);case StrMaxLength() when strMaxLength != null:
return strMaxLength(_that.nameObject,_that.message,_that.maxAllow,_that.total);case StrMinLength() when strMinLength != null:
return strMinLength(_that.nameObject,_that.message,_that.minAllow,_that.total);case StrOutRange() when strOutRange != null:
return strOutRange(_that.nameObject,_that.message,_that.min,_that.max);case StrInvalidChars() when strInvalidChars != null:
return strInvalidChars(_that.nameObject,_that.message);case StrNotContains() when strNotContains != null:
return strNotContains(_that.nameObject,_that.message,_that.substring);case StrNotStartsWith() when strNotStartsWith != null:
return strNotStartsWith(_that.nameObject,_that.message,_that.prefix);case NotANumber() when notANumber != null:
return notANumber(_that.nameObject,_that.message,_that.failedValue);case NotAnInt() when notAnInt != null:
return notAnInt(_that.nameObject,_that.message,_that.failedValue);case NotADouble() when notADouble != null:
return notADouble(_that.nameObject,_that.message,_that.failedValue);case NumOutRange() when numOutRange != null:
return numOutRange(_that.nameObject,_that.message,_that.failedValue,_that.min,_that.max);case NumOutMax() when numOutMax != null:
return numOutMax(_that.nameObject,_that.message,_that.failedValue,_that.maxAllow);case NumOutMin() when numOutMin != null:
return numOutMin(_that.nameObject,_that.message,_that.failedValue,_that.minAllow);case NegativeValue() when negativeValue != null:
return negativeValue(_that.nameObject,_that.message,_that.failedValue);case ValueExceedsLimit() when valueExceedsLimit != null:
return valueExceedsLimit(_that.nameObject,_that.message,_that.failedValue,_that.limit);case DateOutRange() when dateOutRange != null:
return dateOutRange(_that.nameObject,_that.message,_that.min,_that.max);case FutureDateNotAllowed() when futureDateNotAllowed != null:
return futureDateNotAllowed(_that.nameObject,_that.message,_that.failedValue);case DateTooOld() when dateTooOld != null:
return dateTooOld(_that.nameObject,_that.message,_that.failedValue,_that.maxAge);case ItemEmpty() when collEmpty != null:
return collEmpty(_that.nameObject,_that.message);case ItemRepeats() when collRepeatItems != null:
return collRepeatItems(_that.nameObject,_that.message);case CollNotContains() when collNotContains != null:
return collNotContains(_that.nameObject,_that.message,_that.nameItem);case InsufficientStock() when insufficientStock != null:
return insufficientStock(_that.nameObject,_that.message,_that.available,_that.requested);case _:
  return null;

}
}

}

/// @nodoc


class Invalid extends ValueFailure with DiagnosticableTreeMixin {
  const Invalid({this.nameObject = '', this.message = ''}): super._();
  

/// string name of the object with failure
@override@JsonKey() final  String nameObject;
@override@JsonKey() final  String message;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvalidCopyWith<Invalid> get copyWith => _$InvalidCopyWithImpl<Invalid>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ValueFailure.invalid'))
    ..add(DiagnosticsProperty('nameObject', nameObject))..add(DiagnosticsProperty('message', message));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Invalid&&(identical(other.nameObject, nameObject) || other.nameObject == nameObject)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,nameObject,message);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ValueFailure.invalid(nameObject: $nameObject, message: $message)';
}


}

/// @nodoc
abstract mixin class $InvalidCopyWith<$Res> implements $ValueFailureCopyWith<$Res> {
  factory $InvalidCopyWith(Invalid value, $Res Function(Invalid) _then) = _$InvalidCopyWithImpl;
@override @useResult
$Res call({
 String nameObject, String message
});




}
/// @nodoc
class _$InvalidCopyWithImpl<$Res>
    implements $InvalidCopyWith<$Res> {
  _$InvalidCopyWithImpl(this._self, this._then);

  final Invalid _self;
  final $Res Function(Invalid) _then;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nameObject = null,Object? message = null,}) {
  return _then(Invalid(
nameObject: null == nameObject ? _self.nameObject : nameObject // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ZeroValue extends ValueFailure with DiagnosticableTreeMixin {
  const ZeroValue({this.nameObject = '', this.message = ''}): super._();
  

/// string name of the object with failure
@override@JsonKey() final  String nameObject;
@override@JsonKey() final  String message;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZeroValueCopyWith<ZeroValue> get copyWith => _$ZeroValueCopyWithImpl<ZeroValue>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ValueFailure.zeroValue'))
    ..add(DiagnosticsProperty('nameObject', nameObject))..add(DiagnosticsProperty('message', message));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZeroValue&&(identical(other.nameObject, nameObject) || other.nameObject == nameObject)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,nameObject,message);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ValueFailure.zeroValue(nameObject: $nameObject, message: $message)';
}


}

/// @nodoc
abstract mixin class $ZeroValueCopyWith<$Res> implements $ValueFailureCopyWith<$Res> {
  factory $ZeroValueCopyWith(ZeroValue value, $Res Function(ZeroValue) _then) = _$ZeroValueCopyWithImpl;
@override @useResult
$Res call({
 String nameObject, String message
});




}
/// @nodoc
class _$ZeroValueCopyWithImpl<$Res>
    implements $ZeroValueCopyWith<$Res> {
  _$ZeroValueCopyWithImpl(this._self, this._then);

  final ZeroValue _self;
  final $Res Function(ZeroValue) _then;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nameObject = null,Object? message = null,}) {
  return _then(ZeroValue(
nameObject: null == nameObject ? _self.nameObject : nameObject // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class EnumIsNone extends ValueFailure with DiagnosticableTreeMixin {
  const EnumIsNone({this.nameObject = '', this.message = ''}): super._();
  

/// string name of the object with failure
@override@JsonKey() final  String nameObject;
@override@JsonKey() final  String message;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EnumIsNoneCopyWith<EnumIsNone> get copyWith => _$EnumIsNoneCopyWithImpl<EnumIsNone>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ValueFailure.enumIsNone'))
    ..add(DiagnosticsProperty('nameObject', nameObject))..add(DiagnosticsProperty('message', message));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EnumIsNone&&(identical(other.nameObject, nameObject) || other.nameObject == nameObject)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,nameObject,message);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ValueFailure.enumIsNone(nameObject: $nameObject, message: $message)';
}


}

/// @nodoc
abstract mixin class $EnumIsNoneCopyWith<$Res> implements $ValueFailureCopyWith<$Res> {
  factory $EnumIsNoneCopyWith(EnumIsNone value, $Res Function(EnumIsNone) _then) = _$EnumIsNoneCopyWithImpl;
@override @useResult
$Res call({
 String nameObject, String message
});




}
/// @nodoc
class _$EnumIsNoneCopyWithImpl<$Res>
    implements $EnumIsNoneCopyWith<$Res> {
  _$EnumIsNoneCopyWithImpl(this._self, this._then);

  final EnumIsNone _self;
  final $Res Function(EnumIsNone) _then;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nameObject = null,Object? message = null,}) {
  return _then(EnumIsNone(
nameObject: null == nameObject ? _self.nameObject : nameObject // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class StrEmpty extends ValueFailure with DiagnosticableTreeMixin {
  const StrEmpty({this.nameObject = '', this.message = ''}): super._();
  

/// string name of the object with failure
@override@JsonKey() final  String nameObject;
@override@JsonKey() final  String message;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StrEmptyCopyWith<StrEmpty> get copyWith => _$StrEmptyCopyWithImpl<StrEmpty>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ValueFailure.strEmpty'))
    ..add(DiagnosticsProperty('nameObject', nameObject))..add(DiagnosticsProperty('message', message));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StrEmpty&&(identical(other.nameObject, nameObject) || other.nameObject == nameObject)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,nameObject,message);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ValueFailure.strEmpty(nameObject: $nameObject, message: $message)';
}


}

/// @nodoc
abstract mixin class $StrEmptyCopyWith<$Res> implements $ValueFailureCopyWith<$Res> {
  factory $StrEmptyCopyWith(StrEmpty value, $Res Function(StrEmpty) _then) = _$StrEmptyCopyWithImpl;
@override @useResult
$Res call({
 String nameObject, String message
});




}
/// @nodoc
class _$StrEmptyCopyWithImpl<$Res>
    implements $StrEmptyCopyWith<$Res> {
  _$StrEmptyCopyWithImpl(this._self, this._then);

  final StrEmpty _self;
  final $Res Function(StrEmpty) _then;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nameObject = null,Object? message = null,}) {
  return _then(StrEmpty(
nameObject: null == nameObject ? _self.nameObject : nameObject // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class StrMultiline extends ValueFailure with DiagnosticableTreeMixin {
  const StrMultiline({this.nameObject = '', this.message = ''}): super._();
  

/// string name of the object with failure
@override@JsonKey() final  String nameObject;
@override@JsonKey() final  String message;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StrMultilineCopyWith<StrMultiline> get copyWith => _$StrMultilineCopyWithImpl<StrMultiline>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ValueFailure.strMultiline'))
    ..add(DiagnosticsProperty('nameObject', nameObject))..add(DiagnosticsProperty('message', message));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StrMultiline&&(identical(other.nameObject, nameObject) || other.nameObject == nameObject)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,nameObject,message);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ValueFailure.strMultiline(nameObject: $nameObject, message: $message)';
}


}

/// @nodoc
abstract mixin class $StrMultilineCopyWith<$Res> implements $ValueFailureCopyWith<$Res> {
  factory $StrMultilineCopyWith(StrMultiline value, $Res Function(StrMultiline) _then) = _$StrMultilineCopyWithImpl;
@override @useResult
$Res call({
 String nameObject, String message
});




}
/// @nodoc
class _$StrMultilineCopyWithImpl<$Res>
    implements $StrMultilineCopyWith<$Res> {
  _$StrMultilineCopyWithImpl(this._self, this._then);

  final StrMultiline _self;
  final $Res Function(StrMultiline) _then;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nameObject = null,Object? message = null,}) {
  return _then(StrMultiline(
nameObject: null == nameObject ? _self.nameObject : nameObject // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class StrMaxLength extends ValueFailure with DiagnosticableTreeMixin {
  const StrMaxLength({this.nameObject = '', this.message = '', required this.maxAllow, required this.total}): super._();
  

/// string name of the object with failure
@override@JsonKey() final  String nameObject;
@override@JsonKey() final  String message;
/// the max characters allow in the string
 final  int maxAllow;
/// length of the input string
 final  int total;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StrMaxLengthCopyWith<StrMaxLength> get copyWith => _$StrMaxLengthCopyWithImpl<StrMaxLength>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ValueFailure.strMaxLength'))
    ..add(DiagnosticsProperty('nameObject', nameObject))..add(DiagnosticsProperty('message', message))..add(DiagnosticsProperty('maxAllow', maxAllow))..add(DiagnosticsProperty('total', total));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StrMaxLength&&(identical(other.nameObject, nameObject) || other.nameObject == nameObject)&&(identical(other.message, message) || other.message == message)&&(identical(other.maxAllow, maxAllow) || other.maxAllow == maxAllow)&&(identical(other.total, total) || other.total == total));
}


@override
int get hashCode => Object.hash(runtimeType,nameObject,message,maxAllow,total);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ValueFailure.strMaxLength(nameObject: $nameObject, message: $message, maxAllow: $maxAllow, total: $total)';
}


}

/// @nodoc
abstract mixin class $StrMaxLengthCopyWith<$Res> implements $ValueFailureCopyWith<$Res> {
  factory $StrMaxLengthCopyWith(StrMaxLength value, $Res Function(StrMaxLength) _then) = _$StrMaxLengthCopyWithImpl;
@override @useResult
$Res call({
 String nameObject, String message, int maxAllow, int total
});




}
/// @nodoc
class _$StrMaxLengthCopyWithImpl<$Res>
    implements $StrMaxLengthCopyWith<$Res> {
  _$StrMaxLengthCopyWithImpl(this._self, this._then);

  final StrMaxLength _self;
  final $Res Function(StrMaxLength) _then;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nameObject = null,Object? message = null,Object? maxAllow = null,Object? total = null,}) {
  return _then(StrMaxLength(
nameObject: null == nameObject ? _self.nameObject : nameObject // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,maxAllow: null == maxAllow ? _self.maxAllow : maxAllow // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class StrMinLength extends ValueFailure with DiagnosticableTreeMixin {
  const StrMinLength({this.nameObject = '', this.message = '', required this.minAllow, required this.total}): super._();
  

/// string name of the object with failure
@override@JsonKey() final  String nameObject;
@override@JsonKey() final  String message;
/// the min characters allow in the string
 final  int minAllow;
/// length of the input string
 final  int total;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StrMinLengthCopyWith<StrMinLength> get copyWith => _$StrMinLengthCopyWithImpl<StrMinLength>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ValueFailure.strMinLength'))
    ..add(DiagnosticsProperty('nameObject', nameObject))..add(DiagnosticsProperty('message', message))..add(DiagnosticsProperty('minAllow', minAllow))..add(DiagnosticsProperty('total', total));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StrMinLength&&(identical(other.nameObject, nameObject) || other.nameObject == nameObject)&&(identical(other.message, message) || other.message == message)&&(identical(other.minAllow, minAllow) || other.minAllow == minAllow)&&(identical(other.total, total) || other.total == total));
}


@override
int get hashCode => Object.hash(runtimeType,nameObject,message,minAllow,total);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ValueFailure.strMinLength(nameObject: $nameObject, message: $message, minAllow: $minAllow, total: $total)';
}


}

/// @nodoc
abstract mixin class $StrMinLengthCopyWith<$Res> implements $ValueFailureCopyWith<$Res> {
  factory $StrMinLengthCopyWith(StrMinLength value, $Res Function(StrMinLength) _then) = _$StrMinLengthCopyWithImpl;
@override @useResult
$Res call({
 String nameObject, String message, int minAllow, int total
});




}
/// @nodoc
class _$StrMinLengthCopyWithImpl<$Res>
    implements $StrMinLengthCopyWith<$Res> {
  _$StrMinLengthCopyWithImpl(this._self, this._then);

  final StrMinLength _self;
  final $Res Function(StrMinLength) _then;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nameObject = null,Object? message = null,Object? minAllow = null,Object? total = null,}) {
  return _then(StrMinLength(
nameObject: null == nameObject ? _self.nameObject : nameObject // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,minAllow: null == minAllow ? _self.minAllow : minAllow // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class StrOutRange extends ValueFailure with DiagnosticableTreeMixin {
  const StrOutRange({this.nameObject = '', this.message = '', required this.min, required this.max}): super._();
  

/// string name of the object with failure
@override@JsonKey() final  String nameObject;
@override@JsonKey() final  String message;
 final  num min;
 final  num max;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StrOutRangeCopyWith<StrOutRange> get copyWith => _$StrOutRangeCopyWithImpl<StrOutRange>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ValueFailure.strOutRange'))
    ..add(DiagnosticsProperty('nameObject', nameObject))..add(DiagnosticsProperty('message', message))..add(DiagnosticsProperty('min', min))..add(DiagnosticsProperty('max', max));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StrOutRange&&(identical(other.nameObject, nameObject) || other.nameObject == nameObject)&&(identical(other.message, message) || other.message == message)&&(identical(other.min, min) || other.min == min)&&(identical(other.max, max) || other.max == max));
}


@override
int get hashCode => Object.hash(runtimeType,nameObject,message,min,max);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ValueFailure.strOutRange(nameObject: $nameObject, message: $message, min: $min, max: $max)';
}


}

/// @nodoc
abstract mixin class $StrOutRangeCopyWith<$Res> implements $ValueFailureCopyWith<$Res> {
  factory $StrOutRangeCopyWith(StrOutRange value, $Res Function(StrOutRange) _then) = _$StrOutRangeCopyWithImpl;
@override @useResult
$Res call({
 String nameObject, String message, num min, num max
});




}
/// @nodoc
class _$StrOutRangeCopyWithImpl<$Res>
    implements $StrOutRangeCopyWith<$Res> {
  _$StrOutRangeCopyWithImpl(this._self, this._then);

  final StrOutRange _self;
  final $Res Function(StrOutRange) _then;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nameObject = null,Object? message = null,Object? min = null,Object? max = null,}) {
  return _then(StrOutRange(
nameObject: null == nameObject ? _self.nameObject : nameObject // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,min: null == min ? _self.min : min // ignore: cast_nullable_to_non_nullable
as num,max: null == max ? _self.max : max // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}

/// @nodoc


class StrInvalidChars extends ValueFailure with DiagnosticableTreeMixin {
  const StrInvalidChars({this.nameObject = '', this.message = ''}): super._();
  

/// string name of the object with failure
@override@JsonKey() final  String nameObject;
@override@JsonKey() final  String message;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StrInvalidCharsCopyWith<StrInvalidChars> get copyWith => _$StrInvalidCharsCopyWithImpl<StrInvalidChars>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ValueFailure.strInvalidChars'))
    ..add(DiagnosticsProperty('nameObject', nameObject))..add(DiagnosticsProperty('message', message));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StrInvalidChars&&(identical(other.nameObject, nameObject) || other.nameObject == nameObject)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,nameObject,message);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ValueFailure.strInvalidChars(nameObject: $nameObject, message: $message)';
}


}

/// @nodoc
abstract mixin class $StrInvalidCharsCopyWith<$Res> implements $ValueFailureCopyWith<$Res> {
  factory $StrInvalidCharsCopyWith(StrInvalidChars value, $Res Function(StrInvalidChars) _then) = _$StrInvalidCharsCopyWithImpl;
@override @useResult
$Res call({
 String nameObject, String message
});




}
/// @nodoc
class _$StrInvalidCharsCopyWithImpl<$Res>
    implements $StrInvalidCharsCopyWith<$Res> {
  _$StrInvalidCharsCopyWithImpl(this._self, this._then);

  final StrInvalidChars _self;
  final $Res Function(StrInvalidChars) _then;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nameObject = null,Object? message = null,}) {
  return _then(StrInvalidChars(
nameObject: null == nameObject ? _self.nameObject : nameObject // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class StrNotContains extends ValueFailure with DiagnosticableTreeMixin {
  const StrNotContains({this.nameObject = '', this.message = '', this.substring = ''}): super._();
  

/// string name of the object with failure
@override@JsonKey() final  String nameObject;
@override@JsonKey() final  String message;
/// substring intended to find
@JsonKey() final  String substring;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StrNotContainsCopyWith<StrNotContains> get copyWith => _$StrNotContainsCopyWithImpl<StrNotContains>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ValueFailure.strNotContains'))
    ..add(DiagnosticsProperty('nameObject', nameObject))..add(DiagnosticsProperty('message', message))..add(DiagnosticsProperty('substring', substring));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StrNotContains&&(identical(other.nameObject, nameObject) || other.nameObject == nameObject)&&(identical(other.message, message) || other.message == message)&&(identical(other.substring, substring) || other.substring == substring));
}


@override
int get hashCode => Object.hash(runtimeType,nameObject,message,substring);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ValueFailure.strNotContains(nameObject: $nameObject, message: $message, substring: $substring)';
}


}

/// @nodoc
abstract mixin class $StrNotContainsCopyWith<$Res> implements $ValueFailureCopyWith<$Res> {
  factory $StrNotContainsCopyWith(StrNotContains value, $Res Function(StrNotContains) _then) = _$StrNotContainsCopyWithImpl;
@override @useResult
$Res call({
 String nameObject, String message, String substring
});




}
/// @nodoc
class _$StrNotContainsCopyWithImpl<$Res>
    implements $StrNotContainsCopyWith<$Res> {
  _$StrNotContainsCopyWithImpl(this._self, this._then);

  final StrNotContains _self;
  final $Res Function(StrNotContains) _then;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nameObject = null,Object? message = null,Object? substring = null,}) {
  return _then(StrNotContains(
nameObject: null == nameObject ? _self.nameObject : nameObject // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,substring: null == substring ? _self.substring : substring // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class StrNotStartsWith extends ValueFailure with DiagnosticableTreeMixin {
  const StrNotStartsWith({this.nameObject = '', this.message = '', this.prefix = ''}): super._();
  

/// string name of the object with failure
@override@JsonKey() final  String nameObject;
@override@JsonKey() final  String message;
/// substring intended to find
@JsonKey() final  String prefix;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StrNotStartsWithCopyWith<StrNotStartsWith> get copyWith => _$StrNotStartsWithCopyWithImpl<StrNotStartsWith>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ValueFailure.strNotStartsWith'))
    ..add(DiagnosticsProperty('nameObject', nameObject))..add(DiagnosticsProperty('message', message))..add(DiagnosticsProperty('prefix', prefix));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StrNotStartsWith&&(identical(other.nameObject, nameObject) || other.nameObject == nameObject)&&(identical(other.message, message) || other.message == message)&&(identical(other.prefix, prefix) || other.prefix == prefix));
}


@override
int get hashCode => Object.hash(runtimeType,nameObject,message,prefix);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ValueFailure.strNotStartsWith(nameObject: $nameObject, message: $message, prefix: $prefix)';
}


}

/// @nodoc
abstract mixin class $StrNotStartsWithCopyWith<$Res> implements $ValueFailureCopyWith<$Res> {
  factory $StrNotStartsWithCopyWith(StrNotStartsWith value, $Res Function(StrNotStartsWith) _then) = _$StrNotStartsWithCopyWithImpl;
@override @useResult
$Res call({
 String nameObject, String message, String prefix
});




}
/// @nodoc
class _$StrNotStartsWithCopyWithImpl<$Res>
    implements $StrNotStartsWithCopyWith<$Res> {
  _$StrNotStartsWithCopyWithImpl(this._self, this._then);

  final StrNotStartsWith _self;
  final $Res Function(StrNotStartsWith) _then;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nameObject = null,Object? message = null,Object? prefix = null,}) {
  return _then(StrNotStartsWith(
nameObject: null == nameObject ? _self.nameObject : nameObject // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,prefix: null == prefix ? _self.prefix : prefix // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class NotANumber extends ValueFailure with DiagnosticableTreeMixin {
  const NotANumber({this.nameObject = '', this.message = '', this.failedValue}): super._();
  

/// string name of the object with failure
@override@JsonKey() final  String nameObject;
@override@JsonKey() final  String message;
 final  String? failedValue;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotANumberCopyWith<NotANumber> get copyWith => _$NotANumberCopyWithImpl<NotANumber>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ValueFailure.notANumber'))
    ..add(DiagnosticsProperty('nameObject', nameObject))..add(DiagnosticsProperty('message', message))..add(DiagnosticsProperty('failedValue', failedValue));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotANumber&&(identical(other.nameObject, nameObject) || other.nameObject == nameObject)&&(identical(other.message, message) || other.message == message)&&(identical(other.failedValue, failedValue) || other.failedValue == failedValue));
}


@override
int get hashCode => Object.hash(runtimeType,nameObject,message,failedValue);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ValueFailure.notANumber(nameObject: $nameObject, message: $message, failedValue: $failedValue)';
}


}

/// @nodoc
abstract mixin class $NotANumberCopyWith<$Res> implements $ValueFailureCopyWith<$Res> {
  factory $NotANumberCopyWith(NotANumber value, $Res Function(NotANumber) _then) = _$NotANumberCopyWithImpl;
@override @useResult
$Res call({
 String nameObject, String message, String? failedValue
});




}
/// @nodoc
class _$NotANumberCopyWithImpl<$Res>
    implements $NotANumberCopyWith<$Res> {
  _$NotANumberCopyWithImpl(this._self, this._then);

  final NotANumber _self;
  final $Res Function(NotANumber) _then;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nameObject = null,Object? message = null,Object? failedValue = freezed,}) {
  return _then(NotANumber(
nameObject: null == nameObject ? _self.nameObject : nameObject // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,failedValue: freezed == failedValue ? _self.failedValue : failedValue // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class NotAnInt extends ValueFailure with DiagnosticableTreeMixin {
  const NotAnInt({this.nameObject = '', this.message = '', this.failedValue}): super._();
  

/// string name of the object with failure
@override@JsonKey() final  String nameObject;
@override@JsonKey() final  String message;
 final  String? failedValue;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotAnIntCopyWith<NotAnInt> get copyWith => _$NotAnIntCopyWithImpl<NotAnInt>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ValueFailure.notAnInt'))
    ..add(DiagnosticsProperty('nameObject', nameObject))..add(DiagnosticsProperty('message', message))..add(DiagnosticsProperty('failedValue', failedValue));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotAnInt&&(identical(other.nameObject, nameObject) || other.nameObject == nameObject)&&(identical(other.message, message) || other.message == message)&&(identical(other.failedValue, failedValue) || other.failedValue == failedValue));
}


@override
int get hashCode => Object.hash(runtimeType,nameObject,message,failedValue);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ValueFailure.notAnInt(nameObject: $nameObject, message: $message, failedValue: $failedValue)';
}


}

/// @nodoc
abstract mixin class $NotAnIntCopyWith<$Res> implements $ValueFailureCopyWith<$Res> {
  factory $NotAnIntCopyWith(NotAnInt value, $Res Function(NotAnInt) _then) = _$NotAnIntCopyWithImpl;
@override @useResult
$Res call({
 String nameObject, String message, String? failedValue
});




}
/// @nodoc
class _$NotAnIntCopyWithImpl<$Res>
    implements $NotAnIntCopyWith<$Res> {
  _$NotAnIntCopyWithImpl(this._self, this._then);

  final NotAnInt _self;
  final $Res Function(NotAnInt) _then;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nameObject = null,Object? message = null,Object? failedValue = freezed,}) {
  return _then(NotAnInt(
nameObject: null == nameObject ? _self.nameObject : nameObject // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,failedValue: freezed == failedValue ? _self.failedValue : failedValue // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class NotADouble extends ValueFailure with DiagnosticableTreeMixin {
  const NotADouble({this.nameObject = '', this.message = '', this.failedValue}): super._();
  

/// string name of the object with failure
@override@JsonKey() final  String nameObject;
@override@JsonKey() final  String message;
 final  String? failedValue;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotADoubleCopyWith<NotADouble> get copyWith => _$NotADoubleCopyWithImpl<NotADouble>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ValueFailure.notADouble'))
    ..add(DiagnosticsProperty('nameObject', nameObject))..add(DiagnosticsProperty('message', message))..add(DiagnosticsProperty('failedValue', failedValue));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotADouble&&(identical(other.nameObject, nameObject) || other.nameObject == nameObject)&&(identical(other.message, message) || other.message == message)&&(identical(other.failedValue, failedValue) || other.failedValue == failedValue));
}


@override
int get hashCode => Object.hash(runtimeType,nameObject,message,failedValue);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ValueFailure.notADouble(nameObject: $nameObject, message: $message, failedValue: $failedValue)';
}


}

/// @nodoc
abstract mixin class $NotADoubleCopyWith<$Res> implements $ValueFailureCopyWith<$Res> {
  factory $NotADoubleCopyWith(NotADouble value, $Res Function(NotADouble) _then) = _$NotADoubleCopyWithImpl;
@override @useResult
$Res call({
 String nameObject, String message, String? failedValue
});




}
/// @nodoc
class _$NotADoubleCopyWithImpl<$Res>
    implements $NotADoubleCopyWith<$Res> {
  _$NotADoubleCopyWithImpl(this._self, this._then);

  final NotADouble _self;
  final $Res Function(NotADouble) _then;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nameObject = null,Object? message = null,Object? failedValue = freezed,}) {
  return _then(NotADouble(
nameObject: null == nameObject ? _self.nameObject : nameObject // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,failedValue: freezed == failedValue ? _self.failedValue : failedValue // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class NumOutRange extends ValueFailure with DiagnosticableTreeMixin {
  const NumOutRange({this.nameObject = '', this.message = '', this.failedValue, required this.min, required this.max}): super._();
  

/// string name of the object with failure
@override@JsonKey() final  String nameObject;
@override@JsonKey() final  String message;
 final  num? failedValue;
 final  num min;
 final  num max;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NumOutRangeCopyWith<NumOutRange> get copyWith => _$NumOutRangeCopyWithImpl<NumOutRange>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ValueFailure.numOutRange'))
    ..add(DiagnosticsProperty('nameObject', nameObject))..add(DiagnosticsProperty('message', message))..add(DiagnosticsProperty('failedValue', failedValue))..add(DiagnosticsProperty('min', min))..add(DiagnosticsProperty('max', max));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NumOutRange&&(identical(other.nameObject, nameObject) || other.nameObject == nameObject)&&(identical(other.message, message) || other.message == message)&&(identical(other.failedValue, failedValue) || other.failedValue == failedValue)&&(identical(other.min, min) || other.min == min)&&(identical(other.max, max) || other.max == max));
}


@override
int get hashCode => Object.hash(runtimeType,nameObject,message,failedValue,min,max);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ValueFailure.numOutRange(nameObject: $nameObject, message: $message, failedValue: $failedValue, min: $min, max: $max)';
}


}

/// @nodoc
abstract mixin class $NumOutRangeCopyWith<$Res> implements $ValueFailureCopyWith<$Res> {
  factory $NumOutRangeCopyWith(NumOutRange value, $Res Function(NumOutRange) _then) = _$NumOutRangeCopyWithImpl;
@override @useResult
$Res call({
 String nameObject, String message, num? failedValue, num min, num max
});




}
/// @nodoc
class _$NumOutRangeCopyWithImpl<$Res>
    implements $NumOutRangeCopyWith<$Res> {
  _$NumOutRangeCopyWithImpl(this._self, this._then);

  final NumOutRange _self;
  final $Res Function(NumOutRange) _then;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nameObject = null,Object? message = null,Object? failedValue = freezed,Object? min = null,Object? max = null,}) {
  return _then(NumOutRange(
nameObject: null == nameObject ? _self.nameObject : nameObject // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,failedValue: freezed == failedValue ? _self.failedValue : failedValue // ignore: cast_nullable_to_non_nullable
as num?,min: null == min ? _self.min : min // ignore: cast_nullable_to_non_nullable
as num,max: null == max ? _self.max : max // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}

/// @nodoc


class NumOutMax extends ValueFailure with DiagnosticableTreeMixin {
  const NumOutMax({this.nameObject = '', this.message = '', this.failedValue, required this.maxAllow}): super._();
  

/// string name of the object with failure
@override@JsonKey() final  String nameObject;
@override@JsonKey() final  String message;
 final  num? failedValue;
/// max value allow
 final  num maxAllow;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NumOutMaxCopyWith<NumOutMax> get copyWith => _$NumOutMaxCopyWithImpl<NumOutMax>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ValueFailure.numOutMax'))
    ..add(DiagnosticsProperty('nameObject', nameObject))..add(DiagnosticsProperty('message', message))..add(DiagnosticsProperty('failedValue', failedValue))..add(DiagnosticsProperty('maxAllow', maxAllow));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NumOutMax&&(identical(other.nameObject, nameObject) || other.nameObject == nameObject)&&(identical(other.message, message) || other.message == message)&&(identical(other.failedValue, failedValue) || other.failedValue == failedValue)&&(identical(other.maxAllow, maxAllow) || other.maxAllow == maxAllow));
}


@override
int get hashCode => Object.hash(runtimeType,nameObject,message,failedValue,maxAllow);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ValueFailure.numOutMax(nameObject: $nameObject, message: $message, failedValue: $failedValue, maxAllow: $maxAllow)';
}


}

/// @nodoc
abstract mixin class $NumOutMaxCopyWith<$Res> implements $ValueFailureCopyWith<$Res> {
  factory $NumOutMaxCopyWith(NumOutMax value, $Res Function(NumOutMax) _then) = _$NumOutMaxCopyWithImpl;
@override @useResult
$Res call({
 String nameObject, String message, num? failedValue, num maxAllow
});




}
/// @nodoc
class _$NumOutMaxCopyWithImpl<$Res>
    implements $NumOutMaxCopyWith<$Res> {
  _$NumOutMaxCopyWithImpl(this._self, this._then);

  final NumOutMax _self;
  final $Res Function(NumOutMax) _then;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nameObject = null,Object? message = null,Object? failedValue = freezed,Object? maxAllow = null,}) {
  return _then(NumOutMax(
nameObject: null == nameObject ? _self.nameObject : nameObject // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,failedValue: freezed == failedValue ? _self.failedValue : failedValue // ignore: cast_nullable_to_non_nullable
as num?,maxAllow: null == maxAllow ? _self.maxAllow : maxAllow // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}

/// @nodoc


class NumOutMin extends ValueFailure with DiagnosticableTreeMixin {
  const NumOutMin({this.nameObject = '', this.message = '', this.failedValue, required this.minAllow}): super._();
  

/// string name of the object with failure
@override@JsonKey() final  String nameObject;
@override@JsonKey() final  String message;
 final  num? failedValue;
/// min value allow
 final  num minAllow;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NumOutMinCopyWith<NumOutMin> get copyWith => _$NumOutMinCopyWithImpl<NumOutMin>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ValueFailure.numOutMin'))
    ..add(DiagnosticsProperty('nameObject', nameObject))..add(DiagnosticsProperty('message', message))..add(DiagnosticsProperty('failedValue', failedValue))..add(DiagnosticsProperty('minAllow', minAllow));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NumOutMin&&(identical(other.nameObject, nameObject) || other.nameObject == nameObject)&&(identical(other.message, message) || other.message == message)&&(identical(other.failedValue, failedValue) || other.failedValue == failedValue)&&(identical(other.minAllow, minAllow) || other.minAllow == minAllow));
}


@override
int get hashCode => Object.hash(runtimeType,nameObject,message,failedValue,minAllow);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ValueFailure.numOutMin(nameObject: $nameObject, message: $message, failedValue: $failedValue, minAllow: $minAllow)';
}


}

/// @nodoc
abstract mixin class $NumOutMinCopyWith<$Res> implements $ValueFailureCopyWith<$Res> {
  factory $NumOutMinCopyWith(NumOutMin value, $Res Function(NumOutMin) _then) = _$NumOutMinCopyWithImpl;
@override @useResult
$Res call({
 String nameObject, String message, num? failedValue, num minAllow
});




}
/// @nodoc
class _$NumOutMinCopyWithImpl<$Res>
    implements $NumOutMinCopyWith<$Res> {
  _$NumOutMinCopyWithImpl(this._self, this._then);

  final NumOutMin _self;
  final $Res Function(NumOutMin) _then;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nameObject = null,Object? message = null,Object? failedValue = freezed,Object? minAllow = null,}) {
  return _then(NumOutMin(
nameObject: null == nameObject ? _self.nameObject : nameObject // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,failedValue: freezed == failedValue ? _self.failedValue : failedValue // ignore: cast_nullable_to_non_nullable
as num?,minAllow: null == minAllow ? _self.minAllow : minAllow // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}

/// @nodoc


class NegativeValue extends ValueFailure with DiagnosticableTreeMixin {
  const NegativeValue({this.nameObject = '', this.message = '', this.failedValue}): super._();
  

/// string name of the object with failure
@override@JsonKey() final  String nameObject;
@override@JsonKey() final  String message;
 final  num? failedValue;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NegativeValueCopyWith<NegativeValue> get copyWith => _$NegativeValueCopyWithImpl<NegativeValue>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ValueFailure.negativeValue'))
    ..add(DiagnosticsProperty('nameObject', nameObject))..add(DiagnosticsProperty('message', message))..add(DiagnosticsProperty('failedValue', failedValue));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NegativeValue&&(identical(other.nameObject, nameObject) || other.nameObject == nameObject)&&(identical(other.message, message) || other.message == message)&&(identical(other.failedValue, failedValue) || other.failedValue == failedValue));
}


@override
int get hashCode => Object.hash(runtimeType,nameObject,message,failedValue);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ValueFailure.negativeValue(nameObject: $nameObject, message: $message, failedValue: $failedValue)';
}


}

/// @nodoc
abstract mixin class $NegativeValueCopyWith<$Res> implements $ValueFailureCopyWith<$Res> {
  factory $NegativeValueCopyWith(NegativeValue value, $Res Function(NegativeValue) _then) = _$NegativeValueCopyWithImpl;
@override @useResult
$Res call({
 String nameObject, String message, num? failedValue
});




}
/// @nodoc
class _$NegativeValueCopyWithImpl<$Res>
    implements $NegativeValueCopyWith<$Res> {
  _$NegativeValueCopyWithImpl(this._self, this._then);

  final NegativeValue _self;
  final $Res Function(NegativeValue) _then;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nameObject = null,Object? message = null,Object? failedValue = freezed,}) {
  return _then(NegativeValue(
nameObject: null == nameObject ? _self.nameObject : nameObject // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,failedValue: freezed == failedValue ? _self.failedValue : failedValue // ignore: cast_nullable_to_non_nullable
as num?,
  ));
}


}

/// @nodoc


class ValueExceedsLimit extends ValueFailure with DiagnosticableTreeMixin {
  const ValueExceedsLimit({this.nameObject = '', this.message = '', this.failedValue, required this.limit}): super._();
  

/// string name of the object with failure
@override@JsonKey() final  String nameObject;
@override@JsonKey() final  String message;
 final  num? failedValue;
 final  num limit;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ValueExceedsLimitCopyWith<ValueExceedsLimit> get copyWith => _$ValueExceedsLimitCopyWithImpl<ValueExceedsLimit>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ValueFailure.valueExceedsLimit'))
    ..add(DiagnosticsProperty('nameObject', nameObject))..add(DiagnosticsProperty('message', message))..add(DiagnosticsProperty('failedValue', failedValue))..add(DiagnosticsProperty('limit', limit));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ValueExceedsLimit&&(identical(other.nameObject, nameObject) || other.nameObject == nameObject)&&(identical(other.message, message) || other.message == message)&&(identical(other.failedValue, failedValue) || other.failedValue == failedValue)&&(identical(other.limit, limit) || other.limit == limit));
}


@override
int get hashCode => Object.hash(runtimeType,nameObject,message,failedValue,limit);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ValueFailure.valueExceedsLimit(nameObject: $nameObject, message: $message, failedValue: $failedValue, limit: $limit)';
}


}

/// @nodoc
abstract mixin class $ValueExceedsLimitCopyWith<$Res> implements $ValueFailureCopyWith<$Res> {
  factory $ValueExceedsLimitCopyWith(ValueExceedsLimit value, $Res Function(ValueExceedsLimit) _then) = _$ValueExceedsLimitCopyWithImpl;
@override @useResult
$Res call({
 String nameObject, String message, num? failedValue, num limit
});




}
/// @nodoc
class _$ValueExceedsLimitCopyWithImpl<$Res>
    implements $ValueExceedsLimitCopyWith<$Res> {
  _$ValueExceedsLimitCopyWithImpl(this._self, this._then);

  final ValueExceedsLimit _self;
  final $Res Function(ValueExceedsLimit) _then;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nameObject = null,Object? message = null,Object? failedValue = freezed,Object? limit = null,}) {
  return _then(ValueExceedsLimit(
nameObject: null == nameObject ? _self.nameObject : nameObject // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,failedValue: freezed == failedValue ? _self.failedValue : failedValue // ignore: cast_nullable_to_non_nullable
as num?,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}

/// @nodoc


class DateOutRange extends ValueFailure with DiagnosticableTreeMixin {
  const DateOutRange({this.nameObject = '', this.message = '', required this.min, required this.max}): super._();
  

/// string name of the object with failure
@override@JsonKey() final  String nameObject;
@override@JsonKey() final  String message;
 final  DateTime min;
 final  DateTime max;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DateOutRangeCopyWith<DateOutRange> get copyWith => _$DateOutRangeCopyWithImpl<DateOutRange>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ValueFailure.dateOutRange'))
    ..add(DiagnosticsProperty('nameObject', nameObject))..add(DiagnosticsProperty('message', message))..add(DiagnosticsProperty('min', min))..add(DiagnosticsProperty('max', max));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DateOutRange&&(identical(other.nameObject, nameObject) || other.nameObject == nameObject)&&(identical(other.message, message) || other.message == message)&&(identical(other.min, min) || other.min == min)&&(identical(other.max, max) || other.max == max));
}


@override
int get hashCode => Object.hash(runtimeType,nameObject,message,min,max);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ValueFailure.dateOutRange(nameObject: $nameObject, message: $message, min: $min, max: $max)';
}


}

/// @nodoc
abstract mixin class $DateOutRangeCopyWith<$Res> implements $ValueFailureCopyWith<$Res> {
  factory $DateOutRangeCopyWith(DateOutRange value, $Res Function(DateOutRange) _then) = _$DateOutRangeCopyWithImpl;
@override @useResult
$Res call({
 String nameObject, String message, DateTime min, DateTime max
});




}
/// @nodoc
class _$DateOutRangeCopyWithImpl<$Res>
    implements $DateOutRangeCopyWith<$Res> {
  _$DateOutRangeCopyWithImpl(this._self, this._then);

  final DateOutRange _self;
  final $Res Function(DateOutRange) _then;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nameObject = null,Object? message = null,Object? min = null,Object? max = null,}) {
  return _then(DateOutRange(
nameObject: null == nameObject ? _self.nameObject : nameObject // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,min: null == min ? _self.min : min // ignore: cast_nullable_to_non_nullable
as DateTime,max: null == max ? _self.max : max // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc


class FutureDateNotAllowed extends ValueFailure with DiagnosticableTreeMixin {
  const FutureDateNotAllowed({this.nameObject = '', this.message = '', this.failedValue}): super._();
  

/// string name of the object with failure
@override@JsonKey() final  String nameObject;
@override@JsonKey() final  String message;
 final  DateTime? failedValue;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FutureDateNotAllowedCopyWith<FutureDateNotAllowed> get copyWith => _$FutureDateNotAllowedCopyWithImpl<FutureDateNotAllowed>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ValueFailure.futureDateNotAllowed'))
    ..add(DiagnosticsProperty('nameObject', nameObject))..add(DiagnosticsProperty('message', message))..add(DiagnosticsProperty('failedValue', failedValue));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FutureDateNotAllowed&&(identical(other.nameObject, nameObject) || other.nameObject == nameObject)&&(identical(other.message, message) || other.message == message)&&(identical(other.failedValue, failedValue) || other.failedValue == failedValue));
}


@override
int get hashCode => Object.hash(runtimeType,nameObject,message,failedValue);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ValueFailure.futureDateNotAllowed(nameObject: $nameObject, message: $message, failedValue: $failedValue)';
}


}

/// @nodoc
abstract mixin class $FutureDateNotAllowedCopyWith<$Res> implements $ValueFailureCopyWith<$Res> {
  factory $FutureDateNotAllowedCopyWith(FutureDateNotAllowed value, $Res Function(FutureDateNotAllowed) _then) = _$FutureDateNotAllowedCopyWithImpl;
@override @useResult
$Res call({
 String nameObject, String message, DateTime? failedValue
});




}
/// @nodoc
class _$FutureDateNotAllowedCopyWithImpl<$Res>
    implements $FutureDateNotAllowedCopyWith<$Res> {
  _$FutureDateNotAllowedCopyWithImpl(this._self, this._then);

  final FutureDateNotAllowed _self;
  final $Res Function(FutureDateNotAllowed) _then;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nameObject = null,Object? message = null,Object? failedValue = freezed,}) {
  return _then(FutureDateNotAllowed(
nameObject: null == nameObject ? _self.nameObject : nameObject // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,failedValue: freezed == failedValue ? _self.failedValue : failedValue // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class DateTooOld extends ValueFailure with DiagnosticableTreeMixin {
  const DateTooOld({this.nameObject = '', this.message = '', this.failedValue, required this.maxAge}): super._();
  

/// string name of the object with failure
@override@JsonKey() final  String nameObject;
@override@JsonKey() final  String message;
 final  DateTime? failedValue;
 final  Duration maxAge;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DateTooOldCopyWith<DateTooOld> get copyWith => _$DateTooOldCopyWithImpl<DateTooOld>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ValueFailure.dateTooOld'))
    ..add(DiagnosticsProperty('nameObject', nameObject))..add(DiagnosticsProperty('message', message))..add(DiagnosticsProperty('failedValue', failedValue))..add(DiagnosticsProperty('maxAge', maxAge));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DateTooOld&&(identical(other.nameObject, nameObject) || other.nameObject == nameObject)&&(identical(other.message, message) || other.message == message)&&(identical(other.failedValue, failedValue) || other.failedValue == failedValue)&&(identical(other.maxAge, maxAge) || other.maxAge == maxAge));
}


@override
int get hashCode => Object.hash(runtimeType,nameObject,message,failedValue,maxAge);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ValueFailure.dateTooOld(nameObject: $nameObject, message: $message, failedValue: $failedValue, maxAge: $maxAge)';
}


}

/// @nodoc
abstract mixin class $DateTooOldCopyWith<$Res> implements $ValueFailureCopyWith<$Res> {
  factory $DateTooOldCopyWith(DateTooOld value, $Res Function(DateTooOld) _then) = _$DateTooOldCopyWithImpl;
@override @useResult
$Res call({
 String nameObject, String message, DateTime? failedValue, Duration maxAge
});




}
/// @nodoc
class _$DateTooOldCopyWithImpl<$Res>
    implements $DateTooOldCopyWith<$Res> {
  _$DateTooOldCopyWithImpl(this._self, this._then);

  final DateTooOld _self;
  final $Res Function(DateTooOld) _then;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nameObject = null,Object? message = null,Object? failedValue = freezed,Object? maxAge = null,}) {
  return _then(DateTooOld(
nameObject: null == nameObject ? _self.nameObject : nameObject // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,failedValue: freezed == failedValue ? _self.failedValue : failedValue // ignore: cast_nullable_to_non_nullable
as DateTime?,maxAge: null == maxAge ? _self.maxAge : maxAge // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}


}

/// @nodoc


class ItemEmpty extends ValueFailure with DiagnosticableTreeMixin {
  const ItemEmpty({this.nameObject = '', this.message = ''}): super._();
  

/// string name of the object with failure
@override@JsonKey() final  String nameObject;
@override@JsonKey() final  String message;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ItemEmptyCopyWith<ItemEmpty> get copyWith => _$ItemEmptyCopyWithImpl<ItemEmpty>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ValueFailure.collEmpty'))
    ..add(DiagnosticsProperty('nameObject', nameObject))..add(DiagnosticsProperty('message', message));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ItemEmpty&&(identical(other.nameObject, nameObject) || other.nameObject == nameObject)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,nameObject,message);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ValueFailure.collEmpty(nameObject: $nameObject, message: $message)';
}


}

/// @nodoc
abstract mixin class $ItemEmptyCopyWith<$Res> implements $ValueFailureCopyWith<$Res> {
  factory $ItemEmptyCopyWith(ItemEmpty value, $Res Function(ItemEmpty) _then) = _$ItemEmptyCopyWithImpl;
@override @useResult
$Res call({
 String nameObject, String message
});




}
/// @nodoc
class _$ItemEmptyCopyWithImpl<$Res>
    implements $ItemEmptyCopyWith<$Res> {
  _$ItemEmptyCopyWithImpl(this._self, this._then);

  final ItemEmpty _self;
  final $Res Function(ItemEmpty) _then;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nameObject = null,Object? message = null,}) {
  return _then(ItemEmpty(
nameObject: null == nameObject ? _self.nameObject : nameObject // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ItemRepeats extends ValueFailure with DiagnosticableTreeMixin {
  const ItemRepeats({this.nameObject = '', this.message = ''}): super._();
  

/// string name of the object with failure
@override@JsonKey() final  String nameObject;
@override@JsonKey() final  String message;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ItemRepeatsCopyWith<ItemRepeats> get copyWith => _$ItemRepeatsCopyWithImpl<ItemRepeats>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ValueFailure.collRepeatItems'))
    ..add(DiagnosticsProperty('nameObject', nameObject))..add(DiagnosticsProperty('message', message));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ItemRepeats&&(identical(other.nameObject, nameObject) || other.nameObject == nameObject)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,nameObject,message);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ValueFailure.collRepeatItems(nameObject: $nameObject, message: $message)';
}


}

/// @nodoc
abstract mixin class $ItemRepeatsCopyWith<$Res> implements $ValueFailureCopyWith<$Res> {
  factory $ItemRepeatsCopyWith(ItemRepeats value, $Res Function(ItemRepeats) _then) = _$ItemRepeatsCopyWithImpl;
@override @useResult
$Res call({
 String nameObject, String message
});




}
/// @nodoc
class _$ItemRepeatsCopyWithImpl<$Res>
    implements $ItemRepeatsCopyWith<$Res> {
  _$ItemRepeatsCopyWithImpl(this._self, this._then);

  final ItemRepeats _self;
  final $Res Function(ItemRepeats) _then;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nameObject = null,Object? message = null,}) {
  return _then(ItemRepeats(
nameObject: null == nameObject ? _self.nameObject : nameObject // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CollNotContains extends ValueFailure with DiagnosticableTreeMixin {
  const CollNotContains({this.nameObject = '', this.message = '', this.nameItem = ''}): super._();
  

/// string name of the object with failure
@override@JsonKey() final  String nameObject;
@override@JsonKey() final  String message;
@JsonKey() final  String nameItem;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollNotContainsCopyWith<CollNotContains> get copyWith => _$CollNotContainsCopyWithImpl<CollNotContains>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ValueFailure.collNotContains'))
    ..add(DiagnosticsProperty('nameObject', nameObject))..add(DiagnosticsProperty('message', message))..add(DiagnosticsProperty('nameItem', nameItem));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CollNotContains&&(identical(other.nameObject, nameObject) || other.nameObject == nameObject)&&(identical(other.message, message) || other.message == message)&&(identical(other.nameItem, nameItem) || other.nameItem == nameItem));
}


@override
int get hashCode => Object.hash(runtimeType,nameObject,message,nameItem);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ValueFailure.collNotContains(nameObject: $nameObject, message: $message, nameItem: $nameItem)';
}


}

/// @nodoc
abstract mixin class $CollNotContainsCopyWith<$Res> implements $ValueFailureCopyWith<$Res> {
  factory $CollNotContainsCopyWith(CollNotContains value, $Res Function(CollNotContains) _then) = _$CollNotContainsCopyWithImpl;
@override @useResult
$Res call({
 String nameObject, String message, String nameItem
});




}
/// @nodoc
class _$CollNotContainsCopyWithImpl<$Res>
    implements $CollNotContainsCopyWith<$Res> {
  _$CollNotContainsCopyWithImpl(this._self, this._then);

  final CollNotContains _self;
  final $Res Function(CollNotContains) _then;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nameObject = null,Object? message = null,Object? nameItem = null,}) {
  return _then(CollNotContains(
nameObject: null == nameObject ? _self.nameObject : nameObject // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,nameItem: null == nameItem ? _self.nameItem : nameItem // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class InsufficientStock extends ValueFailure with DiagnosticableTreeMixin {
  const InsufficientStock({this.nameObject = '', this.message = '', required this.available, required this.requested}): super._();
  

@override@JsonKey() final  String nameObject;
@override@JsonKey() final  String message;
 final  int available;
 final  double requested;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InsufficientStockCopyWith<InsufficientStock> get copyWith => _$InsufficientStockCopyWithImpl<InsufficientStock>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ValueFailure.insufficientStock'))
    ..add(DiagnosticsProperty('nameObject', nameObject))..add(DiagnosticsProperty('message', message))..add(DiagnosticsProperty('available', available))..add(DiagnosticsProperty('requested', requested));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InsufficientStock&&(identical(other.nameObject, nameObject) || other.nameObject == nameObject)&&(identical(other.message, message) || other.message == message)&&(identical(other.available, available) || other.available == available)&&(identical(other.requested, requested) || other.requested == requested));
}


@override
int get hashCode => Object.hash(runtimeType,nameObject,message,available,requested);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ValueFailure.insufficientStock(nameObject: $nameObject, message: $message, available: $available, requested: $requested)';
}


}

/// @nodoc
abstract mixin class $InsufficientStockCopyWith<$Res> implements $ValueFailureCopyWith<$Res> {
  factory $InsufficientStockCopyWith(InsufficientStock value, $Res Function(InsufficientStock) _then) = _$InsufficientStockCopyWithImpl;
@override @useResult
$Res call({
 String nameObject, String message, int available, double requested
});




}
/// @nodoc
class _$InsufficientStockCopyWithImpl<$Res>
    implements $InsufficientStockCopyWith<$Res> {
  _$InsufficientStockCopyWithImpl(this._self, this._then);

  final InsufficientStock _self;
  final $Res Function(InsufficientStock) _then;

/// Create a copy of ValueFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nameObject = null,Object? message = null,Object? available = null,Object? requested = null,}) {
  return _then(InsufficientStock(
nameObject: null == nameObject ? _self.nameObject : nameObject // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as int,requested: null == requested ? _self.requested : requested // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
