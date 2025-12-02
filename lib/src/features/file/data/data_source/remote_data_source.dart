import '../model/file_model.dart';

abstract class FileRemoteDataSource {
  Future<List<FileModel>> getFiles({String? userId});
  Future<FileModel> uploadFile({
    required String filePath,
    required String userId,
    String? fileName,
  });
  Future<bool> deleteFile(String fileId, String path);
  Future<String> getFileUrl(String path);
}