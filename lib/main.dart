import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_forge_ai/init_dependence.dart'
    show initDependencies, serviceLocator;

import 'package:study_forge_ai/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:study_forge_ai/src/features/auth/presentation/pages/signin_ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize all dependencies
  await initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => serviceLocator<AuthBloc>())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AI Study Partner',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const SigninUi(),
      ),
    );
  }
}
