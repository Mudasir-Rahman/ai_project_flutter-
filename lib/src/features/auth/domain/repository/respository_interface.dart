import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:study_forge_ai/src/core/error/failures.dart';

import '../auth_entity/entity.dart';

abstract class AuthRepositoryInterface {
  Future<Either<Failures, UserEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failures, UserEntity>> signUp({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<Failures, UserEntity?>> getCurrentUser();

  Future<void> signOut();
  Future<Either<Failures, UserEntity>> register(String userId);
 Future<Either<Failures, UserEntity>> googleLogin();
 Future<bool>hasActiveSession();

}
