// features/file/domain/usecases/upload_file_usecase.dart
import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

import '../file_entity/file_entity.dart';
import '../repositories/file_repositories.dart';


class UploadFileParams {
  final String filePath;
  final String userId;
  final String? fileName;
  final String? description;
  final Map<String, dynamic>? metadata;

  const UploadFileParams({
    required this.filePath,
    required this.userId,
    this.fileName,
    this.description,
    this.metadata,
  });

  factory UploadFileParams.simple({
    required String filePath,
    required String userId,
  }) {
    return UploadFileParams(
      filePath: filePath,
      userId: userId,
    );
  }
}

class UploadFileUseCase {
  final FileRepository repository;

  UploadFileUseCase(this.repository);

  Future<Either<Failures, FileEntity>> call(UploadFileParams params) async {
    return await repository.uploadFile(params );
  }
}