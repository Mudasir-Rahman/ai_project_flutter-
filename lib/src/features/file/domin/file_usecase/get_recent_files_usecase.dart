// features/file/domain/usecases/get_recent_files_usecase.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../file_entity/file_entity.dart';
import '../repositories/file_repositories.dart';


class GetRecentFilesParams {
  final String? userId;
  final int days;
  final int limit;

  const GetRecentFilesParams({
    this.userId,
    this.days = 7,
    this.limit = 10,
  });
}

class GetRecentFilesUseCase {
  final FileRepository repository;

  GetRecentFilesUseCase(this.repository);

  Future<Either<Failures, List<FileEntity>>> call(GetRecentFilesParams params) async {
    return await repository.getRecentFiles(params);
  }
}