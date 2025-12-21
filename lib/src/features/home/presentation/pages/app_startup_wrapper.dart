
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_forge_ai/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:study_forge_ai/src/features/auth/presentation/bloc/auth_state.dart';
import 'package:study_forge_ai/src/features/auth/presentation/bloc/auth_event.dart';
import 'package:study_forge_ai/src/features/home/presentation/pages/home_page.dart';
import 'package:study_forge_ai/src/features/auth/presentation/pages/signin_ui.dart';
import 'package:study_forge_ai/src/core/session/session_manager.dart';

import '../../../auth/data/model/user_model.dart';

class SplashScreenWrapper extends StatefulWidget {
  const SplashScreenWrapper({super.key});

  @override
  State<SplashScreenWrapper> createState() => _SplashScreenWrapperState();
}

class _SplashScreenWrapperState extends State<SplashScreenWrapper>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  bool _checkingAuth = false;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    // Start auth check after animation
    Future.delayed(const Duration(seconds: 2), () {
      _checkAuthStatus();
    });
  }

  Future<void> _checkAuthStatus() async {
    if (_checkingAuth) return;
    _checkingAuth = true;

    print('\n🎯 ===== SPLASH AUTH CHECK =====');

    // Step 1: Check SessionManager first
    final wasLoggedIn = await SessionManager.wasUserLoggedIn();

    if (!wasLoggedIn) {
      print('📭 User has never logged in before');
      print('   Going to login screen...');
      _goToLogin();
      return;
    }

    print('✅ User was previously logged in');

    // Step 2: Try to restore Supabase session
    final sessionRestored = await SessionManager.restoreSupabaseSession();

    if (!sessionRestored) {
      print('⚠️ Supabase session not restored');
      print('   This could mean:');
      print('   1. Session expired');
      print('   2. User logged out');
      print('   3. App data cleared');
      _goToLogin();
      return;
    }

    print('✅ Supabase session restored successfully');

    // Step 3: Use AuthBloc to get user data
    print('🔄 Getting user data via AuthBloc...');
    if (mounted) {
      context.read<AuthBloc>().add(GetCurrentUserEvent());
    }
  }

  void _goToLogin() {
    print('👤 Navigating to login...');
    Future.microtask(() {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const SigninUi()),
        );
      }
    });
  }

  void _goToHome(UserModel user) {
    print('🏠 Navigating to home...');
    Future.microtask(() {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage(user: user)),
        );
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthBlocState>(
      listener: (context, state) {
        print('📢 Splash received state: ${state.runtimeType}');

        if (state is AuthSuccess) {
          print('🎉 AuthSuccess! User: ${state.user.email}');
          _goToHome(state.user);
        } else if (state is AuthLoggedOut || state is AuthFailure) {
          print('⚠️ Auth failed: ${state is AuthFailure ? state.message : "Logged out"}');
          _goToLogin();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFF2196F3),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo
                ScaleTransition(
                  scale: _fadeController,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.school_rounded,
                      size: 60,
                      color: Color(0xFF1976D2),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // App name
                FadeTransition(
                  opacity: _fadeController,
                  child: const Text(
                    'Study Forge AI',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Tagline
                FadeTransition(
                  opacity: _fadeController,
                  child: const Text(
                    'Learn. Build. Innovate.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Loading indicator
                if (_checkingAuth || state is AuthLoading)
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),

                const SizedBox(height: 20),

                // Status text
                Text(
                  _getStatusText(state),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getStatusText(AuthBlocState state) {
    if (!_checkingAuth) return 'Starting...';
    if (state is AuthLoading) return 'Checking session...';
    if (state is AuthSuccess) return 'Welcome back!';
    return 'Redirecting to login...';
  }
}