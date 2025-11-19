import 'package:study_forge_ai/src/features/auth/domain/auth_entity/entity.dart';

class UserModel extends UserEntity {
  final String id;
  final String email;
  final String name;

  UserModel({required this.id, required this.email, required this.name})
    : super(id: id, email: email, name: name);
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'name': name};
  }
}
