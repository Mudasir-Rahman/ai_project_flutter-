// import 'package:flutter/material.dart';
// import 'package:study_forge_ai/src/features/auth/domain/usecase/user_login_usecase.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:study_forge_ai/src/core/app_color/app_color.dart';
// import 'package:study_forge_ai/src/core/constants/app_buttons.dart';
// import 'package:study_forge_ai/src/features/auth/presentation/pages/signup_ui.dart';
// import 'dart:async';
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
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   bool _obscurePassword = true;
//   bool _isLoading = false;
//   @override
//   dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
//
//   // Get Supabase client instance
//   SupabaseClient get supabase => Supabase.instance.client;
//
//   Future<void> _signInWithEmail() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     try {
//       final AuthResponse response = await supabase.auth.signInWithPassword(
//         email: emailController.text.trim(),
//         password: passwordController.text,
//       );
//
//       // Success - user is signed in
//       print('User signed in: ${response.user?.email}');
//     } on AuthException catch (error) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text(error.message)));
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('An error occurred during sign in')),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   Future<void> _googleSignIn() async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     try {
//       // Use Supabase's built-in OAuth (simplest approach)
//       await supabase.auth.signInWithOAuth(
//         OAuthProvider.google,
//         redirectTo: 'https://aybarnykcohzlqhetjbe.supabase.co/auth/v1/callback',
//       );
//     } on AuthException catch (error) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text(error.message)));
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error during Google sign in: $error')),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               children: [
//                 const SizedBox(height: 10),
//                 Center(
//                   child: Image.asset(
//                     'assets/login.png',
//                     width: 130,
//                     height: 130,
//                   ),
//                 ),
//                 const SizedBox(height: 3),
//                 const Center(
//                   child: Text(
//                     "Ai Study Partner",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 const Center(
//                   child: Text(
//                     "Welcome Back !",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
//                   ),
//                 ),
//                 const SizedBox(height: 15),
//                 Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       // Email input
//                       TextFormField(
//                         controller: emailController,
//                         decoration: const InputDecoration(
//                           label: Text('Email'),
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your email';
//                           }
//                           if (!value.contains('@')) {
//                             return 'Please enter a valid email';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                       // Password input
//                       TextFormField(
//                         controller: passwordController,
//                         obscureText: _obscurePassword,
//                         decoration: InputDecoration(
//                           label: const Text('Password'),
//                           border: const OutlineInputBorder(),
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               _obscurePassword
//                                   ? Icons.visibility_off
//                                   : Icons.visibility,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 _obscurePassword = !_obscurePassword;
//                               });
//                             },
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your password';
//                           }
//                           if (value.length < 6) {
//                             return 'Password must be at least 6 characters';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 20),
//
//                       TextButton(
//                         onPressed: () {},
//                         child: Text(
//                           "Forget Password ?",
//                           style: TextStyle(
//                             color: Color(AppColor.primary),
//                             fontSize: 22,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 30),
//                       appButton(
//                         title: 'Sign In',
//                         onpressed: _signInWithEmail, // FIXED: removed !
//                       ),
//                       SizedBox(height: 20),
//                       appButton(
//                         title: 'Create Account',
//                         onpressed: _isLoading
//                             ? () {}
//                             : () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => const SignupUi(),
//                                   ),
//                                 );
//                               },
//                       ),
//                       SizedBox(height: 20),
//                       Row(
//                         children: <Widget>[
//                           Expanded(
//                             child: Divider(
//                               color: Colors.grey,
//                               thickness: 1,
//                               endIndent: 10,
//                             ),
//                           ),
//                           Text(
//                             "OR",
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Expanded(
//                             child: Divider(
//                               color: Colors.grey,
//                               thickness: 1,
//                               indent: 10,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       // Google Sign In Button
//                       OutlinedButton.icon(
//                         icon: Image.asset(
//                           'assets/google.png',
//                           width: 24,
//                           height: 24,
//                         ),
//                         label: const Text(
//                           'Sign in with Google',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                         onPressed: _isLoading ? null : _googleSignIn,
//                         style: OutlinedButton.styleFrom(
//                           padding: EdgeInsets.symmetric(vertical: 12),
//                           side: BorderSide(color: Colors.grey),
//                           minimumSize: Size(double.infinity, 50),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           if (_isLoading)
//             Container(
//               color: Colors.black.withOpacity(0.5),
//               child: const Center(child: CircularProgressIndicator()),
//             ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:study_forge_ai/src/features/auth/presentation/pages/signup_ui.dart';
import 'dart:async';

import '../widgets/SocialSignInButton.dart';
import '../widgets/custom_text_field.dart';

// ====================================================================
// SigninUi (Login Page)
// ====================================================================
class SigninUi extends StatefulWidget {
  const SigninUi({super.key});

  @override
  State<SigninUi> createState() => _SigninUiState();
}

class _SigninUiState extends State<SigninUi> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  final Color primaryColor = const Color(0xFF2196F3); // Blue for Log In button

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Get Supabase client instance
  SupabaseClient get supabase => Supabase.instance.client;

  Future<void> _signInWithEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final AuthResponse response = await supabase.auth.signInWithPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      if (response.user != null) {
        print('User signed in: ${response.user?.email}');
        // TODO: Navigate to the main app screen
      }
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message)));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred during sign in')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _googleSignIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'https://aybarnykcohzlqhetjbe.supabase.co/auth/v1/callback',
      );
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message)));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error during Google sign in: $error')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Validators for the text fields
  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 50),

                // --- STUDY ILLUSTRATION HEADER ---
                Center(
                  child: Image.asset(
                    'assets/study.PNG', // Your book/study image
                    height: 180,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    "AI Study Partner",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // --- Welcome Back Text ---
                const Text(
                  "Welcome Back!",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 30),

                // --- Form Fields ---
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email input using the new reusable widget
                      CustomTextField(
                        controller: emailController,
                        hintText: 'Email Address',
                        prefixIcon: Icons.email_outlined,
                        validator: _emailValidator,
                      ),
                      const SizedBox(height: 20),
                      // Password input using the new reusable widget
                      CustomTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        prefixIcon: Icons.lock_outline,
                        isPassword: true,
                        validator: _passwordValidator,
                      ),
                      const SizedBox(height: 10),

                      // Forgot Password Link
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Log In Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _signInWithEmail,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'LOG IN',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // OR Divider
                      const Row(
                        children: <Widget>[
                          Expanded(child: Divider(color: Colors.grey, thickness: 1)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text("OR", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)),
                          ),
                          Expanded(child: Divider(color: Colors.grey, thickness: 1)),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // Google Sign In Button
                      SocialSignInButton(
                        title: 'Continue with Google',
                        iconAsset: 'assets/google.png', // Corrected to use the path passed by the caller
                        onPressed: _isLoading ? null : _googleSignIn,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // --- Sign Up Link (Bottom) ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupUi(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // --- Loading Overlay ---
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(child: CircularProgressIndicator(color: Colors.white)),
            ),
        ],
      ),
    );
  }
}