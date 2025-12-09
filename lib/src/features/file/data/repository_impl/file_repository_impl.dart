import 'package:dartz/dartz.dart';
import 'package:study_forge_ai/src/core/error/failures.dart';


import '../../domin/file_entity/file_entity.dart';
import '../../domin/file_usecase/delete_file_usecase.dart';
import '../../domin/file_usecase/get_file_by_id_usecase.dart';
import '../../domin/file_usecase/get_file_usecase.dart';
import '../../domin/file_usecase/upload_file_usecase.dart';
import '../../domin/repositories/file_repositories.dart';
import '../data_source/remote_data_source.dart';

class FileRepositoryImpl  implements FileRepository {
  final FileRemoteDataSource remoteDataSource;

  FileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, List<FileEntity>>> getFiles(
      GetFilesParams params) async {
    try {
      final files = await remoteDataSource.getFiles(params);
      return Right(files.map((model) => model.toEntity()).toList());
    }
    catch (e) {
      return Left(ServerFailure('Failed To Get Files'));
    }
  }

  @override
  Future<Either<Failures, FileEntity>> uploadFile(
      UploadFileParams params) async {
    try {
      final file = await remoteDataSource.uploadFile(params);
      return Right(file.toEntity());
    } catch (e) {
      return Left(ServerFailure('Failed To Upload File'));
    }
  }

  @override
  Future<Either<Failures, bool>> deleteFile(DeleteFileParams params) async {
    try {
     final file = await remoteDataSource.deleteFile(params);
      return Right(file);
    }catch (e) {
      return Left(ServerFailure('Failed To Delete File'));
    }
  }
  @override
  Future<Either<Failures, FileEntity>> getFileById(GetFileByIdParams params) async {
    try {
      // Get all files and filter
      final files = await remoteDataSource.getFiles(GetFilesParams());
      final file = files.firstWhere(
            (model) => model.id == params.fileId,
      );
      return Right(file.toEntity());
    } catch (e) {
      return Left(FileNotFoundFailure(e.toString()));
    }
  }
}