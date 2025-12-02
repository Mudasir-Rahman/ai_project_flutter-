// features/file/domain/usecases/update_file_usecase.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

import '../file_entity/file_entity.dart';
import '../repositories/file_repositories.dart';


class UpdateFileParams {
  final String fileId;
  final String? newName;
  final String? description;
  final Map<String, dynamic>? metadata;

  const UpdateFileParams({
    required this.fileId,
    this.newName,
    this.description,
    this.metadata,
  });
}

class UpdateFileUseCase {
  final FileRepository repository;

  UpdateFileUseCase(this.repository);

  Future<Either<Failures, FileEntity>> call(UpdateFileParams params) async {
    return await repository.updateFile(params);
  }
}