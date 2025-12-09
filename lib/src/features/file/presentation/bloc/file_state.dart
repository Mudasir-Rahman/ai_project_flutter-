// features/file/presentation/bloc/file_state.dart
import 'package:equatable/equatable.dart';


import '../../domin/file_entity/file_entity.dart';

abstract class FileState extends Equatable {
  const FileState();

  @override
  List<Object?> get props => [];
}

// Initial state
class FileInitial extends FileState {}

// Loading state
class FileLoading extends FileState {
  final String? message;
  const FileLoading({this.message});

  @override
  List<Object?> get props => [message];
}

// Files loaded successfully
class FilesLoaded extends FileState {
  final List<FileEntity> files;
  final String? userId;


  const FilesLoaded(this.files,  this.userId);

  @override
  List<Object?> get props => [files];
}

// Single file loaded
class FileLoaded extends FileState {
  final FileEntity file;

  const FileLoaded(this.file);

  @override
  List<Object?> get props => [file];
}

// File uploaded successfully
class FileUploaded extends FileState {
  final FileEntity file;

  const FileUploaded(this.file);

  @override
  List<Object?> get props => [file];
}

// File deleted successfully
class FileDeleted extends FileState {
  final String fileId;

  const FileDeleted(this.fileId);

  @override
  List<Object?> get props => [fileId];
}

// Error state
class FileError extends FileState {
  final String message;

  const FileError(this.message);

  @override
  List<Object?> get props => [message];
}