import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_forge_ai/src/features/file/data/repository_impl/file_repository_impl.dart';
import 'package:study_forge_ai/src/features/file/domin/file_usecase/get_file_by_id_usecase.dart';
import 'package:study_forge_ai/src/features/file/domin/file_usecase/get_file_usecase.dart';
import 'package:study_forge_ai/src/features/file/domin/file_usecase/upload_file_usecase.dart';
import 'package:study_forge_ai/src/features/file/presentation/bloc/file_event.dart';

import '../../domin/file_usecase/delete_file_usecase.dart';
import 'file_state.dart';

class FileBloc extends Bloc<FileEvent,FileState>{
final GetFileByIdUseCase getFileByIdUseCase;
final UploadFileUseCase uploadFileUseCase;
final DeleteFileUseCase deleteFileUseCase;
final GetFilesUseCase getFilesUseCase;

  FileBloc({
    required this.getFileByIdUseCase,
    required this.uploadFileUseCase,
    required this.deleteFileUseCase,
    required this.getFilesUseCase,
  }):super(FileInitial()) {
    on<LoadFilesEvent>(_onLoadFiles);
    on<UploadFileEvent>(_onUploadFile);
    on<DeleteFileEvent>(_onDeleteFile);
    on<GetFileByIdEvent>(_onGetFileById);
  }
  // handle load files
Future<void> _onLoadFiles(LoadFilesEvent event,
    Emitter<FileState> emit) async {
  emit(FileLoading(message: 'Loading files...'));
  try {
    final result = await getFilesUseCase(GetFilesParams(userId: event.userId));
    result.fold(
            (failure) => emit(FileError(failure.message)),
            (files) => emit(FilesLoaded(files, event.userId)));
  } catch (e) {
    emit(FileError('Failed to load files: $e'));

  }
}
// handle upload file
Future<void> _onUploadFile(UploadFileEvent event,
Emitter<FileState>emit) async {
  emit(FileLoading(message: 'Uploading file...')  );
  try{
    final result = await uploadFileUseCase(event.params);
    result.fold(
            (failure) => emit(FileError(failure.message)),
            (file) => emit(FileUploaded(file)));

  }
  catch (e){
    emit(FileError('Failed to upload file: $e'));
  }

  }
  // handle delete file
Future<void> _onDeleteFile(DeleteFileEvent event,
Emitter<FileState>emit) async {
  emit(FileLoading(message: 'Deleting file...'));
try{
  final result = await deleteFileUseCase(event.params);
  result.fold(
          (failure) => emit(FileError(failure.message)),
          (success) => emit(FileDeleted(event.params.fileId)));
}
catch (e){
  emit(FileError('Failed to delete file: $e'));
}

}
Future<void> _onGetFileById(GetFileByIdEvent event,
Emitter<FileState>emit) async {
    emit(FileLoading(message: 'Loading file...'));
    try {
      final result = await getFileByIdUseCase(event.params);
      result.fold(
              (failure) => emit(FileError(failure.message)),
              (file) => emit(FileLoaded(file)));
    } catch (e) {
      emit(FileError('Failed to load file: $e'));
    }
}


}
