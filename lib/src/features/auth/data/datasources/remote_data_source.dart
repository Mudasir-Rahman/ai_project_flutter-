import 'package:study_forge_ai/src/features/auth/data/model/user_model.dart';

abstract class RemoteDataSource {
  Future<UserModel> login({
    required String email,
    required String password,
  });
  Future<UserModel> getCurrentUser();
  Future<void> logout();
  Future<UserModel> updateProfile({
    required String fullName,
    required String profileImage,
  });
  Future<UserModel> signUpWithGoogle();
  Future<UserModel> signup({
    required String email,
    required String password,
    required String fullName,
  });

}