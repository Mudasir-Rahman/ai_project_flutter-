import 'package:dartz/dartz.dart';
import 'package:study_forge_ai/src/core/error/failures.dart';
import 'package:study_forge_ai/src/features/auth/domain/auth_entity/entity.dart';
import 'package:study_forge_ai/src/features/auth/domain/repository/respository_interface.dart';

class GetCurrentuser {
  final AuthRepositoryInterface repository;
  GetCurrentuser(this.repository);
  Future<Either<Failures, UserEntity?>> call() async {
    return await repository.getCurrentUser();
  }
}
