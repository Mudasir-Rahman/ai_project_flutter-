import 'dart:io';

import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;
import 'package:study_forge_ai/src/features/file/data/data_source/remote_data_source.dart';
import 'package:study_forge_ai/src/features/file/data/model/file_model.dart';

import 'package:study_forge_ai/src/features/file/domin/file_usecase/get_file_by_id_usecase.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide PostgrestException, StorageException;

import '../../../../core/error/failures.dart';
import '../../domin/file_usecase/delete_file_usecase.dart';
import '../../domin/file_usecase/get_file_usecase.dart';
import '../../domin/file_usecase/upload_file_usecase.dart';

class FileRemoteDataSourceImpl implements FileRemoteDataSource {
  final SupabaseClient supabaseClient;

  FileRemoteDataSourceImpl({required this.supabaseClient});

// delete file
  @override
  Future<bool> deleteFile(DeleteFileParams params) async {
    try {
      // delete from storage
      await supabaseClient.storage.from('files').remove(
          params.path as List<String>);

// delete from database
      await supabaseClient.from('files').delete().eq('id', params.fileId);
      return true;
    }
    on StorageException catch (e) {
      print('StorageException: $e');
      return false;
    }
    on PostgrestException catch (e) {
      print('PostgrestException: $e');
      return false;
    }
    on Exception catch (e) {
      print('Exception: $e');
      return false;
    }
  }

  //get file
  @override
  Future<List<FileModel>> getFiles(GetFilesParams params) async {
    try {
      // Build query
      final query = supabaseClient
          .from('files')
          .select('*');

      // Apply filters
      if (params.userId != null) {
        query.eq('user_id', params.userId!);
      }
// Apply file extensions filter if provided
      if (params.fileExtensions != null && params.fileExtensions!.isNotEmpty) {
        query.inFilter('extension', params.fileExtensions!);
      }
// Apply date range filter this show now created file
      if (params.fromDate != null) {
        query.gte('created_at', params.fromDate!.toIso8601String());
      }
// Apply date range filter  this show early created created
      if (params.toDate != null) {
        query.lte('created_at', params.toDate!.toIso8601String());
      }
// Apply search query to search the content based on the name
      if (params.searchQuery != null && params.searchQuery!.isNotEmpty) {
        query.ilike('name', '%${params.searchQuery!}%');
      }

      // Apply sorting
      query.order('created_at', ascending: !params.sortByNewest);

      // Apply pagination
      query.range(params.offset, params.offset + params.limit - 1);

      final response = await query;

      return (response as List)
          .map((json) => FileModel.fromJson(json))
          .toList();
    } on PostgrestException catch (e) {
      throw ServerFailure('Database error: ${e.message}');
    } catch (e) {
      throw ServerFailure('Failed to fetch files: $e');
    }
  }

// upload file
  @override
  Future<FileModel> uploadFile(UploadFileParams params) async {
    try {
      final file = File(params.filePath);
      final fileBytes = await file.readAsBytes();

      // Get file info
      final originalFileName = p.basename(params.filePath);
      final fileName = params.fileName ?? originalFileName;
      final fileExtension = p.extension(
          originalFileName); // Gets .pdf, .docx, etc.

      // Generate unique file name
      final uniqueName = '${DateTime
          .now()
          .millisecondsSinceEpoch}_${params.userId}$fileExtension';

      // Get mime type
      final mimeType = lookupMimeType(params.filePath) ??
          'application/octet-stream';

      // Upload to supabase storage - FIXED: removed 'upsert' parameter
      await supabaseClient.storage
          .from('files')
          .uploadBinary(
        uniqueName,
        fileBytes,
        fileOptions: FileOptions(
          contentType: mimeType,
        ),
      );

      // Get public URL
      final publicUrl = supabaseClient.storage
          .from('files')
          .getPublicUrl(uniqueName);

      // Generate file ID
      final fileId = 'file_${DateTime
          .now()
          .millisecondsSinceEpoch}';

      // Prepare metadata - remove dot from extension for database
      final extensionWithoutDot = fileExtension.startsWith('.')
          ? fileExtension.substring(1)
          : fileExtension;

      final metadata = {
        'original_name': originalFileName,
        'extension': extensionWithoutDot,
        'uploaded_via': 'mobile_app',
        ...?params.metadata,
      };
// this is the instant of the model
      final fileModel = FileModel(
        id: fileId,
        name: fileName,
        url: publicUrl,
        path: uniqueName,
        createdAt: DateTime.now(),
        fileExtension: fileExtension,
        size: fileBytes.length,
        userId: params.userId,
        metadata: metadata,
      );

      // Insert into database
      await supabaseClient
          .from('files')
          .insert(fileModel.toJson());

      return fileModel;
    } on StorageException catch (e) {
      throw FileUploadFailure('Storage error: ${e.message}');
    } on PostgrestException catch (e) {
      throw FileUploadFailure('Database error: ${e.message}');
    } catch (e) {
      throw FileUploadFailure('Upload failed: $e');
    }
  }

  @override
  Future<FileModel> getFileById(GetFileByIdParams params) async {
    try {
      final response = await supabaseClient
          .from('files')
          .select('*')
          .eq('id', params.fileId)
          .single();

      return FileModel.fromJson(response);
    }
    on PostgrestException catch (e) {
      // Handle "No rows selected" error from Supabase
      if (e.message.contains('No rows')) {
        throw FileNotFoundFailure('File not found for id ${params.fileId}');
      }

      throw ServerFailure('Database error: ${e.message}');
    }
    catch (e) {
      throw ServerFailure('Failed to fetch file: $e');
    }
  }

}




