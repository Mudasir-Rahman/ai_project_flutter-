import 'package:supabase_flutter/supabase_flutter.dart';

/// A service class to centralize access to the Supabase client instance.
///
/// Note: Supabase must be initialized using `Supabase.initialize(...)`
/// in your application's main function before accessing this client.
class SupabaseClientService {
  // Static getter to easily retrieve the globally available Supabase client.
  static SupabaseClient get client {
    // This will throw an error if Supabase has not been initialized.
    return Supabase.instance.client;
  }
}