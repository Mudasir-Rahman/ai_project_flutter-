import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../file_entity/file_entity.dart';
import '../repositories/file_repositories.dart';

class GetFileUseCase {
  final FileRepositories repositories;
  GetFileUseCase({required this.repositories});
  Future<Either<Failures, List<FileEntity>>>call ()async{
    return await repositories.getFiles();

  }
}