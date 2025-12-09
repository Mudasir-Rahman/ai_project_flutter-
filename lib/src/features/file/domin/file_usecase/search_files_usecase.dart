// // features/file/domain/usecases/search_files_usecase.dart
// import 'package:dartz/dartz.dart';
// import '../../../../core/error/failures.dart';
// import '../file_entity/file_entity.dart';
// import '../repositories/file_repositories.dart';
//
//
// class SearchFilesParams {
//   final String query;
//   final String? userId;
//   final List<String>? fileTypes; // ['pdf', 'docx']
//   final int limit;
//
//   const SearchFilesParams({
//     required this.query,
//     this.userId,
//     this.fileTypes,
//     this.limit = 20,
//   });
// }
//
// class SearchFilesUseCase {
//   final FileRepository repository;
//
//   SearchFilesUseCase(this.repository);
//
//   Future<Either<Failures, List<FileEntity>>> call(SearchFilesParams params) async {
//     return await repository.searchFiles(params);
//   }
// }