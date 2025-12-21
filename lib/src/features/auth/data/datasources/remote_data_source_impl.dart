import 'package:study_forge_ai/src/features/auth/data/datasources/remote_data_source.dart';
import 'package:study_forge_ai/src/features/auth/data/model/user_model.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final SupabaseClient supabaseClient;

  RemoteDataSourceImpl({required this.supabaseClient});

  /// ---------------- GET CURRENT USER (SESSION SAFE) ----------------
  @override
  Future<UserModel> getCurrentUser() async {
    var session = supabaseClient.auth.currentSession;
    var user = supabaseClient.auth.currentUser;

    if (session == null || user == null) {
      throw AuthException('No authenticated user found');
    }

    if (session.isExpired) {
      final response = await supabaseClient.auth.refreshSession();
      session = response.session;
      user = response.user;

      if (session == null || user == null) {
        throw AuthException('Session expired. Please login again.');
      }
    }

    final data = await supabaseClient
        .from('profiles')
        .select()
        .eq('id', user.id)
        .single();

    return UserModel.fromJson(data);
  }

  /// ---------------- LOGIN ----------------
  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final user = response.user;
    if (user == null) {
      throw AuthException('Invalid email or password');
    }

    final data = await supabaseClient
        .from('profiles')
        .select()
        .eq('id', user.id)
        .single();

    return UserModel.fromJson(data);
  }

  /// ---------------- SIGNUP ----------------
  @override
  Future<UserModel> signup({
    required String email,
    required String password,
    required String fullName,
  }) async {
    final response = await supabaseClient.auth.signUp(
      email: email,
      password: password,
    );

    final user = response.user;
    if (user == null) {
      throw AuthException('Failed to create user');
    }

    final model = UserModel(
      id: user.id,
      email: user.email!,
      fullName: fullName,
      profileImage: null,
      createdAt: DateTime.now(),
    );

    await supabaseClient.from('profiles').insert(model.toJson());
    return model;
  }

  /// ---------------- UPDATE PROFILE ----------------
  @override
  Future<UserModel> updateProfile({
    required String fullName,
    required String profileImage,
  }) async {
    final user = supabaseClient.auth.currentUser;

    if (user == null) {
      throw AuthException('No authenticated user found');
    }

    await supabaseClient.from('profiles').update({
      'full_name': fullName,
      'profile_image': profileImage,
    }).eq('id', user.id);

    final updatedData = await supabaseClient
        .from('profiles')
        .select()
        .eq('id', user.id)
        .single();

    return UserModel.fromJson(updatedData);
  }

  /// ---------------- GOOGLE SIGN IN ----------------
  @override
  Future<UserModel> signUpWithGoogle() async {
    await supabaseClient.auth.signInWithOAuth(
      Provider.google,
      redirectTo: 'https://aybarnykcohzlqhetjbe.supabase.co/auth/v1/callback',
    );

    final user = supabaseClient.auth.currentUser;
    if (user == null) {
      throw AuthException('Google sign-in failed');
    }

    final existingProfile = await supabaseClient
        .from('profiles')
        .select()
        .eq('id', user.id)
        .maybeSingle();

    if (existingProfile != null) {
      return UserModel.fromJson(existingProfile);
    }

    final model = UserModel(
      id: user.id,
      email: user.email!,
      fullName: user.userMetadata?['full_name'] ?? '',
      profileImage: user.userMetadata?['avatar_url'],
      createdAt: DateTime.now(),
    );

    await supabaseClient.from('profiles').insert(model.toJson());
    return model;
  }

  /// ---------------- LOGOUT ----------------
  @override
  Future<void> logout() async {
    await supabaseClient.auth.signOut();
  }
}
