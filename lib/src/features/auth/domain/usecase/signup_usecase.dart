import 'package:dartz/dartz.dart';
import 'package:study_forge_ai/src/core/error/failures.dart';

import '../repository/respository_interface.dart';
import '../auth_entity/entity.dart';

class SignupUseCase {
  final AuthRepository repository;
  SignupUseCase(this.repository);
  Future<Either<Failures, UserEntity>> call(SignupParams params) async {
    return await repository.signup(
      email: params.email,
      password: params.password,
      fullName: params.fullName,
    );
  }
}

class SignupParams {
  final String email;
  final String password;
  final String fullName;

  SignupParams({
    required this.email,
    required this.password,
    required this.fullName,
  });
}
