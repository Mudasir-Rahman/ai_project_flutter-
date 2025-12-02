// features/file/data/models/file_model.dart


import '../../domin/file_entity/file_entity.dart';

class FileModel extends FileEntity {
  FileModel({
    required String id,
    required String name,
    required String url,
    required String path,
    required DateTime createdAt,
    required String fileExtension,
    required int size,
    String? userId,
    Map<String, dynamic>? metadata,
  }) : super(
    id: id,
    name: name,
    url: url,
    path: path,
    createdAt: createdAt,
    fileExtension: fileExtension,
    size: size,
    userId: userId,
    metadata: metadata,
  );

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      path: json['path'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      fileExtension: json['extension'] ?? '',
      size: json['size'] ?? 0,
      userId: json['user_id'],
      metadata: json['metadata'] != null
          ? Map<String, dynamic>.from(json['metadata'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'path': path,
      'created_at': createdAt.toIso8601String(),
      'extension': fileExtension,
      'size': size,
      'user_id': userId,
      'metadata': metadata,
    };
  }

  FileEntity toEntity() {
    return FileEntity(
      id: id,
      name: name,
      url: url,
      path: path,
      createdAt: createdAt,
      fileExtension: fileExtension,
      size: size,
      userId: userId,
      metadata: metadata,
    );
  }
}