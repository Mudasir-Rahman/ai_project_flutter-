import 'package:dartz/dartz.dart';

import 'package:study_forge_ai/src/features/auth/domain/repository/respository_interface.dart';

import '../../../../core/error/failures.dart';
import '../auth_entity/entity.dart';
class GoogleLoginUseCase {
  final AuthRepositoryInterface repository;

  GoogleLoginUseCase(this.repository);
Future<Either<Failures, UserEntity>> call() async {
  return await repository.googleLogin();
}
}


