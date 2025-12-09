import 'package:study_forge_ai/src/features/file/domin/file_usecase/delete_file_usecase.dart';

import 'package:study_forge_ai/src/features/file/domin/file_usecase/get_file_by_id_usecase.dart';
import 'package:study_forge_ai/src/features/file/domin/file_usecase/upload_file_usecase.dart';

import '../../domin/file_usecase/get_file_usecase.dart';
import '../model/file_model.dart';

abstract class FileRemoteDataSource {
  Future<List<FileModel>> getFiles(GetFilesParams params);
  Future<FileModel> uploadFile(UploadFileParams params);
  Future<bool> deleteFile(DeleteFileParams params);
  // Future<String> getFileById( GetFileByIdParams params);
  Future<FileModel> getFileById(GetFileByIdParams params);
}


