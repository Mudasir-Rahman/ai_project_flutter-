// features/file/domain/repositories/file_repository.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../file_entity/file_entity.dart';
import '../file_usecase/count_files_usecase.dart';
import '../file_usecase/delete_file_usecase.dart';
import '../file_usecase/download_file_usecase.dart';
import '../file_usecase/get_all_file_usecase.dart';
import '../file_usecase/get_file_by_id_usecase.dart';
import '../file_usecase/get_recent_files_usecase.dart';
import '../file_usecase/search_files_usecase.dart';
import '../file_usecase/update_file_usecase.dart';
import '../file_usecase/upload_file_usecase.dart';


abstract class FileRepository {
  // Core CRUD operations
  Future<Either<Failures, List<FileEntity>>> getFiles(GetFilesParams params);
  Future<Either<Failures, FileEntity>> uploadFile(UploadFileParams params);
  Future<Either<Failures, bool>> deleteFile(DeleteFileParams params);
  Future<Either<Failures, FileEntity>> getFileById(GetFileByIdParams params);
  Future<Either<Failures, FileEntity>> updateFile(UpdateFileParams params);

  // Additional operations
  Future<Either<Failures, String>> downloadFile(DownloadFileParams params);
  Future<Either<Failures, List<FileEntity>>> searchFiles(SearchFilesParams params);
  Future<Either<Failures, List<FileEntity>>> getRecentFiles(GetRecentFilesParams params);
  Future<Either<Failures, int>> countFiles(CountFilesParams params);
}