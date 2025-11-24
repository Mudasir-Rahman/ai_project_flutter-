import 'package:dartz/dartz.dart';
import 'package:study_forge_ai/src/core/error/failures.dart';
import 'package:study_forge_ai/src/features/auth/data/datasources/remote_data_source.dart';
import 'package:study_forge_ai/src/features/auth/domain/auth_entity/entity.dart';
import 'package:study_forge_ai/src/features/auth/domain/repository/respository_interface.dart';
import '../../domain/usecase/signup_usecase.dart';
import '../../domain/usecase/user_login_usecase.dart';

class RepositoryImpl implements AuthRepositoryInterface {
  final RemoteDataSource remoteDataSource;
  RepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failures, UserEntity>> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final userModel = await remoteDataSource.signUpWithEmail(
        SignupParams(email: email, password: password, name: name),
      );

      if (userModel == null) {
        return Left(ServerFailure('Signup returned null user'));
      }

      return Right(
        UserEntity(
          id: userModel.id,
          email: userModel.email,
          name: userModel.name ?? '',
        ),
      );
    } catch (e, st) {
      print('signUp Error: $e');
      print(st);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.signInWithEmail(
        UserLoginParams(email: email, password: password),
      );

      if (user == null) {
        return Left(ServerFailure('Login returned null user'));
      }

      return Right(
        UserEntity(
          id: user.id,
          email: user.email,
          name: user.name ?? '',
        ),
      );
    } catch (e, st) {
      print('login Error: $e');
      print(st);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, UserEntity?>> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUser();
      if (user == null) return const Right(null);

      return Right(
        UserEntity(
          id: user.id,
          email: user.email,
          name: user.name ?? '',
        ),
      );
    } catch (e, st) {
      print('getCurrentUser Error: $e');
      print(st);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, UserEntity>> register(String userId) async {
    try {
      final found = await remoteDataSource.register(userId);

      if (!found) {
        return Left(ServerFailure('User not found during register'));
      }

      return Right(
        UserEntity(id: userId, email: '', name: ''),
      );
    } catch (e, st) {
      print('register Error: $e');
      print(st);
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await remoteDataSource.signOut();
    } catch (e, st) {
      print('signOut Error: $e');
      print(st);
      throw e;
    }
  }

  // =================== GOOGLE LOGIN ===================
  @override
  Future<Either<Failures, UserEntity>> googleLogin() async {
    try {
      final userModel = await remoteDataSource.googleLogin();

      if (userModel == null) {
        return Left(ServerFailure('Google login failed'));
      }

      return Right(
        UserEntity(
          id: userModel.id,
          email: userModel.email ?? '',
          name: userModel.name ?? '',
        ),
      );
    } catch (e, st) {
      print('GoogleLogin Error: $e');
      print(st);
      return Left(ServerFailure(e.toString()));
    }
  }
}
