import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/useCase/use_case.dart';
import '../auth_entity/entity.dart';
import '../repository/respository_interface.dart';

class SignInWithGoogleUseCase
    implements UseCase<UserEntity, NoParams> {
  final AuthRepository repository;

  SignInWithGoogleUseCase(this.repository);

  @override
  Future<Either<Failures, UserEntity>> call(NoParams params) async {
    return await repository.SignUpWithGoogle();
  }
}
