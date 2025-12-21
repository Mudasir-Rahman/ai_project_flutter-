import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/useCase/use_case.dart';
import '../repository/respository_interface.dart';

class SignOutUseCase implements UseCase<void, NoParams> {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  @override
  Future<Either<Failures, void>> call(NoParams params) async {
    return await repository.logout();
  }
}
