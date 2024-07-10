import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../error/failures.dart';

/// The base class for all use cases in the application.
///
/// A use case represents a specific action or task that the application
/// can perform. It encapsulates the business logic and interactions
/// required to complete that task. All use cases should extend this class.
abstract class UseCase<Type, Params> {
  /// Executes the use case with the given parameters.
  ///
  /// This method should be implemented by concrete use cases to define
  /// the specific logic for the use case. It takes the input parameters
  /// [Params] and returns a [Future] that resolves to an [Either] containing
  /// either a [Failure] or the resulting [Type].
  Future<Either<Failure, Type>> call(Params params);
}

/// A class representing no parameters for use cases that do not require input.
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
