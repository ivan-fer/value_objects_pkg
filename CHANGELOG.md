## 1.2.0

* Unified the `customValidate` hook across **all** value objects (previously only available on a few numeric types). Every value object now accepts an optional `customValidate` parameter to inject a business rule on top of the built-in validation.
* Centralized the validation contract in `ValueObject<T>`: it now exposes a `customValidate` getter and a concrete `validate()` (`customValidate?.call(value) ?? value.failureMessage`); subclasses no longer reimplement `validate()`.
* Replaced the unused, mis-typed `CustomValidate` typedef with a class-parameterized `typedef CustomValidate<T> = String? Function(Either<ValueFailure, T> value);`.
* Added cross-module tests for the hook in `test/core/custom_validate_test.dart`.

This is a non-breaking change: the public `customValidate` parameter name and signature used by the existing numeric value objects are preserved.

## 1.1.0

* Added collection length value objects: `ValueListMinLength`, `ValueListMaxLength` and `ValueListLengthRange`, backed by new `ValueFailure.collTooFew` / `ValueFailure.collTooMany` failures.
* Added optional unique-list value objects for symmetry: `ValueOptionUniqueList` and `ValueOptionUniqueListNotEmpty`.
* Added the top-level `validateCollectionNotContains`, `validateCollectionMinLength` and `validateCollectionMaxLength` functions; `ValueListNotContains` now reuses `validateCollectionNotContains` instead of inverting `validateCollectionContains` inline.
* Added explicit, user-facing error messages for all collection failures.
* Expanded test coverage for collections (`ValueListContains`, `ValueListNotContains`, length and optional-unique value objects).

## 1.0.1

* Converted to a pure-Dart package: removed the unused Flutter dependency, switched `flutter_test` to `test` and `flutter_lints` to `lints`. The package now works in any Dart project (server, CLI, backend) as well as Flutter.
* Lowered the minimum Dart SDK constraint from `^3.11.3` to `^3.6.0` for broader compatibility.
* Fixed `ValueOptionListNotEmpty`: it previously ignored its input and was always valid as `none`. It now correctly validates (null → none, non-empty list → valid, empty list → failure).
* Added test coverage for `ValueOptionListNotEmpty`.

## 1.0.0

* Initial release.
* Added Text, Identity, Numbers, Finance, Property, Measures, Geo and Collections value objects.
* Implemented completely functional architecture using fpdart (Either, Option).
* Added comprehensive validation top-level functions.
