import 'package:fpdart/fpdart.dart';

/// Test-only helpers to unwrap [Either] without fold. Use in tests when you
/// expect a specific side and want a direct value.
extension EitherTestX<L, R> on Either<L, R> {
  /// Returns the [Left] value, or throws if this is [Right].
  L getLeftOrThrow() =>
      fold((l) => l, (r) => throw StateError('Expected Left, got Right: $r'));

  /// Returns the [Right] value, or throws if this is [Left].
  R getRightOrThrow() =>
      fold((l) => throw StateError('Expected Right, got Left: $l'), (r) => r);
}
