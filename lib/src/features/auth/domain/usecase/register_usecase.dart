import 'package:dartz/dartz.dart';
import 'package:study_forge_ai/src/core/error/failures.dart';
import 'package:study_forge_ai/src/features/auth/domain/auth_entity/entity.dart';
import 'package:study_forge_ai/src/features/auth/domain/repository/respository_interface.dart';

class RegisterUsecase {
  final AuthRepositoryInterface repository;

  RegisterUsecase(this.repository);

  Future<Either<Failures, UserEntity>> call(String userId) async {
    return await repository.register(userId);
  }
}
