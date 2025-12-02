import 'package:dartz/dartz.dart';
import 'package:study_forge_ai/src/core/error/failures.dart';

import '../file_entity/file_entity.dart';


abstract class FileRepositories {
  Future<Either<Failures, FileEntity>> saveFile(
      String fileName,
      String filePath,
      );

  Future<Either<Failures, List<FileEntity>>> getFiles();

  Future<Either<Failures, bool>> deleteFile(String fileId);
}
