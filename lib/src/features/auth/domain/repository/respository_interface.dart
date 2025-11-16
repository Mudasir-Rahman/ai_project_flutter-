import 'package:equatable/equatable.dart';
import '../auth_entity/entity.dart';

abstract class AuthRepositoryInterface extends Equatable {
  Future<UserEntity> signIn({required String email, required String password});
  Future<UserEntity> signUp({
    required String email,
    required String password,
    required String name,
  });
  Future<UserEntity> getCurrentUser();
  Future<void> signOut();
  List<Object?> get props => [];
}
