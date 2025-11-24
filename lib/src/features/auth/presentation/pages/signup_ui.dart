// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// //
// // import 'package:study_forge_ai/src/features/auth/presentation/bloc/auth_bloc.dart';
// // import 'package:study_forge_ai/src/features/auth/presentation/bloc/auth_event.dart';
// // import 'package:study_forge_ai/src/features/auth/presentation/bloc/auth_state.dart';
// //
// // import '../widgets/custom_text_field.dart';
// //
// //
// // class SignupUi extends StatefulWidget {
// //   const SignupUi({super.key});
// //
// //   @override
// //   State<SignupUi> createState() => _SignupUiState();
// // }
// //
// // class _SignupUiState extends State<SignupUi> {
// //   final _formKey = GlobalKey<FormState>();
// //   final TextEditingController nameController = TextEditingController();
// //   final TextEditingController emailController = TextEditingController();
// //   final TextEditingController passwordController = TextEditingController();
// //
// //   final Color primaryColor = const Color(0xFF2196F3);
// //
// //   @override
// //   void dispose() {
// //     nameController.dispose();
// //     emailController.dispose();
// //     passwordController.dispose();
// //     super.dispose();
// //   }
// //
// //   void submitSignup() {
// //     if (!_formKey.currentState!.validate()) return;
// //
// //     context.read<AuthBloc>().add(
// //       SignupEvent(
// //         name: nameController.text.trim(),
// //         email: emailController.text.trim(),
// //         password: passwordController.text.trim(),
// //       ),
// //     );
// //   }
// //
// //   // Validators for the text fields
// //   String? _nameValidator(String? v) => v!.isEmpty ? 'Please enter your name' : null;
// //
// //   String? _emailValidator(String? value) {
// //     if (value == null || value.isEmpty) {
// //       return 'Please enter your email';
// //     }
// //     if (!value.contains('@')) {
// //       return 'Please enter a valid email';
// //     }
// //     return null;
// //   }
// //
// //   String? _passwordValidator(String? v) => v!.length < 6
// //       ? 'Password must be at least 6 characters'
// //       : null;
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       body: BlocConsumer<AuthBloc, AuthBlocState>(
// //         listener: (context, state) {
// //           if (state is AuthFailure) {
// //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
// //           } else if (state is AuthSuccess) {
// //             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Signup Successful!")));
// //             Navigator.pop(context);
// //           }
// //         },
// //         builder: (context, state) {
// //           final isLoading = state is AuthLoading;
// //
// //           return SingleChildScrollView(
// //             padding: const EdgeInsets.all(30),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.stretch,
// //               children: [
// //                 const SizedBox(height: 50),
// //                 // --- Back Button ---
// //                 Align(
// //                   alignment: Alignment.topLeft,
// //                   child: IconButton(
// //                     icon: const Icon(Icons.arrow_back),
// //                     onPressed: () => Navigator.pop(context),
// //                   ),
// //                 ),
// //                 const SizedBox(height: 20),
// //
// //                 // --- STUDY ILLUSTRATION HEADER ---
// //                 Center(
// //                   child: Image.asset(
// //                     'assets/study.PNG', // Your book/study image
// //                     height: 160,
// //                     fit: BoxFit.contain,
// //                   ),
// //                 ),
// //                 const SizedBox(height: 20),
// //
// //                 // --- Create Account Text ---
// //                 const Text(
// //                   "Create Account",
// //                   textAlign: TextAlign.left,
// //                   style: TextStyle(
// //                       fontWeight: FontWeight.w900,
// //                       fontSize: 30,
// //                       color: Colors.black
// //                   ),
// //                 ),
// //                 const SizedBox(height: 30),
// //
// //                 // --- Form Fields ---
// //                 Form(
// //                   key: _formKey,
// //                   child: Column(
// //                     children: [
// //                       // Name input
// //                       CustomTextField(
// //                         controller: nameController,
// //                         hintText: 'Full Name',
// //                         prefixIcon: Icons.person_outline,
// //                         validator: _nameValidator,
// //                       ),
// //                       const SizedBox(height: 20),
// //                       // Email input
// //                       CustomTextField(
// //                         controller: emailController,
// //                         hintText: 'Email Address',
// //                         prefixIcon: Icons.email_outlined,
// //                         validator: _emailValidator,
// //                       ),
// //                       const SizedBox(height: 20),
// //                       // Password input
// //                       CustomTextField(
// //                         controller: passwordController,
// //                         hintText: 'Password',
// //                         prefixIcon: Icons.lock_outline,
// //                         isPassword: true,
// //                         validator: _passwordValidator,
// //                       ),
// //
// //                       const SizedBox(height: 50),
// //
// //                       // Sign Up Button
// //                       SizedBox(
// //                         width: double.infinity,
// //                         height: 50,
// //                         child: isLoading
// //                             ? const Center(child: CircularProgressIndicator(color: Color(0xFF2196F3)))
// //                             : ElevatedButton(
// //                           onPressed: submitSignup,
// //                           style: ElevatedButton.styleFrom(
// //                             backgroundColor: primaryColor,
// //                             shape: RoundedRectangleBorder(
// //                               borderRadius: BorderRadius.circular(10),
// //                             ),
// //                           ),
// //                           child: const Text(
// //                             'SIGN UP',
// //                             style: TextStyle(
// //                               fontSize: 18,
// //                               fontWeight: FontWeight.bold,
// //                               color: Colors.white,
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //
// //                 const SizedBox(height: 70),
// //
// //                 // --- Sign In Link (Bottom) ---
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     const Text(
// //                       "Already have an account?",
// //                       style: TextStyle(fontSize: 16, color: Colors.grey),
// //                     ),
// //                     TextButton(
// //                       onPressed: isLoading
// //                           ? null
// //                           : () {
// //                         Navigator.pop(context);
// //                       },
// //                       child: Text(
// //                         "Log In",
// //                         style: TextStyle(
// //                           color: primaryColor,
// //                           fontSize: 16,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 const SizedBox(height: 20),
// //               ],
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:study_forge_ai/src/features/auth/presentation/bloc/auth_bloc.dart';
// import 'package:study_forge_ai/src/features/auth/presentation/bloc/auth_event.dart';
// import 'package:study_forge_ai/src/features/auth/presentation/bloc/auth_state.dart';
// import '../../../home/presentation/pages/home_page.dart';
// import '../widgets/custom_text_field.dart';
//
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
//   String? _nameValidator(String? v) => v!.isEmpty ? 'Please enter your name' : null;
//
//   String? _emailValidator(String? value) {
//     if (value == null || value.isEmpty) return 'Please enter your email';
//     if (!value.contains('@')) return 'Please enter a valid email';
//     return null;
//   }
//
//   String? _passwordValidator(String? v) => v!.length < 6
//       ? 'Password must be at least 6 characters'
//       : null;
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
//           } else if (state is AuthSuccess) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text("Signup Successful!")),
//             );
//             // Navigate to HomePage
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (_) => const HomePage()),
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
//                 // Back Button
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: IconButton(
//                     icon: const Icon(Icons.arrow_back),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//
//                 // Study Illustration Header
//                 Center(
//                   child: Image.asset(
//                     'assets/study.PNG',
//                     height: 160,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//
//                 // Create Account Text
//                 const Text(
//                   "Create Account",
//                   style: TextStyle(
//                       fontWeight: FontWeight.w900,
//                       fontSize: 30,
//                       color: Colors.black),
//                 ),
//                 const SizedBox(height: 30),
//
//                 // Form Fields
//                 Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       CustomTextField(
//                         controller: nameController,
//                         hintText: 'Full Name',
//                         prefixIcon: Icons.person_outline,
//                         validator: _nameValidator,
//                       ),
//                       const SizedBox(height: 20),
//                       CustomTextField(
//                         controller: emailController,
//                         hintText: 'Email Address',
//                         prefixIcon: Icons.email_outlined,
//                         validator: _emailValidator,
//                       ),
//                       const SizedBox(height: 20),
//                       CustomTextField(
//                         controller: passwordController,
//                         hintText: 'Password',
//                         prefixIcon: Icons.lock_outline,
//                         isPassword: true,
//                         validator: _passwordValidator,
//                       ),
//                       const SizedBox(height: 50),
//
//                       // Sign Up Button
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
//                             'SIGN UP',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 70),
//
//                 // Sign In Link
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "Already have an account?",
//                       style: TextStyle(fontSize: 16, color: Colors.grey),
//                     ),
//                     TextButton(
//                       onPressed: isLoading
//                           ? null
//                           : () {
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
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
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
import '../../../home/presentation/pages/home_page.dart';
import '../widgets/custom_text_field.dart';

class SignupUi extends StatefulWidget {
  const SignupUi({super.key});

  @override
  State<SignupUi> createState() => _SignupUiState();
}

class _SignupUiState extends State<SignupUi> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final Color primaryColor = const Color(0xFF2196F3);

  @override
  void dispose() {
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
          final isLoading = state is AuthLoading;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 50),
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Image.asset(
                    'assets/study.PNG',
                    height: 160,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Create Account",
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
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: isLoading
                            ? const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF2196F3),
                          ),
                        )
                            : ElevatedButton(
                          onPressed: submitSignup,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "SIGN UP",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
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
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
