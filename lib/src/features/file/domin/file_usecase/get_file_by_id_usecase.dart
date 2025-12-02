// features/file/domain/usecases/get_file_by_id_usecase.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../file_entity/file_entity.dart';
import '../repositories/file_repositories.dart';


class GetFileByIdParams {
  final String fileId;

  const GetFileByIdParams(this.fileId);
}

class GetFileByIdUseCase {
  final FileRepository repository;

  GetFileByIdUseCase(this.repository);

  Future<Either<Failures, FileEntity>> call(GetFileByIdParams params) async {
    return await repository.getFileById(params );
  }
}