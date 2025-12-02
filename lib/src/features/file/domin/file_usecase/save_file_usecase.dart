import 'package:dartz/dartz.dart';
import 'package:study_forge_ai/src/core/error/failures.dart';
import 'package:study_forge_ai/src/features/file/domin/file_entity/file_entity.dart';
import 'package:study_forge_ai/src/features/file/domin/repositories/file_repositories.dart';

class SaveFileUseCase {
  final FileRepositories repositories;
  SaveFileUseCase({required this.repositories});
  Future<Either<Failures, FileEntity>>call (String fileName, String filePath) async{
return await repositories.saveFile(fileName, filePath);

  }
}