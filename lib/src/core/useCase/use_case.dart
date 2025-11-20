import 'package:dartz/dartz.dart';
import 'package:study_forge_ai/src/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failures, Type>> call(Params params);
}

class NoParams {}
