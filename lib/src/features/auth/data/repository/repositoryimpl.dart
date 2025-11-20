import 'package:dartz/dartz.dart';
import 'package:study_forge_ai/src/core/error/failures.dart';
import 'package:study_forge_ai/src/features/auth/data/datasources/remote_data_source.dart';
import 'package:study_forge_ai/src/features/auth/domain/auth_entity/entity.dart';
import 'package:study_forge_ai/src/features/auth/domain/repository/respository_interface.dart';
import 'package:study_forge_ai/src/features/auth/domain/usecase/signup_usecase.dart';
import 'package:study_forge_ai/src/features/auth/domain/usecase/user_login_usecase.dart';

class RepositoryImpl implements AuthRepositoryInterface {
  final RemoteDataSource remoteDataSource;
  RepositoryImpl(this.remoteDataSource);

  // =====================================================
  //                      SIGN UP
  // =====================================================
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

      return Right(
        UserEntity(
          id: userModel.id,
          email: userModel.email,
          name: userModel.name,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // =====================================================
  //                      LOGIN
  // =====================================================
  @override
  Future<Either<Failures, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.signInWithEmail(
        UserLoginParams(email: email, password: password),
      );

      return Right(UserEntity(id: user.id, email: user.email, name: user.name));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // =====================================================
  //                 GET CURRENT USER
  // =====================================================
  @override
  Future<Either<Failures, UserEntity?>> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUser();
      if (user == null) return const Right(null);

      return Right(UserEntity(id: user.id, email: user.email, name: user.name));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // =====================================================
  //                      REGISTER CHECK
  // =====================================================
  @override
  Future<Either<Failures, UserEntity>> register(String userId) async {
    try {
      final found = await remoteDataSource.register(userId);

      if (!found) {
        return Left(ServerFailure('User not found'));
      }

      // Only return ID since no other info is available
      return Right(UserEntity(id: userId, email: '', name: null));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // =====================================================
  //                      SIGN OUT
  // =====================================================
  @override
  Future<void> signOut() async {
    return await remoteDataSource.signOut();
  }

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}
