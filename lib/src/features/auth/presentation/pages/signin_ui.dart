// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:study_forge_ai/src/features/auth/presentation/bloc/auth_event.dart';
// import 'package:study_forge_ai/src/features/auth/presentation/bloc/auth_state.dart';
// import 'package:study_forge_ai/src/features/auth/presentation/pages/signup_ui.dart';
// import '../bloc/auth_bloc.dart';
// import '../widgets/SocialSignInButton.dart';
// import '../widgets/custom_text_field.dart';
//
// class SigninUi extends StatefulWidget {
//   const SigninUi({super.key});
//
//   @override
//   State<SigninUi> createState() => _SigninUiState();
// }
//
// class _SigninUiState extends State<SigninUi> {
//   final _formKey = GlobalKey<FormState>();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//
//   bool _isLoading = false;
//   final Color primaryColor = const Color(0xFF2196F3);
//
//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
//
//   // -------------------------
//   // HANDLE EMAIL LOGIN
//   // -------------------------
//   void _submitSignIn() {
//     if (!_formKey.currentState!.validate()) return;
//
//     context.read<AuthBloc>().add(
//       LoginEvent(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       ),
//     );
//   }
//
//   // -------------------------
//   // FORM VALIDATION
//   // -------------------------
//   String? _emailValidator(String? v) {
//     if (v == null || v.isEmpty) return "Please enter your email";
//     if (!v.contains("@")) return "Enter valid email";
//     return null;
//   }
//
//   String? _passwordValidator(String? v) {
//     if (v == null || v.isEmpty) return "Please enter your password";
//     if (v.length < 6) return "Password must be 6+ characters";
//     return null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//
//       // -------------------------
//       // BLOC CONSUMER
//       // -------------------------
//       body: BlocConsumer<AuthBloc, AuthBlocState>(
//         listener: (context, state) {
//           if (state is AuthFailure) {
//             ScaffoldMessenger.of(context)
//                 .showSnackBar(SnackBar(content: Text(state.message)));
//           }
//
//           if (state is AuthSuccess) {
//             Navigator.pushReplacementNamed(context, "/home");
//           }
//         },
//
//         builder: (context, state) {
//           _isLoading = state is AuthLoading;
//
//           // -------------------------
//           // MAIN LOGIN UI
//           // -------------------------
//           return Stack(
//             children: [
//               SingleChildScrollView(
//                 padding: const EdgeInsets.all(30),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     const SizedBox(height: 50),
//
//                     // Header Image
//                     Center(
//                       child: Image.asset(
//                         'assets/study.PNG',
//                         height: 180,
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//
//                     const SizedBox(height: 20),
//
//                     const Text(
//                       "Welcome Back!",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w900,
//                         fontSize: 30,
//                         color: Colors.black,
//                       ),
//                     ),
//                     const SizedBox(height: 30),
//
//                     // -------------------------
//                     // FORM
//                     // -------------------------
//                     Form(
//                       key: _formKey,
//                       child: Column(
//                         children: [
//                           CustomTextField(
//                             controller: emailController,
//                             hintText: "Email Address",
//                             prefixIcon: Icons.email_outlined,
//                             validator: _emailValidator,
//                           ),
//                           const SizedBox(height: 20),
//
//                           CustomTextField(
//                             controller: passwordController,
//                             hintText: "Password",
//                             prefixIcon: Icons.lock_outline,
//                             isPassword: true,
//                             validator: _passwordValidator,
//                           ),
//
//                           const SizedBox(height: 10),
//
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: TextButton(
//                               onPressed: () {},
//                               child: Text(
//                                 "Forgot Password?",
//                                 style: TextStyle(
//                                   color: primaryColor,
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 20),
//
//                           // -------------------------
//                           // LOGIN BUTTON
//                           // -------------------------
//                           SizedBox(
//                             height: 50,
//                             width: double.infinity,
//                             child: ElevatedButton(
//                               onPressed: _isLoading ? null : _submitSignIn,
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: primaryColor,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                               child: const Text(
//                                 "LOG IN",
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//
//                           const SizedBox(height: 30),
//
//                           const Row(
//                             children: [
//                               Expanded(child: Divider(color: Colors.grey)),
//                               Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 10),
//                                 child: Text(
//                                   "OR",
//                                   style: TextStyle(
//                                       color: Colors.grey,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                               Expanded(child: Divider(color: Colors.grey)),
//                             ],
//                           ),
//
//                           const SizedBox(height: 30),
//
//                           // -------------------------
//                           // GOOGLE SIGN IN
//                           // -------------------------
//                           SocialSignInButton(
//                             title: "Continue with Google",
//                             iconAsset: "assets/google.png",
//                             onPressed: _isLoading
//                                 ? null
//                                 : () => context
//                                 .read<AuthBloc>()
//                                 .add(GoogleLoginEvent()),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     const SizedBox(height: 50),
//
//                     // -------------------------
//                     // SIGNUP LINK
//                     // -------------------------
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           "Don't have an account?",
//                           style: TextStyle(color: Colors.grey, fontSize: 16),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const SignupUi()),
//                             );
//                           },
//                           child: Text(
//                             "Sign Up",
//                             style: TextStyle(
//                               color: primaryColor,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//
//               // -------------------------
//               // LOADING OVERLAY
//               // -------------------------
//               if (_isLoading)
//                 Container(
//                   color: Colors.black.withOpacity(0.4),
//                   child: const Center(
//                     child: CircularProgressIndicator(color: Colors.white),
//                   ),
//                 ),
//             ],
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
import '../widgets/SocialSignInButton.dart';
import '../widgets/custom_text_field.dart';

import '../../../home/presentation/pages/home_page.dart';
import 'signup_ui.dart';

class SigninUi extends StatefulWidget {
  const SigninUi({super.key});

  @override
  State<SigninUi> createState() => _SigninUiState();
}

class _SigninUiState extends State<SigninUi> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final Color primaryColor = const Color(0xFF2196F3);
  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _submitSignIn() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(
      LoginEvent(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ),
    );
  }

  String? _emailValidator(String? v) {
    if (v == null || v.isEmpty) return "Please enter your email";
    if (!v.contains("@")) return "Enter valid email";
    return null;
  }

  String? _passwordValidator(String? v) {
    if (v == null || v.isEmpty) return "Please enter your password";
    if (v.length < 6) return "Password must be 6+ characters";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthBlocState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is AuthSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
            );
          }
        },
        builder: (context, state) {
          _isLoading = state is AuthLoading;

          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 50),
                    Center(
                      child: Image.asset(
                        'assets/study.PNG',
                        height: 180,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Welcome Back!",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 30),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
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
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _submitSignIn,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                "LOG IN",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Row(
                            children: [
                              Expanded(child: Divider(color: Colors.grey)),
                              Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "OR",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(child: Divider(color: Colors.grey)),
                            ],
                          ),
                          const SizedBox(height: 30),
                          SocialSignInButton(
                            title: "Continue with Google",
                            iconAsset: "assets/google.png",
                            onPressed: _isLoading
                                ? null
                                : () => context
                                .read<AuthBloc>()
                                .add(GoogleLoginEvent()),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignupUi()),
                            );
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (_isLoading)
                Container(
                  color: Colors.black.withOpacity(0.4),
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
