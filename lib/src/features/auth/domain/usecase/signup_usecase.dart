import '../repository/respository_interface.dart';
import '../auth_entity/entity.dart';

class SignupUsecase {
  final AuthRepositoryInterface repository;
  SignupUsecase(this.repository);
  Future<UserEntity> call({SignupParams? params}) {
    return repository.signUp(
      email: params!.email,
      password: params.password,
      name: params.name,
    );
  }
}

class SignupParams {
  final String email;
  final String password;
  final String name;

  SignupParams({
    required this.email,
    required this.password,
    required this.name,
  });
}
