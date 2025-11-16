import 'package:flutter/material.dart';
import 'package:study_forge_ai/src/core/app_color/app_color.dart';
import 'package:study_forge_ai/src/core/constants/app_buttons.dart';

class SigninUi extends StatefulWidget {
  const SigninUi({super.key});

  @override
  State<SigninUi> createState() => _SigninUiState();
}

class _SigninUiState extends State<SigninUi> {
  final _formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 3f7edc
      body: Column(
        children: [
          SizedBox(height: 10),
          Center(
            child: Image.asset('assets/login.png', width: 150, height: 150),
          ),
          SizedBox(height: 5),
          Center(
            child: Text(
              "Ai Study Partner",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          SizedBox(height: 5),
          Center(
            child: Text(
              "Welcome Back !",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
          ),
          SizedBox(height: 15),
          Form(
            key: _formKey,
            child: Column(
              children: [
                // here we take input email from user for login
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    label: Text('Email'),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    label: const Text('Passeord'),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forget Password ?",
                    style: TextStyle(
                      color: Color(AppColor.primary),
                      fontSize: 22,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                appButton(title: 'SignIn', onpressed: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
