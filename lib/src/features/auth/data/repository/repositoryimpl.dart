// // lib/features/auth/data/repositories/auth_repository_impl.dart
//
// import 'package:dartz/dartz.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:study_forge_ai/src/features/auth/domain/repository/respository_interface.dart';
// import '../../../../core/error/exceptions.dart';
// import '../../../../core/error/failures.dart';
// import '../../domain/auth_entity/entity.dart';
//
//
// class AuthRepositoryImpl implements AuthRepositoryInterface {
//   final AuthRemoteDataSource remoteDataSource;
//   final NetworkInfo networkInfo;
//   final SharedPreferences sharedPreferences;
//
//   AuthRepositoryImpl({
//     required this.remoteDataSource,
//     required this.networkInfo,
//     required this.sharedPreferences,
//   });
//
//   @override
//   Future<Either<Failures, UserEntity>> login({
//     required String email,
//     required String password,
//   }) async {
//     if (await networkInfo.isConnected) {
//       try {
//         final user = await remoteDataSource.login(
//           email: email,
//           password: password,
//         );
//         return Right(user);
//       } on ServerException catch (e) {
//         return Left(ServerFailure(e.message));
//       } on UnauthorizedException catch (e) {
//         return Left(UnauthorizedFailure(e.message));
//       }
//     } else {
//       return const Left(NetworkFailure());
//     }
//   }
//
//   @override
//   Future<Either<Failures, UserEntity>> signup({
//     required String email,
//     required String password,
//     required String fullName,
//   }) async {
//     if (await networkInfo.isConnected) {
//       try {
//         final user = await remoteDataSource.signup(
//           email: email,
//           password: password,
//           fullName: fullName,
//         );
//         return Right(user);
//       } on ServerException catch (e) {
//         return Left(ServerFailure(e.message));
//       }
//     } else {
//       return const Left(NetworkFailure());
//     }
//   }
//
//   @override
//   Future<Either<Failure, void>> logout() async {
//     if (await networkInfo.isConnected) {
//       try {
//         await remoteDataSource.logout();
//         return const Right(null);
//       } on ServerException catch (e) {
//         return Left(ServerFailure(e.message));
//       }
//     } else {
//       return const Left(NetworkFailure());
//     }
//   }
//
//   @override
//   Future<Either<Failure, UserEntity>> getCurrentUser() async {
//     if (await networkInfo.isConnected) {
//       try {
//         final user = await remoteDataSource.getCurrentUser();
//         return Right(user);
//       } on ServerException catch (e) {
//         return Left(ServerFailure(e.message));
//       }
//     } else {
//       return const Left(NetworkFailure());
//     }
//   }
//
//   @override
//   Future<bool> isLoggedIn() async {
//     return sharedPreferences.getBool(AppConstants.isLoggedInKey) ?? false;
//   }
// }