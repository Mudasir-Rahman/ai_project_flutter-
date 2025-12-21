import 'package:dartz/dartz.dart';
import 'package:study_forge_ai/src/core/error/failures.dart';
import 'package:study_forge_ai/src/features/auth/domain/auth_entity/entity.dart';

abstract class AuthRepository{

  // Login
Future<Either<Failures,UserEntity>> login({
  required String email,
  required String password,
}
    );
// Logout
Future<Either<Failures,void>> logout();
// Get Current User
Future<Either<Failures,UserEntity>> getCurrentUser();
// Check if user is logged in
Future<bool> isLoggedIn();
// Check if user Authenticated
Future<Either<Failures,bool>>isAuthenticated();
// Update user profile
Future<Either<Failures,UserEntity>>UpdateProfile({
    required String fullName,
    required String profileImage,
});
// Social Login
Future<Either<Failures,UserEntity>>SignUpWithGoogle();
// signup use case
Future<Either<Failures,UserEntity>> signup({
  required String email,
  required String password,
  required String fullName,
  });
}
