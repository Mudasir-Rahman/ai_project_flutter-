import '../repository/respository_interface.dart';
import '../auth_entity/entity.dart';

class SigninUsecase {
  final AuthRepositoryInterface repository;
  SigninUsecase(this.repository);
  Future<UserEntity> call({SignInParams? params}) {
    return repository.signIn(email: params!.email, password: params.password);
  }
}

class SignInParams {
  final String email;
  final String password;

  SignInParams({required this.email, required this.password});
}
