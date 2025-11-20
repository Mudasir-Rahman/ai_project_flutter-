import 'package:dartz/dartz.dart';
import 'package:study_forge_ai/src/core/error/failures.dart';
import 'package:study_forge_ai/src/core/useCase/use_case.dart' show UseCase;
import 'package:study_forge_ai/src/features/auth/domain/auth_entity/entity.dart';
import 'package:study_forge_ai/src/features/auth/domain/repository/respository_interface.dart';

class UserLoginUsecase implements UseCase<UserEntity, UserLoginParams> {
  final AuthRepositoryInterface repository;
  UserLoginUsecase(this.repository);
  @override
  Future<Either<Failures, UserEntity>> call(UserLoginParams params) async {
    return await repository.login(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({required this.email, required this.password});
}
