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
      if (user == null) {
        print('❌ No auth user');
        return null;
      }

      print('🔍 Fetching user data for ID: ${user.id}');

      // Use maybeSingle() instead of single()
      final data = await supabaseClient
          .from('users')
          .select()
          .eq('id', user.id)
          .maybeSingle(); // ← RETURNS NULL INSTEAD OF THROWING

      if (data == null) {
        print('❌ No user found in users table for ID: ${user.id}');
        return null;
      }

      print('✅ User data found: $data');
      return UserModel.fromJson(data);
    } catch (e, st) {
      print('❌ Error fetching current user: $e');
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
  //                      GOOGLE LOGIN - CORRECTED
  // =====================================================
  @override
  Future<UserModel?> googleLogin() async {
    try {
      // ✅ CORRECT: Use the OAuth flow with await
      await supabaseClient.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'studyforgeai://auth-callback', // Your app's custom scheme
      );

      //  IMPORTANT: In Flutter, OAuth login happens in a web browser
      // The actual user data will be available after the browser redirects back to your app

      // Wait a moment for the auth state to update
      await Future.delayed(const Duration(seconds: 2));

      // Check if user is now logged in
      final user = supabaseClient.auth.currentUser;
      if (user == null) {
        throw Exception('Google login failed or was cancelled');
      }

      print("Google login successful: User ID = ${user.id}");

      // Check if user exists in 'users' table
      final data = await supabaseClient
          .from('users')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      if (data != null) {
        return UserModel.fromJson(data);
      }

      // Insert new user if not exists
      final name = user.userMetadata?['full_name'] ??
          user.userMetadata?['name'] ??
          'Google User';
      final email = user.email ?? '${user.id}@google.com';

      await supabaseClient.from('users').insert({
        'id': user.id,
        'email': email,
        'name': name,
      });

      print("New Google user created: $name, $email");

      return UserModel(id: user.id, email: email, name: name);
    } catch (e, st) {
      print('Error during Google login: $e');
      print(st);
      rethrow;
    }
  }
  // =====================================================
  //                      SESSION CHECK - CORRECTED
  // =====================================================
  Future<bool> hasActiveSession() async {
    try {
      final session = supabaseClient.auth.currentSession;
      return session != null;
    } catch (e) {
      print('Error checking session: $e');
      return false;
    }
  }
}