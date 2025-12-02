// features/file/domain/entities/file_entity.dart
class FileEntity {
  final String id;
  final String name;
  final String url;
  final String path;
  final DateTime createdAt;
  final String fileExtension; // '.pdf', '.docx', '.txt'
  final int size;
  final String? userId;
  final Map<String, dynamic>? metadata;

  FileEntity({
    required this.id,
    required this.name,
    required this.url,
    required this.path,
    required this.createdAt,
    required this.fileExtension,
    required this.size,
    this.userId,
    this.metadata,
  });

  // Helper getters
  bool get isPdf => fileExtension.toLowerCase() == '.pdf';
  bool get isImage => ['.jpg', '.jpeg', '.png', '.gif']
      .contains(fileExtension.toLowerCase());
  bool get isDocument => ['.doc', '.docx', '.txt', '.rtf']
      .contains(fileExtension.toLowerCase());
}