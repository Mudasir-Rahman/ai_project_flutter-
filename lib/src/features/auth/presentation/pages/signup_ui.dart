//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:study_forge_ai/src/features/auth/domain/repository/respository_interface.dart';
// import 'package:study_forge_ai/src/features/auth/presentation/bloc/auth_bloc.dart';
// import 'package:study_forge_ai/src/features/auth/presentation/bloc/auth_event.dart';
// import 'package:study_forge_ai/src/features/auth/presentation/bloc/auth_state.dart';
// import 'package:study_forge_ai/src/features/home/presentation/bloc/home_bloc.dart';
// import 'package:study_forge_ai/src/features/home/presentation/bloc/home_event.dart';
//
// import '../../../home/presentation/pages/home_page.dart';
// import '../widgets/custom_text_field.dart';
//
// class SignupUi extends StatefulWidget {
//   const SignupUi({super.key});
//
//   @override
//   State<SignupUi> createState() => _SignupUiState();
// }
//
// class _SignupUiState extends State<SignupUi> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   final Color primaryColor = const Color(0xFF2196F3);
//
//   @override
//   void dispose() {
//     nameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
//
//   void submitSignup() {
//     if (!_formKey.currentState!.validate()) return;
//
//     context.read<AuthBloc>().add(
//       SignupEvent(
//         name: nameController.text.trim(),
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       ),
//     );
//   }
//
//   String? _nameValidator(String? v) =>
//       v == null || v.isEmpty ? 'Please enter your name' : null;
//
//   String? _emailValidator(String? v) {
//     if (v == null || v.isEmpty) return 'Please enter your email';
//     if (!v.contains('@')) return 'Enter valid email';
//     return null;
//   }
//
//   String? _passwordValidator(String? v) =>
//       v == null || v.length < 6 ? 'Password must be 6+ characters' : null;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: BlocConsumer<AuthBloc, AuthBlocState>(
//         listener: (context, state) {
//           if (state is AuthFailure) {
//             ScaffoldMessenger.of(context)
//                 .showSnackBar(SnackBar(content: Text(state.message)));
//           }
//           if (state is AuthSuccess) {
//             // Create the bloc first
//             final homeBloc = HomeDashboardBloc()
//               ..add(LoadDashboardDataEvent(state.user));
//
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => BlocProvider.value(
//                   value: homeBloc,
//                   child: const HomePage(),
//                 ),
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           final isLoading = state is AuthLoading;
//
//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(30),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const SizedBox(height: 50),
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: IconButton(
//                     icon: const Icon(Icons.arrow_back),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Center(
//                   child: Image.asset(
//                     'assets/study.PNG',
//                     height: 160,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//                 const Text(
//                   "Study Forge Ai",
//                   style: TextStyle(
//                       fontWeight: FontWeight.w900,
//                       fontSize: 30,
//                       color: Colors.black),
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   "Create Account",
//                   style: TextStyle(
//                       fontWeight: FontWeight.w900,
//                       fontSize: 30,
//                       color: Colors.black),
//                 ),
//                 const SizedBox(height: 30),
//                 Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       CustomTextField(
//                         controller: nameController,
//                         hintText: "Full Name",
//                         prefixIcon: Icons.person_outline,
//                         validator: _nameValidator,
//                       ),
//                       const SizedBox(height: 20),
//                       CustomTextField(
//                         controller: emailController,
//                         hintText: "Email Address",
//                         prefixIcon: Icons.email_outlined,
//                         validator: _emailValidator,
//                       ),
//                       const SizedBox(height: 20),
//                       CustomTextField(
//                         controller: passwordController,
//                         hintText: "Password",
//                         prefixIcon: Icons.lock_outline,
//                         isPassword: true,
//                         validator: _passwordValidator,
//                       ),
//                       const SizedBox(height: 50),
//                       SizedBox(
//                         width: double.infinity,
//                         height: 50,
//                         child: isLoading
//                             ? const Center(
//                           child: CircularProgressIndicator(
//                             color: Color(0xFF2196F3),
//                           ),
//                         )
//                             : ElevatedButton(
//                           onPressed: submitSignup,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: primaryColor,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           child: const Text(
//                             "SIGN UP",
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "Already have an account?",
//                       style: TextStyle(color: Colors.grey, fontSize: 16),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: Text(
//                         "Log In",
//                         style: TextStyle(
//                           color: primaryColor,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_forge_ai/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:study_forge_ai/src/features/auth/presentation/bloc/auth_event.dart';
import 'package:study_forge_ai/src/features/auth/presentation/bloc/auth_state.dart';
import 'package:study_forge_ai/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:study_forge_ai/src/features/home/presentation/bloc/home_event.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../widgets/custom_text_field.dart';

class SignupUi extends StatefulWidget {
  const SignupUi({super.key});

  @override
  State<SignupUi> createState() => _SignupUiState();
}

class _SignupUiState extends State<SignupUi> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final Color primaryColor = const Color(0xFF2196F3);
  final Color secondaryColor = const Color(0xFF1976D2);

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void submitSignup() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(
      SignupEvent(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ),
    );
  }

  String? _nameValidator(String? v) =>
      v == null || v.isEmpty ? 'Please enter your name' : null;

  String? _emailValidator(String? v) {
    if (v == null || v.isEmpty) return 'Please enter your email';
    if (!v.contains('@')) return 'Enter valid email';
    return null;
  }

  String? _passwordValidator(String? v) =>
      v == null || v.length < 6 ? 'Password must be 6+ characters' : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primaryColor.withOpacity(0.1),
              Colors.white,
              secondaryColor.withOpacity(0.05),
            ],
          ),
        ),
        child: BlocConsumer<AuthBloc, AuthBlocState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red.shade400,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            }
            if (state is AuthSuccess) {
              final homeBloc = HomeDashboardBloc()
                ..add(LoadDashboardDataEvent(state.user));

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: homeBloc,
                    child: HomePage(user: state.user),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(30),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: Icon(Icons.arrow_back, color: primaryColor),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Center(
                          child: TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.0, end: 1.0),
                            duration: const Duration(milliseconds: 1000),
                            builder: (context, value, child) {
                              return Transform.scale(
                                scale: value,
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [primaryColor, secondaryColor],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: primaryColor.withOpacity(0.3),
                                        blurRadius: 20,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.school_rounded,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [primaryColor, secondaryColor],
                            ).createShader(bounds),
                            child: const Text(
                              "Study Forge AI",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 32,
                                color: Colors.white,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Create Account",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 28,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Start your learning adventure today",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: nameController,
                                hintText: "Full Name",
                                prefixIcon: Icons.person_outline,
                                validator: _nameValidator,
                              ),
                              const SizedBox(height: 20),
                              CustomTextField(
                                controller: emailController,
                                hintText: "Email Address",
                                prefixIcon: Icons.email_outlined,
                                validator: _emailValidator,
                              ),
                              const SizedBox(height: 20),
                              CustomTextField(
                                controller: passwordController,
                                hintText: "Password",
                                prefixIcon: Icons.lock_outline,
                                isPassword: true,
                                validator: _passwordValidator,
                              ),
                              const SizedBox(height: 50),
                              Container(
                                width: double.infinity,
                                height: 56,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                    colors: [primaryColor, secondaryColor],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: primaryColor.withOpacity(0.3),
                                      blurRadius: 15,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: isLoading
                                    ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                                    : Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: submitSignup,
                                    borderRadius: BorderRadius.circular(12),
                                    child: const Center(
                                      child: Text(
                                        "SIGN UP",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              // --- Divider ---
                              const Row(
                                children: [
                                  Expanded(child: Divider(color: Colors.grey)),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Text("OR", style: TextStyle(color: Colors.grey)),
                                  ),
                                  Expanded(child: Divider(color: Colors.grey)),
                                ],
                              ),
                              const SizedBox(height: 20),
                              // --- Sign Up with Google Button ---
                              Container(
                                width: double.infinity,
                                height: 56,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: isLoading ? null : submitSignup,
                                    borderRadius: BorderRadius.circular(12),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset("assets/google.png", height: 24),
                                          const SizedBox(width: 12),
                                          const Text(
                                            "Sign Up With Google",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Log In",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}