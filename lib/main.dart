import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_forge_ai/init_dependence.dart'
    show initDependencies, serviceLocator;

import 'package:study_forge_ai/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:study_forge_ai/src/features/file/presentation/bloc/file_bloc.dart';
import 'package:study_forge_ai/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:study_forge_ai/src/features/home/presentation/pages/app_startup_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  print('🚀 App starting...');

  // Initialize all dependencies
  await initDependencies();

  // CRITICAL: Wait for Supabase session restoration
  await Future.delayed(const Duration(seconds: 2));

  print('✅ App initialized, running...');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocator<HomeDashboardBloc>()),
        BlocProvider(create: (_) => serviceLocator<FileBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AI Study Partner',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreenWrapper(),
      ),
    );
  }
}