// features/file/domain/usecases/get_files_usecase.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

import '../file_entity/file_entity.dart';
import '../repositories/file_repositories.dart';


// Params class for getting files with filters
class GetFilesParams {
  final String? userId;
  final List<String>? fileExtensions; // ['.pdf', '.docx']
  final DateTime? fromDate;
  final DateTime? toDate;
  final String? searchQuery;
  final bool sortByNewest;
  final int limit;
  final int offset;

  const GetFilesParams({
    this.userId,
    this.fileExtensions,
    this.fromDate,
    this.toDate,
    this.searchQuery,
    this.sortByNewest = true,
    this.limit = 20,
    this.offset = 0,
  });

  // Factory constructors for common scenarios
  factory GetFilesParams.all() => const GetFilesParams();

  factory GetFilesParams.forUser(String userId, {int limit = 20}) {
    return GetFilesParams(
      userId: userId,
      limit: limit,
    );
  }

  factory GetFilesParams.recent({int limit = 10}) {
    return GetFilesParams(
      limit: limit,
      sortByNewest: true,
    );
  }

  factory GetFilesParams.search(String query, {int limit = 20}) {
    return GetFilesParams(
      searchQuery: query,
      limit: limit,
    );
  }

  factory GetFilesParams.pdfsOnly({String? userId, int limit = 20}) {
    return GetFilesParams(
      userId: userId,
      fileExtensions: ['.pdf'],
      limit: limit,
    );
  }
}

class GetFilesUseCase {
  final FileRepository repository;

  GetFilesUseCase(this.repository);

  Future<Either<Failures, List<FileEntity>>> call(GetFilesParams params) async {
    return await repository.getFiles(params);
  }
}