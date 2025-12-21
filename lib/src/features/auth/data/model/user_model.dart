import 'package:study_forge_ai/src/features/auth/domain/auth_entity/entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required String id,
    required String email,
    required String fullName,
    String? profileImage,
    required DateTime createdAt,

  }) :super (
      id: id,
      email: email,
      fullName: fullName,
      profileImage: profileImage,
      createdAt: createdAt
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      email: json['email'].toString(),
      fullName: json['full_name'].toString(),
      profileImage: json['profile_image'].toString(),
      createdAt: json['created_at'],
    );
  }
  Map<String, dynamic> toJson() {
 return {
   'id': id,
   'email': email,
   'full_name': fullName,
   'profile_image': profileImage,
   'created_at': createdAt,
 };
 // now handle with copy with

  }

  UserModel copyWith({
    String? id,
    String? email,
    String? fullName,
    String? profileImage,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      profileImage: profileImage ?? this.profileImage,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
