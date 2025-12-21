import 'package:dartz/dartz.dart';
import 'package:study_forge_ai/src/core/useCase/use_case.dart';

import '../../../../core/error/failures.dart';
import '../auth_entity/entity.dart';
import '../repository/respository_interface.dart';

class GetCurrentUser implements UseCase<UserEntity?,NoParams> {
  final AuthRepository authRepository;
  GetCurrentUser(this.authRepository);
  @override
  Future<Either<Failures, UserEntity?>> call(NoParams params) async {
   return await authRepository.getCurrentUser();
  }
}
