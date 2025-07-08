import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit_clone/core/constants/constants.dart';
import 'package:redit_clone/core/theme/app_pallete.dart';
import 'package:redit_clone/core/theme/app_textStyles.dart';
import 'package:redit_clone/features/Auth/view/widgets/app_button.dart';
import 'package:redit_clone/features/Auth/view/widgets/text_field.dart';
import 'package:redit_clone/features/Auth/view_model/auth_controller.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({ super.key });

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signUp() async {
    if(_formKey.currentState!.validate()){
      final authController = ref.read(authControllerProvider);
      await authController.signUpWithEmailPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
        _userNameController.text.trim()
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authController = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(Constants.logoPath,height: 80,),
                  SizedBox(height: 20,),
                  Text("User Sign Up",style: AppTextStyle.h2,),
                  SizedBox(height: 20,),
                  AppTextField(controller: _userNameController, labelText: "User Name"),
                  SizedBox(height: 15,),
                  AppTextField(controller: _emailController, labelText: "Email",validator: (value) {
                    if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                    }
                    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                    if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email';
                    }
                    return null;
                  },keyboardType: TextInputType.emailAddress,),
                  SizedBox(height: 15,),
                  AppTextField(controller: _passwordController, labelText: "Password",validator: (value) {
                    if(value==null || value.isEmpty){
                      return "Please enter Your Password";
                    }
                    if(value.length <6){
                      return "Password must be 6 characters minimum";
                    }
                    return null;
                  }, ),
                  SizedBox(height: 20,),
                  authController.isLoading
                      ? const CircularProgressIndicator()
                      : AppButton(label: "Sign Up", onPressed: _signUp, isLoading: authController.isLoading,backgroundColor: AppPallete.primaryColor,foregroundColor: AppPallete.white,)
              
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}