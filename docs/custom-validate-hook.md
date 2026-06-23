# Proposal: unify the `customValidate` hook across all value objects

Status: **implemented** in `1.2.0` (2026-06-23).
Scope: package-wide (cross-cutting), follow-up to the `1.1.0` collections work.

> Implementation note: the rollout was centralized rather than copied per class.
> `ValueObject<T>` now declares `CustomValidate<T>? get customValidate => null`
> and a concrete `validate() => customValidate?.call(value) ?? value.failureMessage`.
> Subclasses simply override the getter (with a final field) and forward a
> `customValidate` named parameter through their factories, so no value object
> reimplements `validate()` anymore.

## Summary

`value_objects_pkg` lets a value object carry a user-supplied validation
function (`customValidate`) so callers can attach a **business rule** on top of
the built-in structural validation. Today this hook is implemented in **only one
module** (`numbers`). This document describes what the hook is, why it should be
available on every value object, and a concrete plan to roll it out.

## Current state

- The hook exists only in `lib/src/numbers/value_numbers.dart`
  (`ValueNumber`, `ValueOptionNumber`).
- `lib/src/core/value_object.dart` declares a `CustomValidate` typedef that is
  **never used**, and whose generic signature
  (`String? Function<T>(Either<ValueFailure, T>)?`) does **not** match the
  concrete signature the implementations actually use
  (`String? Function(Either<ValueFailure, num>)?`).
- Every other module (text, identity, finance, property, measures, geo,
  collections) has **no** way to inject a custom rule.

### How it works today (the pattern to generalize)

```dart
class ValueNumber extends ValueNumeric<num> {
  final String? Function(Either<ValueFailure, num>)? fnValidate;

  factory ValueNumber(
    String input, {
    num? min,
    num? max,
    String? Function(Either<ValueFailure, num>)? customValidate,
  }) {
    final result = /* ...structural validation... */;
    return ValueNumber._(result, fnValidate: customValidate);
  }

  const ValueNumber._(super.value, {this.fnValidate});

  @override
  String? validate() => fnValidate?.call(value) ?? super.validate();
}
```

The value object stores the function and, in `validate()`, runs it first; if it
returns `null` (valid) it falls through to the default validation via
`super.validate()`.

## Why this should be done

1. **API consistency.** A user who learns the hook on `ValueNumber` reasonably
   expects the same on `ValueEmailAddress`, `ValueListNotEmpty`, etc. Today it
   silently works only for numbers — an inconsistent, surprising API surface.
2. **Extensibility without inheritance.** Without the hook, adding a one-off
   rule (e.g. "this list must not contain banned items", "this email domain
   must be corporate") forces a new subclass or a brand-new value object. With
   the hook, the rule is injected at the call site.
3. **Dead / broken code.** The unused `CustomValidate` typedef should either be
   fixed and adopted, or removed. Leaving a misleading, non-matching typedef in
   core is a maintenance trap.
4. **Single source of truth for the contract.** A shared typedef + a uniform
   constructor parameter name documents the hook once, instead of re-declaring
   the function signature in every class.

## Design considerations

- **Naming.** The public constructor parameter is `customValidate`, but the
  stored field is `fnValidate`. Pick one convention and apply it everywhere
  (recommended: keep `customValidate` as the public name; the private field name
  is an internal detail but should be consistent too).
- **The typedef.** The current generic `Function<T>(...)` form is the problem —
  a value object validates a *concrete* `T`, not a generic one. Prefer a
  generic typedef parameterized at the class level:

  ```dart
  typedef CustomValidate<T> = String? Function(Either<ValueFailure, T> value);
  ```

  Then `ValueNumber` uses `CustomValidate<num>?`, `ValueEmailAddress` uses
  `CustomValidate<String>?`, `ValueListNotEmpty<T>` uses
  `CustomValidate<List<T>>?`, and optional value objects use
  `CustomValidate<Option<...>>?`.
- **Optional value objects.** For `ValueOption*` types the hook receives
  `Either<ValueFailure, Option<...>>`, matching the existing `ValueOptionNumber`
  behavior. Keep that so a caller can decide how to treat `none`.
- **Order of evaluation.** Preserve "custom first, then default"
  (`fnValidate?.call(value) ?? super.validate()`) so a custom message can
  override or supplement the built-in one. Document this precedence explicitly.
- **Backward compatibility.** Adding an optional named parameter and an
  overridden `validate()` is non-breaking. Replacing the broken typedef is
  technically a breaking change *only if* someone references it — given it is
  unused, the risk is effectively zero. Still, bump the minor version.

## Proposed rollout

1. Replace the typedef in `core/value_object.dart` with the class-parameterized
   `CustomValidate<T>` shown above (or remove it and inline, but a shared
   typedef is preferred for documentation).
2. Migrate `ValueNumber` / `ValueOptionNumber` to use `CustomValidate<T>` (no
   behavior change, just adopting the shared type).
3. Add `customValidate` to the remaining modules, one module per commit:
   text → identity → finance → property → measures → geo → collections.
   For each value object: add the optional named parameter, store it, and
   override `validate()` with the standard `fnValidate?.call(value) ?? super.validate()`.
4. Add tests per module: (a) a custom rule that fails a structurally-valid value,
   (b) a custom rule returning `null` that lets a valid value pass,
   (c) confirm the built-in failure still wins when there is no custom rule.
5. Update `README.md` with a short "Custom validation" section and bump the
   version (minor).

## Example (target behavior, collections)

```dart
final tags = ValueListNotEmpty<String>(
  inputTags,
  customValidate: (either) => either.fold(
    (failure) => null, // let the structural failure speak
    (list) => list.contains('banned') ? 'Tag "banned" is not allowed' : null,
  ),
);

tags.validate(); // runs the custom rule first, then the built-in one
```

## Decision needed

- Confirm the public parameter name (`customValidate`) and the typedef shape.
- Confirm rollout order and whether to do it as one PR or one-per-module.
