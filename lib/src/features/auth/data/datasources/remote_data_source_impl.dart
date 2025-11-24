import 'package:study_forge_ai/src/features/auth/data/datasources/remote_data_source.dart';
import 'package:study_forge_ai/src/features/auth/data/model/user_model.dart';
import 'package:study_forge_ai/src/features/auth/domain/usecase/signup_usecase.dart';
import 'package:study_forge_ai/src/features/auth/domain/usecase/user_login_usecase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final SupabaseClient supabaseClient;

  RemoteDataSourceImpl(this.supabaseClient);

  // =====================================================
  //                      SIGN UP
  // =====================================================
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      print('Signup started for email: $email');

      // 1. Auth Sign Up
      final AuthResponse response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
      );

      final user = response.user;
      if (user == null) {
        throw Exception('User signup failed');
      }

      print("Auth Signup Successful: User ID = ${user.id}");

      // 2. Insert into users table
      await supabaseClient.from('users').insert({
        'id': user.id,
        'email': email,
        'name': name,
      });

      print("User inserted into table successfully");

      return UserModel(id: user.id, email: email, name: name);
    } catch (e, st) {
      print('Error during signup: $e');
      print('Stack trace: $st');
      rethrow;
    }
  }

  @override
  Future<UserModel> signUpWithEmail(SignupParams params) async {
    return await signUp(
      email: params.email,
      password: params.password,
      name: params.name,
    );
  }

  // =====================================================
  //                      LOGIN
  // =====================================================
  Future<UserModel> login(UserLoginParams params) async {
    try {
      print('Login started for email: ${params.email}');

      final AuthResponse response = await supabaseClient.auth
          .signInWithPassword(email: params.email, password: params.password);

      final user = response.user;
      if (user == null) {
        throw Exception('Invalid email or password');
      }

      print("Login successful: User ID = ${user.id}");

      // Fetch user data
      final data = await supabaseClient
          .from('users')
          .select()
          .eq('id', user.id)
          .single();

      print('Fetched user data: $data');

      return UserModel.fromJson(data);
    } catch (e, st) {
      print('Error during login: $e');
      print('Stack trace: $st');
      rethrow;
    }
  }

  @override
  Future<UserModel> signInWithEmail(UserLoginParams params) async {
    return await login(params);
  }

  // =====================================================
  //                GET CURRENT LOGGED-IN USER
  // =====================================================
  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = supabaseClient.auth.currentUser;
      if (user == null) return null;

      final data = await supabaseClient
          .from('users')
          .select()
          .eq('id', user.id)
          .single();

      return UserModel.fromJson(data);
    } catch (e, st) {
      print('Error fetching current user: $e');
      print(st);
      return null;
    }
  }

  // =====================================================
  //                 REGISTER CHECK (OPTIONAL)
  // =====================================================
  @override
  Future<bool> register(String userId) async {
    try {
      final res = await supabaseClient
          .from('users')
          .select()
          .eq('id', userId)
          .maybeSingle();

      return res != null;
    } catch (e, st) {
      print('Error during register check: $e');
      print(st);
      return false;
    }
  }

  // =====================================================
  //                      SIGN OUT
  // =====================================================
  @override
  Future<void> signOut() async {
    try {
      await supabaseClient.auth.signOut();
      print('User signed out successfully');
    } catch (e, st) {
      print('Error during sign out: $e');
      print(st);
      rethrow;
    }
  }

// =====================================================
//                      GOOGLE LOGIN
// =====================================================


  @override
  Future<UserModel?> googleLogin() async {
    try {
      // 1️⃣ Start OAuth login (redirect to Google)
      await supabaseClient.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'https://aybarnykcohzlqhetjbe.supabase.co/auth/v1/callback', // your deep link
      );

      // 2️⃣ After redirect completes, fetch the current user
      final user = supabaseClient.auth.currentUser;
      if (user == null) return null;

      // 3️⃣ Check if user exists in 'users' table
      final data = await supabaseClient
          .from('users')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      if (data != null) {
        return UserModel.fromJson(data);
      }

      // 4️⃣ Insert new user if not exists
      final name = user.userMetadata?['full_name'] ?? 'No Name';
      await supabaseClient.from('users').insert({
        'id': user.id,
        'email': user.email,
        'name': name,
      });

      return UserModel(id: user.id, email: user.email!, name: name);
    } catch (e, st) {
      print('Error during Google login: $e');
      print(st);
      return null;
    }
  }

}


