import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable {
  final String message;
  const Failures(this.message);

  @override
  List<Object?> get props => [message];
}

// General Failures
class ServerFailure extends Failures {
  const ServerFailure(String message) : super(message);
}

class CacheFailure extends Failures {
  const CacheFailure(String message) : super(message);
}

// File-related Failures
class FileFailure extends Failures {
  const FileFailure([String message = 'File operation failed']) : super(message);
}

class FileNotFoundFailure extends FileFailure {
  const FileNotFoundFailure() : super('File not found');
}

class FileUploadFailure extends FileFailure {
  const FileUploadFailure() : super('Failed to upload file');
}

class FileDeleteFailure extends FileFailure {
  const FileDeleteFailure() : super('Failed to delete file');
}
