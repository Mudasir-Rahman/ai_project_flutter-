import 'package:study_forge_ai/src/features/auth/domain/auth_entity/entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.id, required super.email, required super.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id:( json['id']).toString(),
      email:( json['email']).toString(),
      name: (json['name']).toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'name': name};
  }
}
