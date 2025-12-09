// features/file/presentation/bloc/file_event.dart
import 'dart:io';
import 'package:equatable/equatable.dart';
import '../../domin/file_usecase/delete_file_usecase.dart';
import '../../domin/file_usecase/get_file_by_id_usecase.dart';
import '../../domin/file_usecase/upload_file_usecase.dart';

abstract class FileEvent extends Equatable {
  const FileEvent();

  @override
  List<Object?> get props => [];
}

// Load all files
class LoadFilesEvent extends FileEvent {
  final String? userId;

  const LoadFilesEvent({this.userId});

  @override
  List<Object?> get props => [userId];
}

// Upload file
class UploadFileEvent extends FileEvent {
  final UploadFileParams params;

  const UploadFileEvent(this.params);

  @override
  List<Object?> get props => [params];
}

// Delete file
class DeleteFileEvent extends FileEvent {
  final DeleteFileParams params;

  const DeleteFileEvent(this.params);

  @override
  List<Object?> get props => [params];
}

// Get file by ID
class GetFileByIdEvent extends FileEvent {
  final GetFileByIdParams params;

  const GetFileByIdEvent(this.params);

  @override
  List<Object?> get props => [params];
}