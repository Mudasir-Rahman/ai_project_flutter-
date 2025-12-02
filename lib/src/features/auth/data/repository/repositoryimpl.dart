import 'package:dartz/dartz.dart';
import 'package:study_forge_ai/src/core/error/failures.dart';
import 'package:study_forge_ai/src/features/auth/data/datasources/remote_data_source.dart';
import 'package:study_forge_ai/src/features/auth/domain/auth_entity/entity.dart';
import '../../domain/repository/respository_interface.dart';
import '../../domain/usecase/signup_usecase.dart';
import '../../domain/usecase/user_login_usecase.dart';

class RepositoryImpl implements AuthRepositoryInterface {
  final RemoteDataSource remoteDataSource;

  RepositoryImpl(this.remoteDataSource);

  // ========== SIGNUP ==========
  @override
  Future<Either<Failures, UserEntity>> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final user = await remoteDataSource.signUpWithEmail(
        SignupParams(email: email, password: password, name: name),
      );

      return Right(UserEntity(
        id: user.id,
        email: user.email,
        name: user.name,
      ));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ========== LOGIN ==========
  @override
  Future<Either<Failures, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.signInWithEmail(
        UserLoginParams(email: email, password: password),
      );

      return Right(UserEntity(
        id: user.id,
        email: user.email,
        name: user.name,
      ));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ========== CURRENT USER / SESSION ==========
  @override
  Future<Either<Failures, UserEntity?>> getCurrentUser() async {
    try {
      final session = remoteDataSource.getSession();

      if (session == null || session.user == null) {
        return const Right(null);
      }

      final user = await remoteDataSource.getCurrentUser();
      if (user == null) return const Right(null);

      return Right(UserEntity(
        id: user.id,
        email: user.email,
        name: user.name,
      ));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ========== REGISTER ==========
  @override
  Future<Either<Failures, UserEntity>> register(String userId) async {
    try {
      final ok = await remoteDataSource.register(userId);
      if (!ok) {
        return Left(ServerFailure("User not found"));
      }

      return Right(UserEntity(id: userId, email: "", name: ""));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ========== SIGN OUT ==========
  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }

  // ========== GOOGLE LOGIN ==========
  @override
  Future<Either<Failures, UserEntity>> googleLogin() async {
    try {
      final user = await remoteDataSource.googleLogin();
      if (user == null) {
        return Left(ServerFailure("Google login failed"));
      }

      return Right(UserEntity(
        id: user.id,
        email: user.email,
        name: user.name,
      ));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
