import 'package:dartz/dartz.dart';
import 'package:study_forge_ai/src/core/error/failures.dart';

import '../repository/respository_interface.dart';
import '../auth_entity/entity.dart';

class SignupUsecase {
  final AuthRepositoryInterface repository;
  SignupUsecase(this.repository);
  Future<Either<Failures, UserEntity>> call(SignupParams params) async {
    return await repository.signUp(
      email: params.email,
      password: params.password,
      name: params.name,
    );
  }
}

class SignupParams {
  final String email;
  final String password;
  final String name;

  SignupParams({
    required this.email,
    required this.password,
    required this.name,
  });
}
