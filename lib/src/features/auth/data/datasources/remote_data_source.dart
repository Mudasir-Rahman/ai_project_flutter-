import 'package:study_forge_ai/src/features/auth/data/model/user_model.dart';
import 'package:study_forge_ai/src/features/auth/domain/usecase/signin_usecase.dart';
import 'package:study_forge_ai/src/features/auth/domain/usecase/signup_usecase.dart';

abstract class RemoteDataSource {
  Future<UserModel> signInWithEmail(SignInParams params);
  Future<UserModel> signUpWithEmail(SignupParams params);
  Future<void> signOut();
}
