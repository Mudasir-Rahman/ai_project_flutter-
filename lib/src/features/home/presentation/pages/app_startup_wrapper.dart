import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_forge_ai/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:study_forge_ai/src/features/auth/presentation/bloc/auth_event.dart';
import 'package:study_forge_ai/src/features/home/presentation/pages/home_page.dart';
import 'package:study_forge_ai/src/features/auth/presentation/pages/signin_ui.dart';

import '../../../auth/presentation/bloc/auth_state.dart';

class AppStartupWrapper extends StatefulWidget {
  const AppStartupWrapper({super.key});

  @override
  State<AppStartupWrapper> createState() => _AppStartupWrapperState();
}

class _AppStartupWrapperState extends State<AppStartupWrapper> {
  @override
  void initState() {
    super.initState();
    // Check for existing session when app starts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(GetCurrentUserEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthBlocState>(
      builder: (context, state) {
        print('🔄 AppStartup State: $state');

        if (state is AuthLoading || state is AuthInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is AuthSuccess) {
          return const HomePage(); // User has active session
        }

        // AuthLoggedOut or AuthFailure - show login screen
        return const SigninUi();
      },
    );
  }
}