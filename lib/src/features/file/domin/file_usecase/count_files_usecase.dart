// features/file/domain/usecases/count_files_usecase.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/file_repositories.dart';


class CountFilesParams {
  final String? userId;
  final List<String>? fileExtensions;

  const CountFilesParams({
    this.userId,
    this.fileExtensions,
  });
}

class CountFilesUseCase {
  final FileRepository repository;

  CountFilesUseCase(this.repository);

  Future<Either<Failures, int>> call(CountFilesParams params) async {
    return await repository.countFiles(params);
  }
}