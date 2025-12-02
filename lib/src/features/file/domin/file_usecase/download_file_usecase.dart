// features/file/domain/usecases/download_file_usecase.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/file_repositories.dart';


class DownloadFileParams {
  final String fileUrl;
  final String savePath;
  final String fileName;

  const DownloadFileParams({
    required this.fileUrl,
    required this.savePath,
    required this.fileName,
  });
}

class DownloadFileUseCase {
  final FileRepository repository;

  DownloadFileUseCase(this.repository);

  Future<Either<Failures, String>> call(DownloadFileParams params) async {
    return await repository.downloadFile(params);
  }
}