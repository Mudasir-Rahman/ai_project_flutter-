import 'package:dartz/dartz.dart';
import 'package:study_forge_ai/src/features/file/domin/repositories/file_repositories.dart';

import '../../../../core/error/failures.dart';

class DeleteFileUseCase {
  final FileRepositories repository;
  DeleteFileUseCase(this.repository);

  Future<Either<Failures, bool>> call(String filePath) async {
    return await repository.deleteFile(filePath);
  }
}
