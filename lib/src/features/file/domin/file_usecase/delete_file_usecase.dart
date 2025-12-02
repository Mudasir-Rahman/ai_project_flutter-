
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/file_repositories.dart';


class DeleteFileParams {
  final String fileId;
  final String path;
  final bool deletePermanently;

  const DeleteFileParams({
    required this.fileId,
    required this.path,
    this.deletePermanently = true,
  });
}

class DeleteFileUseCase {
  final FileRepository repository;

  DeleteFileUseCase(this.repository);

  Future<Either<Failures, bool>> call(DeleteFileParams params) async {
    return await repository.deleteFile(params );
  }
}