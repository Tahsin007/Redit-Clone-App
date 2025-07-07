import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit_clone/core/theme/app_pallete.dart';
import 'package:redit_clone/core/theme/app_textStyles.dart';
import 'package:redit_clone/features/Auth/view/widgets/text_field.dart';
import 'package:redit_clone/features/Auth/view_model/auth_controller.dart';

class SignIn extends ConsumerStatefulWidget {
  const SignIn({super.key});

  @override
  ConsumerState<SignIn> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() async {
    if (_formKey.currentState!.validate()) {
      final authController = ref.read(authControllerProvider);
      await authController.signInWithEmailPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authController = ref.watch(authControllerProvider);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Dive Into Anything",
                    style: AppTextStyle.h2.copyWith(
                      color: AppPallete.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    "assets/images/loginEmote.png",
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    controller: _emailController,
                    labelText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  AppTextField(controller: _passwordController, labelText: "Password", validator: (value) {
                    if(value==null || value.isEmpty){
                      return 'Please enter your password';
                    }
                    if(value.length<6){
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },),
                  const SizedBox(height: 24),
                  authController.isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _signIn,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppPallete.primaryColor,
                              foregroundColor: Colors.white, 
                            ),
                            child: const Text('Sign In'),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}