import 'package:study_forge_ai/src/features/auth/data/model/user_model.dart';
import 'package:study_forge_ai/src/features/auth/domain/usecase/signup_usecase.dart'
    show SignupParams;
import 'package:study_forge_ai/src/features/auth/domain/usecase/user_login_usecase.dart'
    show UserLoginParams;

abstract class RemoteDataSource {
  Future<UserModel> signUpWithEmail(SignupParams params);
  Future<UserModel> signInWithEmail(UserLoginParams params);
  Future<UserModel?> getCurrentUser();
  Future<void> signOut();
  Future<bool> register(String userId);
  Future<UserModel?> googleLogin();
}
